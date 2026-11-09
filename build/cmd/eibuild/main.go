// eibuild builds EItweaks from the repository's source data: per language, an EI starter mod zip and a standalone zip,
// and the payload of the one installer.
//
//	eibuild build <repo> <version> <out>   write <out>/eitweaks-<version>-<lang>-{starter,standalone}.zip and SHA256SUMS
//	eibuild xlsx <csv-dir> <out.xlsx>      a database's CSV sheets as one workbook, for spreadsheet editing
//	eibuild csv <in.xlsx> <csv-dir>        a workbook back to CSV sheets, cell text verbatim
//	eibuild payload <dir> <version> <out>  the installer's payload, from the starter zips in <dir>
//
// The build calls um-multitool, expected on PATH as in the image built from build/Containerfile.
package main

import (
	"archive/zip"
	"bytes"
	"crypto/sha256"
	"encoding/hex"
	"errors"
	"fmt"
	"io/fs"
	"os"
	"os/exec"
	"path/filepath"
	"sort"
	"strings"
	"time"

	"eitweaks/build/internal/xlsxcsv"
)

// Every file packed into a .res archive or the zip carries this time, so the output depends on content only.
var epoch = time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC)

var databases = []string{"database", "databaselmp"}

// The mod's archives that hold only a few of the game's entries: the starter merges them into the game's archives,
// while a standalone copy would replace the whole archive, so the standalone release leaves them out.
var partialArchives = []string{filepath.Join("res", "textures.res")}

// starterOnly lists the mod's files the standalone version leaves out: the starter's config, eix's add-on and its
// settings, and Universal Mod's runtime, which the game's own exe runs none of, and the partial archives.
func starterOnly() []string {
	return append([]string{"config.reg", "addon.dll", "eix.ini", "spelladdon.ini", "eix-LICENSE.txt",
		"eix-THIRD-PARTY-NOTICES.txt", "um.dll", "um.cfg", "um-LICENSE.txt", "um-source.tar.gz", "d7vk.dll",
		"d7vk-LICENSE.txt"}, partialArchives...)
}

// The folder names of each language's GOG install where they are not lowercase. Windows ignores case when the
// standalone release is copied over the game; Wine on a case-sensitive file system would get a second folder.
var gogFolders = map[string]map[string]string{
	"ru": {"config": "Config", "maps": "Maps", "res": "Res"},
	"de": {"maps": "Maps", "res": "Res"},
}

// eixPackage returns the files of the one vendored eix release package, keyed by their names inside its top folder.
func eixPackage(vendor string) (map[string][]byte, error) {
	zips, err := filepath.Glob(filepath.Join(vendor, "eix", "eix-*.zip"))
	if err != nil {
		return nil, err
	}
	if len(zips) != 1 {
		return nil, fmt.Errorf("%s: want exactly one eix-*.zip, found %d", filepath.Join(vendor, "eix"), len(zips))
	}
	files, err := readZip(zips[0])
	if err != nil {
		return nil, err
	}
	top := strings.TrimSuffix(filepath.Base(zips[0]), ".zip") + "/"
	pkg := map[string][]byte{}
	for name, data := range files {
		rest, ok := strings.CutPrefix(name, top)
		if !ok {
			return nil, fmt.Errorf("%s: entry %s is outside %s", zips[0], name, top)
		}
		pkg[rest] = data
	}
	return pkg, nil
}

func main() {
	if len(os.Args) < 2 {
		usage()
	}
	var err error
	switch args := os.Args[2:]; {
	case os.Args[1] == "build" && len(args) == 3:
		err = build(args[0], args[1], args[2])
	case os.Args[1] == "xlsx" && len(args) == 2:
		err = xlsxcsv.Import(args[0], args[1])
	case os.Args[1] == "csv" && len(args) == 2:
		err = xlsxcsv.Export(args[0], args[1])
	case os.Args[1] == "payload" && len(args) == 3:
		err = payload(args[0], args[1], args[2])
	default:
		usage()
	}
	if err != nil {
		fmt.Fprintln(os.Stderr, "eibuild:", err)
		os.Exit(1)
	}
}

func usage() {
	fmt.Fprintln(os.Stderr, "usage: eibuild build <repo> <version> <out> | xlsx <csv-dir> <out.xlsx> | csv <in.xlsx> <csv-dir> | payload <dir> <version> <out>")
	os.Exit(2)
}

// ---- helpers ----

// um runs um-multitool; on failure its combined output is part of the error.
func um(args ...string) error {
	out, err := exec.Command("um-multitool", args...).CombinedOutput()
	if err != nil {
		return fmt.Errorf("um-multitool %s: %w\n%s", strings.Join(args, " "), err, out)
	}
	return nil
}

func copyFile(src, dst string) error {
	data, err := os.ReadFile(src)
	if err != nil {
		return err
	}
	if err := os.MkdirAll(filepath.Dir(dst), 0o755); err != nil {
		return err
	}
	return os.WriteFile(dst, data, 0o644)
}

// copyTree copies every regular file under src into dst, keeping relative paths.
func copyTree(src, dst string) error {
	return filepath.WalkDir(src, func(p string, d fs.DirEntry, err error) error {
		if err != nil || d.IsDir() {
			return err
		}
		rel, err := filepath.Rel(src, p)
		if err != nil {
			return err
		}
		return copyFile(p, filepath.Join(dst, rel))
	})
}

func listFiles(dir string) ([]string, error) {
	var names []string
	err := filepath.WalkDir(dir, func(p string, d fs.DirEntry, err error) error {
		if err != nil || d.IsDir() {
			return err
		}
		r, err := filepath.Rel(dir, p)
		names = append(names, filepath.ToSlash(r))
		return err
	})
	sort.Strings(names)
	return names, err
}

// pack builds a .res archive from a copy of dir: restool records file times, which are pinned to epoch.
func pack(dir, res, work string) error {
	tmp, err := os.MkdirTemp(work, "pack-")
	if err != nil {
		return err
	}
	if err := copyTree(dir, tmp); err != nil {
		return err
	}
	if err := filepath.WalkDir(tmp, func(p string, d fs.DirEntry, err error) error {
		if err != nil || d.IsDir() {
			return err
		}
		return os.Chtimes(p, epoch, epoch)
	}); err != nil {
		return err
	}
	if err := os.MkdirAll(filepath.Dir(res), 0o755); err != nil {
		return err
	}
	return um("restool", "--pack", "--no-strip-ext", tmp, "-o", res)
}

// sameTrees returns the first difference between two directory trees, or "" when identical.
func sameTrees(a, b string) (string, error) {
	na, err := listFiles(a)
	if err != nil {
		return "", err
	}
	nb, err := listFiles(b)
	if err != nil {
		return "", err
	}
	if strings.Join(na, "\n") != strings.Join(nb, "\n") {
		return fmt.Sprintf("file lists differ (%d vs %d files)", len(na), len(nb)), nil
	}
	for _, n := range na {
		x, err := os.ReadFile(filepath.Join(a, n))
		if err != nil {
			return "", err
		}
		y, err := os.ReadFile(filepath.Join(b, n))
		if err != nil {
			return "", err
		}
		if !bytes.Equal(x, y) {
			return n + " differs", nil
		}
	}
	return "", nil
}

// ---- build ----

// The texts.res entry the main menu shows as the version: its placeholder becomes the version being built, so the
// menu cannot fall behind a release.
const (
	versionEntry       = "string version_name"
	versionPlaceholder = "{EITWEAKS_VERSION}"
)

func setVersion(path, version string) error {
	text, err := os.ReadFile(path)
	if err != nil {
		return err
	}
	if !bytes.Contains(text, []byte(versionPlaceholder)) {
		return fmt.Errorf("%s: no %s to replace", path, versionPlaceholder)
	}
	return os.WriteFile(path, bytes.ReplaceAll(text, []byte(versionPlaceholder), []byte(version)), 0o644)
}

func build(repo, version, out string) error {
	work, err := os.MkdirTemp("", "eibuild-")
	if err != nil {
		return err
	}
	defer os.RemoveAll(work)

	// Everything but lang/<lang> is the same for every language: mod/ and the vendored runtime.
	src := filepath.Join(repo, "mod")
	vendor := filepath.Join(repo, "vendor")
	common := filepath.Join(work, "common")
	for _, db := range databases {
		if err := buildDatabase(filepath.Join(src, "res", db), filepath.Join(common, "res", db+".res"), filepath.Join(work, db)); err != nil {
			return err
		}
	}
	if err := pack(filepath.Join(src, "res", "textures"), filepath.Join(common, "res", "textures.res"), work); err != nil {
		return err
	}
	if err := copyTree(filepath.Join(src, "maps"), filepath.Join(common, "maps")); err != nil {
		return err
	}
	configs, err := filepath.Glob(filepath.Join(src, "config", "*.ini"))
	if err != nil {
		return err
	}
	for _, c := range configs {
		if filepath.Base(c) == "ai.ini" {
			continue // source of ai.reg below
		}
		if err := copyFile(c, filepath.Join(common, "config", filepath.Base(c))); err != nil {
			return err
		}
	}
	if err := um("inireg", "--ini2reg", filepath.Join(src, "config", "ai.ini"), "-o", filepath.Join(common, "config", "ai.reg")); err != nil {
		return err
	}
	// eix's loader loads an addon.dll from the selected mod's folder in place of the launcher's own, so eix's add-on
	// runs for this mod only. The loader itself replaces the launcher's, in its Engine folder.
	eix, err := eixPackage(vendor)
	if err != nil {
		return err
	}
	for src, dst := range map[string]string{
		"addon.dll":               "addon.dll",
		"LICENSE":                 "eix-LICENSE.txt",
		"THIRD-PARTY-NOTICES.txt": "eix-THIRD-PARTY-NOTICES.txt",
	} {
		data, ok := eix[src]
		if !ok {
			return fmt.Errorf("the eix package has no %s", src)
		}
		if err := os.WriteFile(filepath.Join(common, dst), data, 0o644); err != nil {
			return err
		}
	}
	loader, ok := eix["dinput.dll"]
	if !ok {
		return errors.New("the eix package has no dinput.dll")
	}
	engine := filepath.Join(work, "engine")
	if err := os.MkdirAll(engine, 0o755); err != nil {
		return err
	}
	if err := os.WriteFile(filepath.Join(engine, "dinput.dll"), loader, 0o644); err != nil {
		return err
	}
	for _, file := range []struct{ src, dst string }{
		{"universal-mod/um.dll", "um.dll"},
		{"universal-mod/LICENSE", "um-LICENSE.txt"},
		{"universal-mod/source.tar.gz", "um-source.tar.gz"},
		{"d7vk/d7vk.dll", "d7vk.dll"},
		{"d7vk/LICENSE", "d7vk-LICENSE.txt"},
	} {
		if err := copyFile(filepath.Join(vendor, file.src), filepath.Join(common, file.dst)); err != nil {
			return err
		}
	}
	if err := copyFile(filepath.Join(src, "um.cfg"), filepath.Join(common, "um.cfg")); err != nil {
		return err
	}
	// eix reads eix.ini, and its built-in SpellAddon reads a spelladdon.ini, from the active mod's folder first, so
	// these settings apply to EItweaks only.
	for _, name := range []string{"eix.ini", "spelladdon.ini"} {
		if err := copyFile(filepath.Join(src, name), filepath.Join(common, name)); err != nil {
			return err
		}
	}
	modIni, err := os.ReadFile(filepath.Join(src, "config.ini"))
	if err != nil {
		return err
	}

	langDirs, err := os.ReadDir(filepath.Join(repo, "lang"))
	if err != nil {
		return err
	}
	if err := os.MkdirAll(out, 0o755); err != nil {
		return err
	}
	var sums []string
	for _, l := range langDirs {
		lang := l.Name()
		mod := filepath.Join(work, "mod-"+lang)
		if err := copyTree(common, mod); err != nil {
			return err
		}
		// lang/<lang> mirrors the mod: res/<archive> folders are packed, everything else is copied as is.
		langSrc := filepath.Join(repo, "lang", lang)
		entries, err := os.ReadDir(langSrc)
		if err != nil {
			return err
		}
		for _, e := range entries {
			if e.Name() != "res" {
				if err := copyTree(filepath.Join(langSrc, e.Name()), filepath.Join(mod, e.Name())); err != nil {
					return err
				}
			}
		}
		archives, err := os.ReadDir(filepath.Join(langSrc, "res"))
		if err != nil {
			return err
		}
		var extra []string
		for _, a := range archives {
			dir := filepath.Join(langSrc, "res", a.Name())
			if a.Name() == "texts" {
				staged := filepath.Join(work, "texts-"+lang)
				if err := copyTree(dir, staged); err != nil {
					return err
				}
				if err := setVersion(filepath.Join(staged, versionEntry), version); err != nil {
					return err
				}
				dir = staged
			}
			if err := pack(dir, filepath.Join(mod, "res", a.Name()+".res"), work); err != nil {
				return err
			}
			if !strings.Contains(string(modIni), "\n"+a.Name()+".res=") {
				// Archives only some languages ship (textslmp) are added to [RES] per language.
				extra = append(extra, a.Name()+`.res=res\`+a.Name()+".res")
			}
		}
		ini := strings.Replace(string(modIni), "[RES]\n", "[RES]\n"+strings.Join(append(extra, ""), "\n"), 1)
		if len(extra) > 0 && ini == string(modIni) {
			return errors.New("mod/config.ini: no [RES] section")
		}
		iniPath := filepath.Join(work, "config-"+lang+".ini")
		if err := os.WriteFile(iniPath, []byte(ini), 0o644); err != nil {
			return err
		}
		if err := um("inireg", "--ini2reg", iniPath, "-o", filepath.Join(mod, "config.reg")); err != nil {
			return err
		}
		// The standalone release is copied over the game's own files, where an archive replaces the game's whole.
		standalone := filepath.Join(work, "standalone-"+lang)
		if err := copyTree(mod, standalone); err != nil {
			return err
		}
		for _, f := range starterOnly() {
			if err := os.Remove(filepath.Join(standalone, f)); err != nil && !errors.Is(err, fs.ErrNotExist) {
				return err
			}
		}
		for from, to := range gogFolders[lang] {
			if err := os.Rename(filepath.Join(standalone, from), filepath.Join(standalone, to)); err != nil && !errors.Is(err, fs.ErrNotExist) {
				return err
			}
		}
		for _, v := range []struct {
			variant string
			folders []zipFolder
		}{
			// The starter zip's Engine folder goes into the launcher's.
			{"starter", []zipFolder{{mod, "eitweaks"}, {engine, "Engine"}}},
			{"standalone", []zipFolder{{standalone, "eitweaks"}}},
		} {
			name := fmt.Sprintf("eitweaks-%s-%s-%s.zip", version, lang, v.variant)
			zipPath := filepath.Join(out, name)
			if err := writeZip(v.folders, zipPath); err != nil {
				return err
			}
			data, err := os.ReadFile(zipPath)
			if err != nil {
				return err
			}
			sum := sha256.Sum256(data)
			sums = append(sums, hex.EncodeToString(sum[:])+"  "+name)
		}
	}
	return os.WriteFile(filepath.Join(out, "SHA256SUMS"), []byte(strings.Join(sums, "\n")+"\n"), 0o644)
}

// buildDatabase compiles <dbSrc>/csv with xlsxdb, packs the result with <dbSrc>/extra (the entries xlsxdb does
// not produce), then exports the archive again and requires the export to equal the CSVs.
func buildDatabase(dbSrc, res, work string) error {
	if err := os.MkdirAll(work, 0o755); err != nil {
		return err
	}
	csvDir := filepath.Join(dbSrc, "csv")
	xlsx := filepath.Join(work, "source.xlsx")
	if err := xlsxcsv.Import(csvDir, xlsx); err != nil {
		return err
	}
	compiledRes := filepath.Join(work, "compiled.res")
	if err := um("xlsxdb", "--no-check", xlsx, "-o", compiledRes); err != nil {
		return err
	}
	entries := filepath.Join(work, "entries")
	if err := um("restool", compiledRes, "-o", entries); err != nil {
		return err
	}
	// A database whose entries all come from xlsxdb has no extra/ directory.
	if err := copyTree(filepath.Join(dbSrc, "extra"), entries); err != nil && !errors.Is(err, fs.ErrNotExist) {
		return err
	}
	if err := pack(entries, res, work); err != nil {
		return err
	}
	back := filepath.Join(work, "back.xlsx")
	if err := um("dbexport", res, "-o", back); err != nil {
		return err
	}
	check := filepath.Join(work, "check")
	if err := xlsxcsv.Export(back, check); err != nil {
		return err
	}
	diff, err := sameTrees(csvDir, check)
	if err != nil {
		return err
	}
	if diff != "" {
		return fmt.Errorf("%s: the compiled database does not export back to its CSVs: %s", dbSrc, diff)
	}
	return nil
}

type zipFolder struct{ dir, top string }

// writeZip zips each folder's files under its top folder name, with sorted entries and fixed times.
func writeZip(folders []zipFolder, zipPath string) error {
	var buf bytes.Buffer
	zw := zip.NewWriter(&buf)
	for _, f := range folders {
		names, err := listFiles(f.dir)
		if err != nil {
			return err
		}
		for _, n := range names {
			data, err := os.ReadFile(filepath.Join(f.dir, n))
			if err != nil {
				return err
			}
			w, err := zw.CreateHeader(&zip.FileHeader{Name: f.top + "/" + n, Method: zip.Deflate, Modified: epoch})
			if err != nil {
				return err
			}
			if _, err := w.Write(data); err != nil {
				return err
			}
		}
	}
	if err := zw.Close(); err != nil {
		return err
	}
	return os.WriteFile(zipPath, buf.Bytes(), 0o644)
}

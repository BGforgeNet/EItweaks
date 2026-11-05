package main

import (
	"archive/zip"
	"bytes"
	"crypto/sha256"
	"encoding/hex"
	"fmt"
	"io"
	"os"
	"path/filepath"
	"sort"
	"strings"
)

// payload writes the installer's payload from the starter zips in dir: under common/ the mod's files that every
// language has with the same content, stored once; under <lang>/ the rest; SpellAddon/; and files.iss, the
// installer's [Files] entries for the mod in both versions. The standalone version installs the same files minus
// starterOnly, into the game's own folders.
func payload(dir, version, dst string) error {
	zips, err := filepath.Glob(filepath.Join(dir, "eitweaks-"+version+"-*-starter.zip"))
	if err != nil {
		return err
	}
	if len(zips) == 0 {
		return fmt.Errorf("%s: no eitweaks-%s-*-starter.zip", dir, version)
	}
	mods := map[string]map[string][]byte{}
	var langs []string
	var spellAddon map[string][]byte
	for _, z := range zips {
		lang := strings.TrimSuffix(strings.TrimPrefix(filepath.Base(z), "eitweaks-"+version+"-"), "-starter.zip")
		files, err := readZip(z)
		if err != nil {
			return err
		}
		mods[lang] = map[string][]byte{}
		addon := map[string][]byte{}
		for name, data := range files {
			switch top, rest, _ := strings.Cut(name, "/"); top {
			case "eitweaks":
				mods[lang][rest] = data
			case "SpellAddon":
				addon[rest] = data
			default:
				return fmt.Errorf("%s: unexpected entry %s", z, name)
			}
		}
		spellAddon = addon
		langs = append(langs, lang)
	}
	sort.Strings(langs)

	trees := map[string]map[string][]byte{"common": {}}
	for name, data := range mods[langs[0]] {
		shared := true
		for _, l := range langs[1:] {
			if other, ok := mods[l][name]; !ok || !bytes.Equal(other, data) {
				shared = false
				break
			}
		}
		if shared {
			trees["common"][name] = data
		}
	}
	for _, l := range langs {
		trees[l] = map[string][]byte{}
		for name, data := range mods[l] {
			if _, ok := trees["common"][name]; !ok {
				trees[l][name] = data
			}
		}
	}
	trees["SpellAddon"] = spellAddon
	for tree, files := range trees {
		for name, data := range files {
			p := filepath.Join(dst, tree, filepath.FromSlash(name))
			if err := os.MkdirAll(filepath.Dir(p), 0o755); err != nil {
				return err
			}
			if err := os.WriteFile(p, data, 0o644); err != nil {
				return err
			}
		}
	}
	return os.WriteFile(filepath.Join(dst, "files.iss"), []byte(filesISS(trees, langs)), 0o644)
}

func readZip(zipPath string) (map[string][]byte, error) {
	zr, err := zip.OpenReader(zipPath)
	if err != nil {
		return nil, err
	}
	defer zr.Close()
	files := map[string][]byte{}
	for _, f := range zr.File {
		if !filepath.IsLocal(f.Name) {
			return nil, fmt.Errorf("%s: entry %q leaves the target folder", zipPath, f.Name)
		}
		if f.FileInfo().IsDir() {
			continue
		}
		r, err := f.Open()
		if err != nil {
			return nil, err
		}
		data, err := io.ReadAll(r)
		r.Close()
		if err != nil {
			return nil, fmt.Errorf("%s: %s: %w", zipPath, f.Name, err)
		}
		files[f.Name] = data
	}
	return files, nil
}

// filesISS writes the installer's [Files] entries for the mod and a fingerprint of each language's texts.res. The
// starter version installs each tree whole into the mod's folder. The standalone version installs each top-level
// folder into the game's folder of that name, whatever its case, minus starterOnly; its root files go to the game's
// root. IsStarter, IsStandalone, IsGameLang, GameSubdir and Backup are the installer's.
func filesISS(trees map[string]map[string][]byte, langs []string) string {
	excluded := map[string]bool{}
	for _, f := range starterOnly() {
		excluded[filepath.ToSlash(f)] = true
	}
	var b strings.Builder
	b.WriteString("; Written by eibuild payload.\n\n")
	for _, l := range langs {
		if data, ok := trees[l]["res/texts.res"]; ok {
			sum := sha256.Sum256(data)
			fmt.Fprintf(&b, "#define TextsSHA256_%s \"%s\"\n", l, hex.EncodeToString(sum[:]))
		}
	}
	b.WriteString("\n[Files]\n")
	for _, tree := range append([]string{"common"}, langs...) {
		check := "IsStarter"
		standaloneCheck := "IsStandalone"
		if tree != "common" {
			check += " and IsGameLang('" + tree + "')"
			standaloneCheck += " and IsGameLang('" + tree + "')"
		}
		fmt.Fprintf(&b, "Source: \"payload\\%s\\*\"; DestDir: \"{app}\\mods\\eitweaks\"; Excludes: \"um.cfg\"; Flags: recursesubdirs createallsubdirs ignoreversion; Check: %s\n", tree, check)
		if _, ok := trees[tree]["um.cfg"]; ok {
			fmt.Fprintf(&b, "Source: \"payload\\%s\\um.cfg\"; DestDir: \"{app}\\mods\\eitweaks\"; Flags: onlyifdoesntexist; Check: %s\n", tree, check)
		}
		var names []string
		for name := range trees[tree] {
			names = append(names, name)
		}
		sort.Strings(names)
		dirs := map[string][]string{}
		var dirOrder []string
		for _, name := range names {
			top, rest, inDir := strings.Cut(name, "/")
			if !inDir {
				if !excluded[name] {
					fmt.Fprintf(&b, "Source: \"payload\\%s\\%s\"; DestDir: \"{app}\"; Flags: ignoreversion; Check: %s; BeforeInstall: Backup\n", tree, name, standaloneCheck)
				}
				continue
			}
			if _, seen := dirs[top]; !seen {
				dirOrder = append(dirOrder, top)
				dirs[top] = nil
			}
			if excluded[name] {
				dirs[top] = append(dirs[top], "\\"+strings.ReplaceAll(rest, "/", "\\"))
			}
		}
		for _, top := range dirOrder {
			excludes := ""
			if len(dirs[top]) > 0 {
				excludes = "; Excludes: \"" + strings.Join(dirs[top], ",") + "\""
			}
			fmt.Fprintf(&b, "Source: \"payload\\%s\\%s\\*\"; DestDir: \"{app}\\{code:GameSubdir|%s}\"; Flags: recursesubdirs createallsubdirs ignoreversion skipifsourcedoesntexist%s; Check: %s; BeforeInstall: Backup\n",
				tree, top, top, excludes, standaloneCheck)
		}
	}
	return b.String()
}

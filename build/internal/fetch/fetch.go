// Package fetch downloads the files a manifest lists and checks each against its SHA256.
package fetch

import (
	"bufio"
	"crypto/sha256"
	"encoding/hex"
	"errors"
	"fmt"
	"io"
	"net/http"
	"os"
	"path/filepath"
	"strings"
	"time"
)

// Entry is one manifest line: a file's name in the download folder, its SHA256 in hex, and its URL.
type Entry struct {
	Name, SHA256, URL string
}

// Parse reads a manifest: one entry per line as "<name> <sha256> <url>"; blank lines and lines starting with # are
// skipped.
func Parse(r io.Reader) ([]Entry, error) {
	var entries []Entry
	seen := map[string]bool{}
	sc := bufio.NewScanner(r)
	for n := 1; sc.Scan(); n++ {
		line := strings.TrimSpace(sc.Text())
		if line == "" || strings.HasPrefix(line, "#") {
			continue
		}
		f := strings.Fields(line)
		if len(f) != 3 {
			return nil, fmt.Errorf("line %d: want <name> <sha256> <url>, got %d fields", n, len(f))
		}
		e := Entry{Name: f[0], SHA256: strings.ToLower(f[1]), URL: f[2]}
		if e.Name != filepath.Base(e.Name) || e.Name == "." || e.Name == ".." {
			return nil, fmt.Errorf("line %d: name %q is not a plain file name", n, e.Name)
		}
		if sum, err := hex.DecodeString(e.SHA256); err != nil || len(sum) != sha256.Size {
			return nil, fmt.Errorf("line %d: %q is not a SHA256", n, f[1])
		}
		if !strings.HasPrefix(e.URL, "https://") {
			return nil, fmt.Errorf("line %d: URL %q is not https", n, e.URL)
		}
		if seen[e.Name] {
			return nil, fmt.Errorf("line %d: %s listed twice", n, e.Name)
		}
		seen[e.Name] = true
		entries = append(entries, e)
	}
	return entries, sc.Err()
}

// All makes dir hold every entry with its checksum: a file already there with the right checksum is kept, any other
// is downloaded again.
func All(client *http.Client, entries []Entry, dir string) error {
	if err := os.MkdirAll(dir, 0o755); err != nil {
		return err
	}
	for _, e := range entries {
		path := filepath.Join(dir, e.Name)
		if sum, err := fileSHA256(path); err == nil && sum == e.SHA256 {
			continue
		} else if err != nil && !errors.Is(err, os.ErrNotExist) {
			return err
		}
		if err := download(client, e, path); err != nil {
			return fmt.Errorf("%s: %w", e.Name, err)
		}
	}
	return nil
}

// NewClient returns the client All uses outside tests.
func NewClient() *http.Client {
	return &http.Client{Timeout: 10 * time.Minute}
}

func fileSHA256(path string) (string, error) {
	f, err := os.Open(path)
	if err != nil {
		return "", err
	}
	defer f.Close()
	h := sha256.New()
	if _, err := io.Copy(h, f); err != nil {
		return "", err
	}
	return hex.EncodeToString(h.Sum(nil)), nil
}

// download writes the entry to a temporary file beside path and renames it into place only once its checksum
// matches, so path never holds a partial or wrong file.
func download(client *http.Client, e Entry, path string) (err error) {
	resp, err := client.Get(e.URL)
	if err != nil {
		return err
	}
	defer resp.Body.Close()
	if resp.StatusCode != http.StatusOK {
		return fmt.Errorf("GET %s: %s", e.URL, resp.Status)
	}
	tmp, err := os.CreateTemp(filepath.Dir(path), e.Name+".part-")
	if err != nil {
		return err
	}
	defer func() {
		if err != nil {
			_ = os.Remove(tmp.Name()) // The download's own error is the one to report.
		}
	}()
	h := sha256.New()
	if _, err := io.Copy(io.MultiWriter(tmp, h), resp.Body); err != nil {
		_ = tmp.Close() // The copy's error is the one to report.
		return fmt.Errorf("GET %s: %w", e.URL, err)
	}
	if err := tmp.Close(); err != nil {
		return err
	}
	if got := hex.EncodeToString(h.Sum(nil)); got != e.SHA256 {
		return fmt.Errorf("%s has SHA256 %s, the manifest pins %s", e.URL, got, e.SHA256)
	}
	return os.Rename(tmp.Name(), path)
}

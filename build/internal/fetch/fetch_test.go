package fetch

import (
	"crypto/sha256"
	"encoding/hex"
	"net/http"
	"net/http/httptest"
	"os"
	"path/filepath"
	"strings"
	"sync/atomic"
	"testing"
)

func sum(b string) string {
	s := sha256.Sum256([]byte(b))
	return hex.EncodeToString(s[:])
}

func TestParse(t *testing.T) {
	m := "# comment\n\na.zip " + strings.ToUpper(sum("a")) + " https://example.org/a.zip\n"
	got, err := Parse(strings.NewReader(m))
	if err != nil {
		t.Fatal(err)
	}
	want := Entry{Name: "a.zip", SHA256: sum("a"), URL: "https://example.org/a.zip"}
	if len(got) != 1 || got[0] != want {
		t.Fatalf("got %+v, want [%+v]", got, want)
	}
}

func TestParseRejects(t *testing.T) {
	for name, line := range map[string]string{
		"fields":    "a.zip " + sum("a"),
		"path":      "../a.zip " + sum("a") + " https://example.org/a",
		"sha":       "a.zip abc https://example.org/a",
		"http":      "a.zip " + sum("a") + " http://example.org/a",
		"duplicate": "a.zip " + sum("a") + " https://example.org/a\na.zip " + sum("a") + " https://example.org/b",
	} {
		if _, err := Parse(strings.NewReader(line)); err == nil {
			t.Errorf("%s: no error for %q", name, line)
		}
	}
}

func TestAll(t *testing.T) {
	// The server's handler runs on its own goroutines.
	var gets atomic.Int32
	srv := httptest.NewTLSServer(http.HandlerFunc(func(w http.ResponseWriter, r *http.Request) {
		gets.Add(1)
		_, _ = w.Write([]byte(strings.TrimPrefix(r.URL.Path, "/")))
	}))
	t.Cleanup(srv.Close)
	dir := t.TempDir()
	good := []Entry{{Name: "a", SHA256: sum("a"), URL: srv.URL + "/a"}}

	if err := All(srv.Client(), good, dir); err != nil {
		t.Fatal(err)
	}
	if b, err := os.ReadFile(filepath.Join(dir, "a")); err != nil || string(b) != "a" {
		t.Fatalf("a = %q, %v", b, err)
	}
	// A file with the right checksum is not downloaded again; one with another is.
	if err := All(srv.Client(), good, dir); err != nil || gets.Load() != 1 {
		t.Fatalf("second run: %v, %d requests", err, gets.Load())
	}
	if err := os.WriteFile(filepath.Join(dir, "a"), []byte("stale"), 0o644); err != nil {
		t.Fatal(err)
	}
	if err := All(srv.Client(), good, dir); err != nil || gets.Load() != 2 {
		t.Fatalf("stale run: %v, %d requests", err, gets.Load())
	}

	bad := []Entry{{Name: "b", SHA256: sum("not b"), URL: srv.URL + "/b"}}
	if err := All(srv.Client(), bad, dir); err == nil || !strings.Contains(err.Error(), "pins") {
		t.Fatalf("mismatch: %v", err)
	}
	if left, _ := filepath.Glob(filepath.Join(dir, "b*")); len(left) != 0 {
		t.Fatalf("mismatch left %v", left)
	}
}

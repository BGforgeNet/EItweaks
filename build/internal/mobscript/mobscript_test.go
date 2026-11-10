package mobscript

import (
	"bytes"
	"encoding/binary"
	"strings"
	"testing"
)

func chunkOf(id uint32, body []byte) []byte {
	b := binary.LittleEndian.AppendUint32(nil, id)
	b = binary.LittleEndian.AppendUint32(b, uint32(headerSize+len(body)))
	return append(b, body...)
}

// codedBody is a coded script chunk body: the seed, then the coded text.
func codedBody(seed uint32, text string) []byte {
	body := binary.LittleEndian.AppendUint32(nil, seed)
	body = append(body, text...)
	xorStream(seed, body[seedSize:])
	return body
}

// mob builds a map: a leading chunk, the root with the given children, and a trailing chunk.
func mob(children ...[]byte) []byte {
	other := chunkOf(0x1234, []byte{1, 2, 3})
	root := chunkOf(rootID, bytes.Join(children, nil))
	return bytes.Join([][]byte{chunkOf(0x77, []byte("head")), root, other, chunkOf(0x31415926, []byte("tail"))}, nil)
}

func TestExtractCoded(t *testing.T) {
	text := "script\r\nbody\r\n)\r\n"
	data := mob(chunkOf(0x10, []byte("a")), chunkOf(scriptCoded, codedBody(0xDEADBEEF, text)), chunkOf(0x11, []byte("bc")))
	got, err := Extract(data)
	if err != nil {
		t.Fatal(err)
	}
	if string(got.Text) != text || !got.Coded || got.Seed != 0xDEADBEEF {
		t.Fatalf("got %q coded=%v seed=%#x", got.Text, got.Coded, got.Seed)
	}
}

func TestExtractPlain(t *testing.T) {
	got, err := Extract(mob(chunkOf(scriptPlain, []byte("plain text"))))
	if err != nil {
		t.Fatal(err)
	}
	if string(got.Text) != "plain text" || got.Coded {
		t.Fatalf("got %q coded=%v", got.Text, got.Coded)
	}
}

func TestReplaceRoundTripAndNewText(t *testing.T) {
	data := mob(chunkOf(0x10, []byte("a")), chunkOf(scriptCoded, codedBody(7, "old text")), chunkOf(0x11, []byte("bc")))
	same, err := Replace(data, []byte("old text"))
	if err != nil || !bytes.Equal(same, data) {
		t.Fatalf("same text changed the map: err=%v", err)
	}
	newText := "a much longer replacement text\r\n"
	out, err := Replace(data, []byte(newText))
	if err != nil {
		t.Fatal(err)
	}
	want := mob(chunkOf(0x10, []byte("a")), chunkOf(scriptCoded, codedBody(7, newText)), chunkOf(0x11, []byte("bc")))
	if !bytes.Equal(out, want) {
		t.Fatal("replaced map differs from the map built with the new text")
	}
	got, err := Extract(out)
	if err != nil || string(got.Text) != newText || got.Seed != 7 {
		t.Fatalf("extract after replace: %q seed=%d err=%v", got.Text, got.Seed, err)
	}
}

func TestReplacePlain(t *testing.T) {
	out, err := Replace(mob(chunkOf(scriptPlain, []byte("old"))), []byte("new longer"))
	if err != nil {
		t.Fatal(err)
	}
	if !bytes.Equal(out, mob(chunkOf(scriptPlain, []byte("new longer")))) {
		t.Fatal("plain script not replaced in place")
	}
}

func TestFailures(t *testing.T) {
	two := mob(chunkOf(scriptPlain, []byte("a")), chunkOf(scriptCoded, codedBody(1, "b")))
	tests := []struct {
		name, want string
		data       []byte
	}{
		{"no root", "no root chunk", chunkOf(0x77, []byte("x"))},
		{"no script", "no script chunk", mob(chunkOf(0x10, []byte("x")))},
		{"two scripts", "2 script chunks", two},
		{"non-ASCII", "not ASCII", mob(chunkOf(scriptPlain, []byte{'a', 0xE9}))},
		{"NUL", "not ASCII", mob(chunkOf(scriptPlain, []byte{'a', 0}))},
		{"coded without seed", "no seed", mob(chunkOf(scriptCoded, []byte{1}))},
		{"oversized child", "does not fit", chunkOf(rootID, binary.LittleEndian.AppendUint32(binary.LittleEndian.AppendUint32(nil, scriptPlain), 99))},
		{"truncated", "truncated", []byte{1, 2, 3}},
	}
	for _, tt := range tests {
		if _, err := Extract(tt.data); err == nil || !strings.Contains(err.Error(), tt.want) {
			t.Errorf("%s: Extract error %v, want %q", tt.name, err, tt.want)
		}
	}
	if _, err := Replace(mob(chunkOf(scriptPlain, []byte("a"))), []byte("caf\xe9")); err == nil || !strings.Contains(err.Error(), "not ASCII") {
		t.Errorf("Replace with non-ASCII text: error %v", err)
	}
	if _, err := Replace(chunkOf(0x77, nil), []byte("a")); err == nil {
		t.Error("Replace without a root: no error")
	}
}

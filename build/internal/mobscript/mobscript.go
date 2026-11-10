// Package mobscript reads and replaces the script of a map (.mob) file.
//
// A .mob file is a sequence of top-level chunks: a uint32 LE id, then a uint32 LE size that includes the 8-byte
// header. The first chunk with id 0xA000 (the root) holds child chunks of the same shape; one child is the map's
// script. A coded script (id 0xACCEECCB) starts with a uint32 LE seed and the text follows, each byte XORed with the
// next output of a linear congruential generator; a plain one (id 0xACCEECCA) is the text itself. The text fills the
// chunk to its end, with no terminator or padding.
package mobscript

import (
	"encoding/binary"
	"errors"
	"fmt"
)

const (
	rootID      = 0xA000
	scriptPlain = 0xACCEECCA
	scriptCoded = 0xACCEECCB
	headerSize  = 8
	seedSize    = 4
	lcgMul      = 0x343FD
	lcgAdd      = 0x269EC3
	maxASCII    = 0x7F
)

// Script is the script of a map: its text, byte for byte, and how it is stored.
type Script struct {
	Text  []byte
	Coded bool   // stored coded (0xACCEECCB) rather than as plain text
	Seed  uint32 // the coding seed; only meaningful when Coded
}

// chunk is a located chunk: its offset and total size (header included) in the file.
type chunk struct{ off, size int }

// header reads the chunk header at off; the chunk must fit inside [off, end).
func header(data []byte, off, end int) (id uint32, size int, err error) {
	if end-off < headerSize {
		return 0, 0, fmt.Errorf("truncated chunk header at offset %d", off)
	}
	id = binary.LittleEndian.Uint32(data[off:])
	size = int(binary.LittleEndian.Uint32(data[off+4:]))
	if size < headerSize || size > end-off {
		return 0, 0, fmt.Errorf("chunk %#x at offset %d: size %d does not fit in %d bytes", id, off, size, end-off)
	}
	return id, size, nil
}

// locate finds the root chunk and the one script chunk inside it, and returns the script chunk's id.
func locate(data []byte) (root, script chunk, id uint32, err error) {
	found := false
	for off := 0; off < len(data); {
		cid, size, err := header(data, off, len(data))
		if err != nil {
			return root, script, 0, err
		}
		if cid == rootID {
			root, found = chunk{off, size}, true
			break
		}
		off += size
	}
	if !found {
		return root, script, 0, errors.New("no root chunk 0xA000")
	}
	count := 0
	for off := root.off + headerSize; off < root.off+root.size; {
		cid, size, err := header(data, off, root.off+root.size)
		if err != nil {
			return root, script, 0, err
		}
		if cid == scriptPlain || cid == scriptCoded {
			script, id = chunk{off, size}, cid
			count++
		}
		off += size
	}
	switch {
	case count == 0:
		return root, script, 0, errors.New("no script chunk in the root chunk")
	case count > 1:
		return root, script, 0, fmt.Errorf("%d script chunks in the root chunk, want one", count)
	}
	return root, script, id, nil
}

// xorStream applies the coding to body in place; it is its own inverse.
func xorStream(seed uint32, body []byte) {
	x := seed
	for i := range body {
		x = x*lcgMul + lcgAdd
		body[i] ^= byte(x >> 16)
	}
}

// Extract returns the map's script.
func Extract(data []byte) (Script, error) {
	_, c, id, err := locate(data)
	if err != nil {
		return Script{}, err
	}
	body := data[c.off+headerSize : c.off+c.size]
	s := Script{Coded: id == scriptCoded}
	if s.Coded {
		if len(body) < seedSize {
			return Script{}, errors.New("coded script chunk has no seed")
		}
		s.Seed = binary.LittleEndian.Uint32(body)
		body = body[seedSize:]
	}
	s.Text = append([]byte(nil), body...)
	if s.Coded {
		xorStream(s.Seed, s.Text)
	}
	return s, checkText(s.Text)
}

// checkText requires ASCII without NUL: other bytes would need a code page the sources do not carry, and a NUL
// would end the text for the game.
func checkText(text []byte) error {
	for i, b := range text {
		if b == 0 || b > maxASCII {
			return fmt.Errorf("script text byte %#x at offset %d is not ASCII text", b, i)
		}
	}
	return nil
}

// Replace returns a copy of the map with its script text replaced, stored the way the original was (same chunk id
// and seed). The sizes of the script chunk and the root chunk are updated; every other byte is kept.
func Replace(data, text []byte) ([]byte, error) {
	root, c, id, err := locate(data)
	if err != nil {
		return nil, err
	}
	if err := checkText(text); err != nil {
		return nil, err
	}
	var body []byte
	if id == scriptCoded {
		seed := binary.LittleEndian.Uint32(data[c.off+headerSize:])
		body = binary.LittleEndian.AppendUint32(body, seed)
		body = append(body, text...)
		xorStream(seed, body[seedSize:])
	} else {
		body = append(body, text...)
	}
	newSize := headerSize + len(body)
	out := make([]byte, 0, len(data)+newSize-c.size)
	out = append(out, data[:c.off]...)
	out = binary.LittleEndian.AppendUint32(out, id)
	out = binary.LittleEndian.AppendUint32(out, uint32(newSize))
	out = append(out, body...)
	out = append(out, data[c.off+c.size:]...)
	binary.LittleEndian.PutUint32(out[root.off+4:], uint32(root.size+newSize-c.size))
	return out, nil
}

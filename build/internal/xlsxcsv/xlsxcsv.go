// Package xlsxcsv converts between an .xlsx workbook and a directory of CSV files, one per sheet, losslessly.
//
// Export copies every cell's stored text verbatim (numbers are not parsed, so "-0" stays "-0");
// Import writes every non-empty cell back as an inline string. um-multitool's xlsxdb reads a string
// cell with the same atof-based parser it applies to numeric cells, so both forms compile identically.
package xlsxcsv

import (
	"archive/zip"
	"bytes"
	"encoding/csv"
	"encoding/xml"
	"errors"
	"fmt"
	"io"
	"os"
	"path"
	"path/filepath"
	"sort"
	"strconv"
	"strings"
	"time"
)

// ---- export ----

type relationships struct {
	Rels []struct {
		ID     string `xml:"Id,attr"`
		Target string `xml:"Target,attr"`
	} `xml:"Relationship"`
}

type workbook struct {
	Sheets []struct {
		Name string `xml:"name,attr"`
		RID  string `xml:"http://schemas.openxmlformats.org/officeDocument/2006/relationships id,attr"`
	} `xml:"sheets>sheet"`
}

// richText is the text of a shared string or inline string: plain <t>, or rich-text runs <r><t>.
type richText struct {
	T    *string `xml:"t"`
	Runs []struct {
		T string `xml:"t"`
	} `xml:"r"`
}

func (r richText) String() string {
	if r.T != nil {
		return *r.T
	}
	var b strings.Builder
	for _, run := range r.Runs {
		b.WriteString(run.T)
	}
	return b.String()
}

type sheetXML struct {
	Rows []struct {
		Cells []struct {
			Ref string    `xml:"r,attr"`
			T   string    `xml:"t,attr"`
			V   *string   `xml:"v"`
			Is  *richText `xml:"is"`
		} `xml:"c"`
	} `xml:"sheetData>row"`
}

func readZipFile(z *zip.Reader, name string) ([]byte, error) {
	for _, f := range z.File {
		if f.Name == name {
			rc, err := f.Open()
			if err != nil {
				return nil, err
			}
			defer rc.Close()
			return io.ReadAll(rc)
		}
	}
	return nil, fmt.Errorf("%s: not in workbook", name)
}

// cellRef splits "AB12" into a 0-based column and 1-based row.
func cellRef(ref string) (col, row int, err error) {
	i := 0
	for i < len(ref) && ref[i] >= 'A' && ref[i] <= 'Z' {
		col = col*26 + int(ref[i]-'A'+1)
		i++
	}
	if i == 0 || i == len(ref) {
		return 0, 0, fmt.Errorf("bad cell reference %q", ref)
	}
	row, err = strconv.Atoi(ref[i:])
	return col - 1, row, err
}

// Export writes one CSV per sheet of the workbook at xlsxPath into dir, cell text verbatim.
func Export(xlsxPath, dir string) error {
	data, err := os.ReadFile(xlsxPath)
	if err != nil {
		return err
	}
	z, err := zip.NewReader(bytes.NewReader(data), int64(len(data)))
	if err != nil {
		return err
	}
	var shared []string
	if raw, err := readZipFile(z, "xl/sharedStrings.xml"); err == nil {
		var sst struct {
			SI []richText `xml:"si"`
		}
		if err := xml.Unmarshal(raw, &sst); err != nil {
			return fmt.Errorf("sharedStrings.xml: %w", err)
		}
		for _, si := range sst.SI {
			shared = append(shared, si.String())
		}
	}
	raw, err := readZipFile(z, "xl/workbook.xml")
	if err != nil {
		return err
	}
	var wb workbook
	if err := xml.Unmarshal(raw, &wb); err != nil {
		return fmt.Errorf("workbook.xml: %w", err)
	}
	raw, err = readZipFile(z, "xl/_rels/workbook.xml.rels")
	if err != nil {
		return err
	}
	var rels relationships
	if err := xml.Unmarshal(raw, &rels); err != nil {
		return fmt.Errorf("workbook.xml.rels: %w", err)
	}
	targets := map[string]string{}
	for _, r := range rels.Rels {
		targets[r.ID] = path.Join("xl", strings.TrimPrefix(r.Target, "/xl/"))
	}
	if err := os.MkdirAll(dir, 0o755); err != nil {
		return err
	}
	for _, s := range wb.Sheets {
		target, ok := targets[s.RID]
		if !ok {
			return fmt.Errorf("sheet %q: no relationship %q", s.Name, s.RID)
		}
		raw, err := readZipFile(z, target)
		if err != nil {
			return err
		}
		var sx sheetXML
		if err := xml.Unmarshal(raw, &sx); err != nil {
			return fmt.Errorf("sheet %q: %w", s.Name, err)
		}
		grid := map[int]map[int]string{}
		maxRow, maxCol := 0, 0
		for _, row := range sx.Rows {
			for _, c := range row.Cells {
				col, r, err := cellRef(c.Ref)
				if err != nil {
					return fmt.Errorf("sheet %q: %w", s.Name, err)
				}
				var text string
				switch c.T {
				case "s":
					if c.V == nil {
						continue
					}
					i, err := strconv.Atoi(*c.V)
					if err != nil || i < 0 || i >= len(shared) {
						return fmt.Errorf("sheet %q cell %s: bad shared string index %q", s.Name, c.Ref, *c.V)
					}
					text = shared[i]
				case "inlineStr":
					if c.Is == nil {
						continue
					}
					text = c.Is.String()
				case "", "n", "str", "b":
					if c.V == nil {
						continue
					}
					text = *c.V
				default:
					return fmt.Errorf("sheet %q cell %s: unsupported cell type %q", s.Name, c.Ref, c.T)
				}
				if grid[r] == nil {
					grid[r] = map[int]string{}
				}
				grid[r][col] = text
				maxRow = max(maxRow, r)
				maxCol = max(maxCol, col+1)
			}
		}
		if err := writeCSV(filepath.Join(dir, s.Name+".csv"), grid, maxRow, maxCol); err != nil {
			return err
		}
	}
	return nil
}

func writeCSV(file string, grid map[int]map[int]string, rows, cols int) error {
	var buf bytes.Buffer
	w := csv.NewWriter(&buf)
	for r := 1; r <= rows; r++ {
		rec := make([]string, cols)
		for c, v := range grid[r] {
			rec[c] = v
		}
		if err := w.Write(rec); err != nil {
			return err
		}
	}
	w.Flush()
	if err := w.Error(); err != nil {
		return err
	}
	return os.WriteFile(file, buf.Bytes(), 0o644)
}

// ---- import ----

// Zip entries carry this fixed time so the same CSVs always give the same workbook bytes.
var epoch = time.Date(2000, 1, 1, 0, 0, 0, 0, time.UTC)

func colName(c int) string {
	s := ""
	for c++; c > 0; c = (c - 1) / 26 {
		s = string(rune('A'+(c-1)%26)) + s
	}
	return s
}

func xmlEscape(s string) string {
	var b bytes.Buffer
	if err := xml.EscapeText(&b, []byte(s)); err != nil {
		panic(err) // EscapeText fails only on a failing writer; bytes.Buffer never fails.
	}
	return b.String()
}

// Import writes the CSV sheets in dir into one workbook at xlsxPath, every cell an inline string.
// The output depends only on the CSV contents and file names.
func Import(dir, xlsxPath string) error {
	files, err := filepath.Glob(filepath.Join(dir, "*.csv"))
	if err != nil {
		return err
	}
	if len(files) == 0 {
		return fmt.Errorf("no .csv sheets in %s", dir)
	}
	sort.Strings(files)
	var out bytes.Buffer
	zw := zip.NewWriter(&out)
	add := func(name, content string) error {
		w, err := zw.CreateHeader(&zip.FileHeader{Name: name, Method: zip.Deflate, Modified: epoch})
		if err != nil {
			return err
		}
		_, err = io.WriteString(w, content)
		return err
	}
	var sheets, rels, types strings.Builder
	for i, f := range files {
		name := strings.TrimSuffix(filepath.Base(f), ".csv")
		xmlSheet, err := sheetFromCSV(f)
		if err != nil {
			return err
		}
		n := i + 1
		if err := add(fmt.Sprintf("xl/worksheets/sheet%d.xml", n), xmlSheet); err != nil {
			return err
		}
		fmt.Fprintf(&sheets, `<sheet name="%s" sheetId="%d" r:id="rId%d"/>`, xmlEscape(name), n, n)
		fmt.Fprintf(&rels, `<Relationship Id="rId%d" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet%d.xml"/>`, n, n)
		fmt.Fprintf(&types, `<Override PartName="/xl/worksheets/sheet%d.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>`, n)
	}
	parts := []struct{ name, content string }{
		{"[Content_Types].xml", `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>` +
			`<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">` +
			`<Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>` +
			`<Default Extension="xml" ContentType="application/xml"/>` +
			`<Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>` +
			types.String() + `</Types>`},
		{"_rels/.rels", `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>` +
			`<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">` +
			`<Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>` +
			`</Relationships>`},
		{"xl/workbook.xml", `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>` +
			`<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">` +
			`<sheets>` + sheets.String() + `</sheets></workbook>`},
		{"xl/_rels/workbook.xml.rels", `<?xml version="1.0" encoding="UTF-8" standalone="yes"?>` +
			`<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">` + rels.String() + `</Relationships>`},
	}
	for _, p := range parts {
		if err := add(p.name, p.content); err != nil {
			return err
		}
	}
	if err := zw.Close(); err != nil {
		return err
	}
	return os.WriteFile(xlsxPath, out.Bytes(), 0o644)
}

func sheetFromCSV(file string) (string, error) {
	f, err := os.Open(file)
	if err != nil {
		return "", err
	}
	defer f.Close()
	r := csv.NewReader(f)
	r.FieldsPerRecord = -1
	var b strings.Builder
	b.WriteString(`<?xml version="1.0" encoding="UTF-8" standalone="yes"?>`)
	b.WriteString(`<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main"><sheetData>`)
	for row := 1; ; row++ {
		rec, err := r.Read()
		if errors.Is(err, io.EOF) {
			break
		}
		if err != nil {
			return "", fmt.Errorf("%s: %w", file, err)
		}
		fmt.Fprintf(&b, `<row r="%d">`, row)
		for c, v := range rec {
			if v == "" {
				continue
			}
			fmt.Fprintf(&b, `<c r="%s%d" t="inlineStr"><is><t xml:space="preserve">%s</t></is></c>`, colName(c), row, xmlEscape(v))
		}
		b.WriteString(`</row>`)
	}
	b.WriteString(`</sheetData></worksheet>`)
	return b.String(), nil
}

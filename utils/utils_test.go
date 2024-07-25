package utils

import (
	"mime"
	"testing"
)

const (
	cssCorrectMime    string = "text/css; charset=utf-8"
	jsCorrectMime     string = "text/javascript; charset=utf-8"
	htmlCorrectMime   string = "text/html; charset=utf-8"
	jpgCorretMime     string = "image/jpeg"
	correctExt        string = ".txt"
	filename          string = "test.csv.txt"
	loopbackInterface string = "lo"
	correctIP                = "127.0.0.1"
)

func TestByteCountDecimal(t *testing.T) {
	res100 := ByteCountDecimal(100)
	if res100 != "100 B" {
		t.Errorf("Error in ByteCountDecimal, got: %s  - want %s", res100, "100 B")
	}

	res1024 := ByteCountDecimal(1024)
	if res1024 != "1.0 kB" {
		t.Errorf("Error in ByteCountDecimal, got: %s  - want %s", res1024, "1.0 kB")
	}

	res1024000 := ByteCountDecimal(1024000)
	if res1024000 != "1.0 MB" {
		t.Errorf("Error in ByteCountDecimal, got: %s  - want %s", res1024000, "1.0 MB")
	}

	res1024000000 := ByteCountDecimal(1024000000)
	if res1024000000 != "1.0 GB" {
		t.Errorf("Error in ByteCountDecimal, got: %s  - want %s", res1024000000, "1.0 GB")
	}
}

func TestMimeByExtension(t *testing.T) {
	cssMime := mime.TypeByExtension(".css")
	jsMime := mime.TypeByExtension(".js")
	htmlMime := mime.TypeByExtension(".html")
	jpgMime := mime.TypeByExtension(".jpg")

	if cssMime != cssCorrectMime || jsMime != jsCorrectMime || htmlMime != htmlCorrectMime || jpgMime != jpgCorretMime {
		t.Errorf("Error in MimeByExtension\ncss\tgot %s - want %s\njs\tgot %s - want %s\nhtml\tgot %s - want %s\njpg\tgot %s - want %s", cssMime, cssCorrectMime, jsMime, jsCorrectMime, htmlMime, htmlCorrectMime, jpgMime, jpgCorretMime)
	}
}

func TestReturnExt(t *testing.T) {
	ext := ReturnExt(filename)
	if ext != correctExt {
		t.Errorf("Error in ReturnExt: want %s - got %s", correctExt, ext)
	}
}

func TestGetIPv4Addr(t *testing.T) {
	res, err := GetInterfaceIpv4Addr(loopbackInterface)
	if err != nil {
		t.Fatal(err)
	}
	if res != correctIP {
		t.Errorf("Error in GetIPv4Addr: want %s - got %s", correctIP, res)
	}
}

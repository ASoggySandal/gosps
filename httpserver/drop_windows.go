//go:build windows

package httpserver

import (
	"github.com/ASoggySandal/gosps/logger"
)

func (fs *FileServer) dropPrivs() {
	if fs.DropUser != "" {
		logger.Warn("Dropping privileges with --user only works for unix systems, sorry.")
	}
}

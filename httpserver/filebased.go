package httpserver

import (
	"encoding/json"
	"io"
	"os"
	"path/filepath"
)

func (fs *FileServer) findSpecialFile(folder string) (configFile, error) {
	var config configFile

	// disable G304 (CWE-22): Potential file inclusion via variable
	// #nosec G304
	file, err := os.Open(folder)
	if err != nil {
		return config, err
	}

	fis, err := file.Readdir(-1)
	if err != nil {
		return config, err
	}

	for _, fi := range fis {
		if fi.Name() == ".goshs" {
			openFile := filepath.Join(file.Name(), fi.Name())

			// disable G304 (CWE-22): Potential file inclusion via variable
			// #nosec G304
			configFileDisk, err := os.Open(openFile)
			if err != nil {
				return config, err
			}

			configFileBytes, err := io.ReadAll(configFileDisk)
			if err != nil {
				return config, err
			}

			if err := json.Unmarshal(configFileBytes, &config); err != nil {
				return config, err
			}

			return config, nil
		}
	}

	return config, nil
}

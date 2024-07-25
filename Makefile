.PHONY: build-all

# uglify-js and sass needed
generate:
	@echo "[*] Minifying js and compiling scss"
	@uglifyjs -o httpserver/static/js/main.min.js assets/js/main.js
	@uglifyjs -o httpserver/static/js/color-modes.min.js assets/js/color-modes.js
	@sass --no-source-map -s compressed assets/css/style.scss httpserver/static/css/style.css
	@echo "[OK] Done minifying and compiling things"
	@echo "[*] Copying embedded files to target location"
	@rm -rf httpserver/embedded
	@cp -r embedded httpserver/

security:
	@echo "[*] Checking with gosec"
	@gosec ./...
	@echo "[OK] No issues detected"


build-all: clean generate
	@echo "[*] go mod dowload"
	@go mod download
	@echo "[*] Building for linux"
	@GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o dist/linux_amd64/gosps
	@GOOS=linux GOARCH=386 go build -ldflags="-s -w" -o dist/linux_386/gosps
	@echo "[*] Building for windows"
	@GOOS=windows GOARCH=amd64 go build -ldflags="-s -w" -o dist/windows_amd64/gosps.exe
	@GOOS=windows GOARCH=386 go build -ldflags="-s -w" -o dist/windows_386/gosps.exe
	@echo "[*] Building for mac"
	@GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w" -o dist/darwin_amd64/gosps
	@echo "[*] Building for arm"
	@GOOS=linux GOARCH=arm GOARM=5 go build -ldflags="-s -w" -o dist/arm_5/gosps
	@GOOS=linux GOARCH=arm GOARM=6 go build -ldflags="-s -w" -o dist/arm_6/gosps
	@GOOS=linux GOARCH=arm GOARM=7 go build -ldflags="-s -w" -o dist/arm_7/gosps
	@GOOS=linux GOARCH=arm64 go build -ldflags="-s -w" -o dist/arm64_8/gosps
	@echo "[OK] App binary was created!"

build-linux: clean generate
	@echo "[*] go mod dowload"
	@go mod download
	@echo "[*] Building for linux"
	@GOOS=linux GOARCH=amd64 go build -ldflags="-s -w" -o dist/linux_amd64/gosps
	@GOOS=linux GOARCH=386 go build -ldflags="-s -w" -o dist/linux_386/gosps
	@echo "[OK] App binary was created!"

build-mac: clean generate
	@echo "[*] go mod dowload"
	@go mod download
	@echo "[*] Building for mac"
	@GOOS=darwin GOARCH=amd64 go build -ldflags="-s -w" -o dist/darwin_amd64/gosps
	@echo "[OK] App binary was created!"

build-windows: clean generate
	@echo "[*] go mod dowload"
	@go mod download
	@echo "[*] Building for windows"
	@GOOS=windows GOARCH=amd64 go build -ldflags="-s -w" -o dist/windows_amd64/gosps.exe
	@GOOS=windows GOARCH=386 go build -ldflags="-s -w" -o dist/windows_386/gosps.exe
	@echo "[OK] App binary was created!"

build-arm: clean generate
	@echo "[*] go mod dowload"
	@go mod download
	@echo "[*] Building for arm"
	@GOOS=linux GOARCH=arm GOARM=5 go build -ldflags="-s -w" -o dist/arm_5/gosps
	@GOOS=linux GOARCH=arm GOARM=6 go build -ldflags="-s -w" -o dist/arm_6/gosps
	@GOOS=linux GOARCH=arm GOARM=7 go build -ldflags="-s -w" -o dist/arm_7/gosps
	@GOOS=linux GOARCH=arm64 go build -ldflags="-s -w" -o dist/arm64_8/gosps
	@echo "[OK] App binary was created!"

run:
	@go run main.go

install:
	@go install ./...
	@echo "[OK] Application was installed to go binary directory!"

clean:
	@rm -rf ./dist
	@echo "[OK] Cleaned up!"

.DEFAULT_GOAL := help
.PHONY: help setup gdunit-setup format format-check lint check test build build-all build-web build-linux build-windows build-macos run clean

GODOT ?= godot
UV ?= uv
GD := $(UV) run --frozen
GDUNIT_VERSION ?= v6.2.2
help: ## Show available commands
	@awk 'BEGIN {FS = ":.*##"} /^[a-zA-Z_-]+:.*##/ {printf "\033[36m%-14s\033[0m %s\n", $$1, $$2}' $(MAKEFILE_LIST)

setup: gdunit-setup ## Install project tools and GdUnit4
	$(UV) sync

gdunit-setup: ## Download the pinned GdUnit4 plugin into addons/
	@if [ ! -f addons/gdUnit4/plugin.cfg ]; then \
		set -eu; \
		tmp_dir=$$(mktemp -d); \
		trap 'rm -rf "$$tmp_dir"' EXIT; \
		curl -fsSL "https://github.com/godot-gdunit-labs/gdUnit4/archive/refs/tags/$(GDUNIT_VERSION).tar.gz" | tar -xz -C "$$tmp_dir" --strip-components=1; \
		cp -R "$$tmp_dir/addons/gdUnit4" addons/gdUnit4; \
	fi

format: ## Format all GDScript files
	$(GD) gdformat .

format-check: ## Check GDScript formatting without changing files
	$(GD) gdformat --check .

lint: ## Lint all GDScript files
	$(GD) gdlint .

check: format-check lint ## Run formatting, lint, and Godot project import checks
	$(GODOT) --headless --path . --editor --quit

test: ## Run GdUnit4 tests from tests/
	GODOT_BIN="$(GODOT)" ./addons/gdUnit4/runtest.sh -a res://tests

build: build-web ## Build the default Web target

build-all: build-web build-linux build-windows build-macos ## Build all configured desktop and Web targets

build-web: ## Export Web build to dist/web/
	mkdir -p dist/web
	$(GODOT) --headless --path . --export-release "Web" "dist/web/index.html"

build-linux: ## Export Linux x86_64 build to dist/linux/
	mkdir -p dist/linux
	$(GODOT) --headless --path . --export-release "Linux" "dist/linux/godot-template.x86_64"

build-windows: ## Export Windows x86_64 build to dist/windows/
	mkdir -p dist/windows
	$(GODOT) --headless --path . --export-release "Windows Desktop" "dist/windows/godot-template.exe"

build-macos: ## Export macOS universal build to dist/macos/
	mkdir -p dist/macos
	$(GODOT) --headless --path . --export-release "macOS" "dist/macos/Godot Template.zip"

run: ## Run the project
	$(GODOT) --path .

clean: ## Remove generated Godot and Python files
	rm -rf .godot .venv __pycache__

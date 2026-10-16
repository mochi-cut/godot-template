# Godot Template

A small starting point for Godot 4 projects. The default scene is a clean title screen; replace it with your game as you build it.

## Requirements

- Godot 4.7 or newer (set `GODOT` to the executable name or path if needed)
- [uv](https://docs.astral.sh/uv/) for the GDScript formatter and linter
- GNU Make

## Getting started

```sh
make setup
make run
```

## Development commands

```sh
make format       # format GDScript files
make lint         # lint GDScript files
make check        # formatting, lint, and Godot project import check
make test         # run GdUnit4 tests
make build-web        # export Web build to dist/web/
make build-linux      # export Linux x86_64 build to dist/linux/
make build-windows    # export Windows x86_64 build to dist/windows/
make build-macos      # export macOS universal build to dist/macos/
make build-all        # export all four targets
make clean        # remove generated files
```

`make setup` also downloads the pinned GdUnit4 plugin into `addons/gdUnit4/` and enables it for the project. `make test` runs suites under `tests/`. Set `GODOT=/path/to/godot` when the executable is not named `godot`.

`make check` runs Godot in headless editor mode, which imports project resources and reports parse or resource errors. Each `build-*` target uses its matching preset in `export_presets.cfg`; install matching Godot export templates once in the Godot editor first. `make build` remains an alias for `make build-web`.

## Project layout

- `game/` — scenes and game scripts
- `autoload/` — global scripts registered as autoloads
- `assets/` — art, audio, and fonts
- `addons/` — third-party or project editor plugins
- `tests/` — GdUnit4 test suites (name suites `*_test.gd`)
- `playground/` — experiments kept outside the main game flow
- `docs/` — design and development notes
- `dist/` — local export output (ignored by Git)

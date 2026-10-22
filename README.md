# Godot Template

A small starting point for Godot 4 projects. The initial scene is an empty `Main` node.

## Requirements

- Linux (primary supported development platform)
- [mise](https://mise.jdx.dev/)
- curl and tar (for the GdUnit4 setup task)

## Getting started

```sh
mise trust
mise install
mise run setup
mise run run
```

`mise.toml` declares Godot 4.7.2, Python, uv and the isolated `gdtoolkit` CLI environment. Python is a development tool, not an application dependency.

## Development commands

```sh
mise run format
mise run format-check
mise run lint
mise run check
mise run test
mise run build-web
mise run build-linux
mise run build-windows
mise run build-macos
mise run build-all
mise run clean
```

`mise run setup` downloads pinned GdUnit4 v6.2.2 into `addons/gdUnit4/`. Test suites belong in `tests/` and should be named `*_test.gd`.

To export, install matching Godot export templates for the pinned engine version. `build` aliases the Web export. Desktop exports are configured but only Linux development has been targeted.

## Standalone Python scripts

For a script needing third-party libraries, use PEP 723 inline metadata and run it with `uv run --script tools/example.py`. For repeatable dependency resolution, run `uv lock --script tools/example.py` and commit the generated `.lock` file. No project-wide Python virtualenv or `pyproject.toml` is needed for this use case.

## Reproducibility

`mise.toml` pins the top-level tool versions. For transitive dependency locking, generate and commit `mise.lock` (and any sidecar lock data created by your mise version) using `mise lock`; then use `mise install --locked` on the target machine. A lockfile is **not** included in this PR because dependency resolution and Linux execution were not available in the authoring environment.

## Project layout

- `game/` — scenes and game scripts
- `autoload/` — global scripts
- `assets/` — art, audio and fonts
- `addons/` — Godot plugins
- `tests/` — GdUnit4 suites
- `playground/` — experiments
- `tools/` — standalone utilities
- `docs/` — development notes
- `dist/` — ignored build output

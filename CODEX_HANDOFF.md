# CODEX HANDOFF

Updated: 2026-05-21

## Current Mission

Integrated the working local "Neon District: CyberWire" KDE Dolphin folder color feature into the repo as a maintainable asset.

## Repo State

- Path: `/mnt/storage/Cole/Projects/neon-district`
- Branch: `main`
- Commit before this work: not committed in this session
- Live install/uninstall against the user's home: not run

## Added Feature

Feature name:

`Neon District: CyberWire - KDE Dolphin Folder Color Service Menu`

Repo-owned entrypoints:

- Install: `./scripts/install/install-dolphin-folder-colors.sh`
- Uninstall: `./scripts/uninstall/uninstall-dolphin-folder-colors.sh`
- Helper source: `scripts/lib/neon-folder-color`
- Service menu template: `kde/servicemenus/neon-district-folder-colors.desktop`
- SVG icon assets: `assets/icons/folders/neon-folder-*.svg`
- Operator docs: `docs/CYBERWIRE_DOLPHIN_FOLDER_COLORS.md`
- Palette refs: `docs/palettes/neon-district-cyberwire-folder-colors.*`

## Validation Run

- `bash -n scripts/lib/neon-folder-color scripts/install/install-dolphin-folder-colors.sh scripts/uninstall/uninstall-dolphin-folder-colors.sh` passed.
- `python3 -m json.tool docs/palettes/neon-district-cyberwire-folder-colors.json >/dev/null` passed.
- Service menu `Exec=` lines use `%U`; no `%F` hits found.
- Helper contains file URL decoding, `pkexec` fallback, metadata touch nudges, DBus/qdbus Dolphin reload attempts, and KDE service cache refresh behavior.
- Installer was run against a temporary `HOME` with a restricted `PATH` that excluded `gtk-update-icon-cache` and `xdg-icon-resource`; it completed successfully and printed the skipped icon-cache refresh message.
- Helper was tested against a temporary folder using a `file://` URL with encoded spaces; it wrote the expected `.directory` `Icon=neon-folder-cyberwire-cyan` entry and reset without touching user folders.
- `shellcheck` was not available on PATH, so shellcheck was skipped.
- `git diff --check` passed for tracked diffs; trailing-whitespace scan over new/changed files returned no hits.

## Notes

- Do not run the uninstall script casually on the live home if preserving the currently installed prototype matters. It removes the installed helper, service menu, and Neon District icon assets by design.
- The uninstall script leaves folder `.directory` customizations alone by default. Optional cleanup is explicit: `./scripts/uninstall/uninstall-dolphin-folder-colors.sh --reset-directory-icons /path/to/folder`.
- Manual Dolphin validation is still required after install: right-click a folder, choose `Neon District Folder Color`, apply a color, and confirm the icon refreshes.

## Recommended Next Step

Review the diff, optionally run the installer live, verify in Dolphin, then commit with:

`Add CyberWire Dolphin folder color integration`

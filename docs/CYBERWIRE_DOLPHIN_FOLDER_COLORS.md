# Neon District: CyberWire - KDE Dolphin Folder Color Service Menu

This feature adds a KDE Dolphin right-click service menu for applying Neon District: CyberWire folder icons to directories.

It installs a local helper, a Dolphin service menu, CyberWire SVG folder icons, and palette reference files. The helper writes or patches a folder's `.directory` metadata so Dolphin can render a custom icon without running Dolphin as root.

## Install

From the repo root:

```bash
./scripts/install/install-dolphin-folder-colors.sh
```

Installed paths:

- `~/.local/bin/neon-folder-color`
- `~/.local/share/kio/servicemenus/neon-district-folder-colors.desktop`
- `~/.local/share/icons/hicolor/scalable/places/neon-folder-*.svg`
- `~/.config/neon-district/folder-colors/`

The installer refreshes KDE's service cache with `kbuildsycoca6` when available, otherwise `kbuildsycoca5`. It attempts an icon cache refresh only when `gtk-update-icon-cache` or `xdg-icon-resource` exists, and does not fail if neither tool is installed.

## Use

In Dolphin:

1. Right-click a folder.
2. Open `Neon District Folder Color`.
3. Pick one of the CyberWire folder colors.

Available actions:

- CyberWire Cyan - Active / Operator / Dev
- Ghost Cyan - Docs / Reference
- Threat Pink - Danger / Broken / Urgent
- Neon Purple - Creative / Themes
- Warning Amber - Pending / Review / Staging
- Poison Green - Stable / Validated / Shipped
- Void Black - Archive / Vault / Cold Storage
- Panel Charcoal - System / Config / Neutral
- Reset Folder Icon

## Uninstall

From the repo root:

```bash
./scripts/uninstall/uninstall-dolphin-folder-colors.sh
```

Default uninstall removes the helper, service menu, and Neon District SVG folder icons. It leaves existing folder `.directory` customizations alone.

Optional cleanup for folders you explicitly choose:

```bash
./scripts/uninstall/uninstall-dolphin-folder-colors.sh --reset-directory-icons /path/to/folder
```

That optional mode removes only `.directory` `Icon=` entries that match the Neon District folder icon names.

## Why pkexec

Dolphin should not be run as root just to change folder metadata. The helper first applies changes directly when the folder is writable. If a protected folder needs an admin write, it prompts through `pkexec` and re-runs only the metadata operation with elevated permission.

## Why %U Matters

The service menu uses `%U` instead of `%F`.

Dolphin can pass selected folders as file URLs. `%U` preserves the right-clicked subfolder target, and the helper decodes `file://` URLs into local paths before writing `.directory`. This prevents the parent folder from being colored when the intended target is a child folder.

## Live Refresh

After applying or resetting a color, the helper:

- touches the folder and `.directory` metadata
- touches the parent folder
- attempts to trigger Dolphin reload over DBus through `qdbus`
- refreshes KDE service cache through `kbuildsycoca6` or `kbuildsycoca5` when available

This usually refreshes Dolphin immediately. Some Dolphin views may still need a manual reload or restart depending on cache state.

## Logs

Helper actions are logged to:

```text
~/.cache/neon-folder-color/actions.log
```

## Troubleshooting

Menu does not appear:

- Run `kbuildsycoca6 --noincremental` or `kbuildsycoca5 --noincremental`.
- Restart Dolphin.
- Confirm the service menu exists at `~/.local/share/kio/servicemenus/neon-district-folder-colors.desktop`.

Permission or auth error:

- Confirm `pkexec` is installed for protected folders.
- Try applying the color to a normal user-owned folder first.
- Check `~/.cache/neon-folder-color/actions.log`.

Color applies only after Dolphin restart:

- Run Dolphin reload, press `F5`, or restart Dolphin.
- Confirm `qdbus` is available if immediate DBus reload is expected.

Parent folder changes instead of child:

- Confirm the installed service menu `Exec=` lines use `%U`, not `%F`.
- Reinstall from this repo if an older prototype service menu is still present.

Protected folder needs admin prompt:

- This is expected for system-owned or otherwise non-writable directories.
- The helper prompts through `pkexec` only for protected targets.

## Palette

The palette reference lives under `docs/palettes/` and installs to `~/.config/neon-district/folder-colors/`.

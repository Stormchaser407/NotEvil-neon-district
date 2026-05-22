#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd -- "$SCRIPT_DIR/../.." && pwd)"

HELPER_SRC="$REPO_ROOT/scripts/lib/neon-folder-color"
SERVICE_SRC="$REPO_ROOT/kde/servicemenus/neon-district-folder-colors.desktop"
ICONS_SRC="$REPO_ROOT/assets/icons/folders"
DOCS_SRC="$REPO_ROOT/docs/palettes"

HELPER_DEST="$HOME/.local/bin/neon-folder-color"
SERVICE_DEST="$HOME/.local/share/kio/servicemenus/neon-district-folder-colors.desktop"
ICONS_DEST="$HOME/.local/share/icons/hicolor/scalable/places"
DOCS_DEST="$HOME/.config/neon-district/folder-colors"

require_file() {
  local path="$1"
  if [ ! -f "$path" ]; then
    printf 'Missing required file: %s\n' "$path" >&2
    exit 1
  fi
}

refresh_kde_service_cache() {
  if command -v kbuildsycoca6 >/dev/null 2>&1; then
    kbuildsycoca6 --noincremental >/dev/null 2>&1 || true
    printf 'Refreshed KDE service cache with kbuildsycoca6.\n'
  elif command -v kbuildsycoca5 >/dev/null 2>&1; then
    kbuildsycoca5 --noincremental >/dev/null 2>&1 || true
    printf 'Refreshed KDE service cache with kbuildsycoca5.\n'
  else
    printf 'Skipped KDE service cache refresh: kbuildsycoca6/kbuildsycoca5 not found.\n'
  fi
}

refresh_icon_cache() {
  local icon_root="$HOME/.local/share/icons/hicolor"

  if command -v gtk-update-icon-cache >/dev/null 2>&1; then
    gtk-update-icon-cache -q -t -f "$icon_root" >/dev/null 2>&1 || true
    printf 'Attempted icon cache refresh with gtk-update-icon-cache.\n'
  elif command -v xdg-icon-resource >/dev/null 2>&1; then
    xdg-icon-resource forceupdate >/dev/null 2>&1 || true
    printf 'Attempted icon cache refresh with xdg-icon-resource.\n'
  else
    printf 'Skipped icon cache refresh: gtk-update-icon-cache/xdg-icon-resource not found.\n'
  fi
}

install_palette_docs() {
  install -d "$DOCS_DEST"
  install -m 0644 "$DOCS_SRC/neon-district-cyberwire-folder-colors.md" "$DOCS_DEST/neon-district-folder-colors.md"
  install -m 0644 "$DOCS_SRC/neon-district-cyberwire-folder-colors.json" "$DOCS_DEST/neon-district-folder-colors.json"
  install -m 0644 "$DOCS_SRC/neon-district-cyberwire-folder-colors.css" "$DOCS_DEST/neon-district-folder-colors.css"
  install -m 0644 "$DOCS_SRC/neon-district-cyberwire-folder-colors.html" "$DOCS_DEST/neon-district-folder-colors.html"
}

main() {
  require_file "$HELPER_SRC"
  require_file "$SERVICE_SRC"

  install -d "$(dirname -- "$HELPER_DEST")" "$(dirname -- "$SERVICE_DEST")" "$ICONS_DEST"

  install -m 0755 "$HELPER_SRC" "$HELPER_DEST"
  sed "s|@HOME@|$HOME|g" "$SERVICE_SRC" > "$SERVICE_DEST"
  chmod 0644 "$SERVICE_DEST"
  install -m 0644 "$ICONS_SRC"/neon-folder-*.svg "$ICONS_DEST"/
  install_palette_docs

  refresh_kde_service_cache
  refresh_icon_cache

  cat <<EOF

Installed Neon District: CyberWire folder colors.

Installed files:
  Helper:       $HELPER_DEST
  Service menu: $SERVICE_DEST
  Icons:        $ICONS_DEST/neon-folder-*.svg
  Palette docs: $DOCS_DEST/

Manual Dolphin test:
  1. Open Dolphin.
  2. Right-click a folder.
  3. Choose Neon District Folder Color.
  4. Select CyberWire Cyan or another palette action.
  5. Confirm the target folder gets a .directory Icon entry and the folder icon refreshes.

If the menu does not appear immediately, restart Dolphin or run:
  kbuildsycoca6 --noincremental
EOF
}

main "$@"

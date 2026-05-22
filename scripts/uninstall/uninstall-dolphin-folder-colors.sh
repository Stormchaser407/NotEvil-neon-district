#!/usr/bin/env bash
set -euo pipefail

HELPER_DEST="$HOME/.local/bin/neon-folder-color"
SERVICE_DEST="$HOME/.local/share/kio/servicemenus/neon-district-folder-colors.desktop"
ICONS_DEST="$HOME/.local/share/icons/hicolor/scalable/places"

NEON_ICON_PATTERN='^Icon=neon-folder-(cyberwire-cyan|ghost-cyan|threat-pink|neon-purple|warning-amber|poison-green|void-black|panel-charcoal)$'

usage() {
  cat <<'EOF'
Usage:
  uninstall-dolphin-folder-colors.sh
  uninstall-dolphin-folder-colors.sh --reset-directory-icons FOLDER...

Default uninstall removes the helper, service menu, and Neon District icon assets.
It leaves existing folder .directory customizations alone.

The optional --reset-directory-icons mode removes only matching Neon District
folder Icon entries from .directory files under the folders you pass.
EOF
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

reset_one_directory_file() {
  local meta="$1"
  local tmp="${meta}.tmp.$$"

  awk -v pattern="$NEON_ICON_PATTERN" '
    $0 ~ pattern { next }
    { print }
  ' "$meta" > "$tmp"

  mv "$tmp" "$meta"

  if ! grep -qvE '^\[Desktop Entry\]$|^$' "$meta"; then
    rm -f "$meta"
  fi
}

reset_directory_icons() {
  local target

  if [ "$#" -eq 0 ]; then
    printf 'No folders supplied for --reset-directory-icons.\n' >&2
    exit 1
  fi

  for target in "$@"; do
    if [ ! -d "$target" ]; then
      printf 'Skipping non-directory target: %s\n' "$target" >&2
      continue
    fi

    find "$target" -name .directory -type f -print0 |
      while IFS= read -r -d '' meta; do
        if grep -Eq "$NEON_ICON_PATTERN" "$meta"; then
          reset_one_directory_file "$meta"
          printf 'Reset Neon District icon entry: %s\n' "$meta"
        fi
      done
  done
}

remove_installed_assets() {
  rm -f "$HELPER_DEST"
  rm -f "$SERVICE_DEST"
  rm -f "$ICONS_DEST"/neon-folder-cyberwire-cyan.svg
  rm -f "$ICONS_DEST"/neon-folder-ghost-cyan.svg
  rm -f "$ICONS_DEST"/neon-folder-threat-pink.svg
  rm -f "$ICONS_DEST"/neon-folder-neon-purple.svg
  rm -f "$ICONS_DEST"/neon-folder-warning-amber.svg
  rm -f "$ICONS_DEST"/neon-folder-poison-green.svg
  rm -f "$ICONS_DEST"/neon-folder-void-black.svg
  rm -f "$ICONS_DEST"/neon-folder-panel-charcoal.svg
}

main() {
  case "${1:-}" in
    --help|-h)
      usage
      exit 0
      ;;
    --reset-directory-icons)
      shift
      reset_directory_icons "$@"
      refresh_kde_service_cache
      exit 0
      ;;
    "")
      remove_installed_assets
      refresh_kde_service_cache
      cat <<EOF
Uninstalled Neon District: CyberWire folder color service assets.

Left folder .directory customizations in place.
Optional cleanup for Neon District icon entries:
  $0 --reset-directory-icons /path/to/folder
EOF
      ;;
    *)
      usage >&2
      exit 1
      ;;
  esac
}

main "$@"

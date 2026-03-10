#!/usr/bin/env bash

set -euo pipefail

# ========== CONFIG ==========

# Font ZIP URLs (EDIT THIS LIST)
FONT_URLS=(
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip"
)

# Change to "system" for /usr/local/share/fonts (requires sudo)
INSTALL_SCOPE="user"

# Supported font extensions
FONT_EXTENSIONS=("ttf" "otf")

# ============================

# Temporary working directory
WORKDIR="$(mktemp -d)"

cleanup() {
    rm -rf "$WORKDIR"
}
trap cleanup EXIT

# Determine font directory
if [[ "$INSTALL_SCOPE" == "system" ]]; then
    FONT_DIR="/usr/local/share/fonts"
    SUDO="sudo"
else
    FONT_DIR="$HOME/.local/share/fonts"
    SUDO=""
fi

echo "📁 Installing fonts to: $FONT_DIR"
mkdir -p "$FONT_DIR"

for URL in "${FONT_URLS[@]}"; do
    echo "⬇️  Downloading: $URL"

    ZIP_NAME="$(basename "$URL")"
    ZIP_PATH="$WORKDIR/$ZIP_NAME"

    curl -L --fail -o "$ZIP_PATH" "$URL"

    echo "📦 Extracting: $ZIP_NAME"
    unzip -qq "$ZIP_PATH" -d "$WORKDIR/extracted"

    for EXT in "${FONT_EXTENSIONS[@]}"; do
        FOUND_FONTS=$(find "$WORKDIR/extracted" -type f -iname "*.${EXT}" || true)
        if [[ -n "$FOUND_FONTS" ]]; then
            echo "🔤 Installing .$EXT fonts"
            echo "$FOUND_FONTS" | xargs -I{} $SUDO cp "{}" "$FONT_DIR/"
        fi
    done

    rm -rf "$WORKDIR/extracted"
done

echo "🔄 Refreshing font cache"
$SUDO fc-cache -f -v

echo "✅ Font installation completed"

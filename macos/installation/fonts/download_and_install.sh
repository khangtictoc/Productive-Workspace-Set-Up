#!/usr/bin/env bash

FONT_URLS=(
    "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.4.0/FiraCode.zip"
)

install_fonts() {
    case "$(uname -s)" in
        Darwin) FONT_DIR="$HOME/Library/Fonts" ;;
        Linux)  FONT_DIR="$HOME/.local/share/fonts" ;;
        *) echo "[ERROR] Unsupported OS"; exit 1 ;;
    esac

    mkdir -p "$FONT_DIR"

    for url in "${FONT_URLS[@]}"; do
        FILENAME=$(basename "$url")
        FONTNAME="${FILENAME%.zip}"

        echo "[INSTALLING ⬇️] Font: $FONTNAME"
        curl -fsSL --retry 3 --retry-delay 5 --connect-timeout 30 --max-time 120 \
            "$url" -o "/tmp/$FILENAME"

        unzip -o "/tmp/$FILENAME" -d "/tmp/$FONTNAME"

        # Copy only font files, skip license/readme
        find "/tmp/$FONTNAME" -type f \( -iname "*.ttf" -o -iname "*.otf" \) \
            -exec cp {} "$FONT_DIR/" \;

        echo "[INFO] Clean up"
        rm -rf "/tmp/$FILENAME" "/tmp/$FONTNAME"

        echo "[CHECKED ✅] $FONTNAME installed to $FONT_DIR"
    done

    # Refresh font cache (Linux only — macOS picks up fonts automatically)
    if [[ "$(uname -s)" == "Linux" ]] && command -v fc-cache &>/dev/null; then
        fc-cache -fv "$FONT_DIR"
        echo "[CHECKED ✅] Font cache refreshed"
    fi
}

install_fonts
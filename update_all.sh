#!/bin/bash
set -e  # Exit if any command fails

BACKUP_DIR="$HOME/config-backup"
SCRIPT_NAME="$(basename "$0")"

SOURCE_DIRS=(
    "$HOME/.config/hypr"
    "$HOME/.config/waybar"
    "$HOME/.config/nvim"
    "$HOME/.config/ghostty/"
    "$HOME/.config/fish/"
    "$HOME/.config/wofi/"
)

SOURCE_FILES=(
    "$HOME/.zshrc"
)

echo "=== Removing old configs from $BACKUP_DIR ==="
if [ -w "$BACKUP_DIR" ]; then
    find "$BACKUP_DIR" -mindepth 1 \
        ! -name "$SCRIPT_NAME" \
        -exec sudo rm -rf {} +
fi

echo "=== Copying configs to $BACKUP_DIR ==="
for SRC in "${SOURCE_DIRS[@]}"; do
    if [ -d "$SRC" ]; then
        cp -r "$SRC" "$BACKUP_DIR"
        echo "Copied: $SRC"
    else
        echo "Warning: $SRC not found, skipping."
    fi
done
for FILE in "${SOURCE_FILES[@]}"; do
    if [ -f "$FILE" ]; then
        cp "$FILE" "$BACKUP_DIR"
        echo "Copied file: $FILE"
    else
        echo "Warning: $FILE not found, skipping."
    fi
done

echo "=== Done. You can now commit to Git. ==="

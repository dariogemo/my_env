#!/usr/bin/env bash

WALLPAPER_DIR="$HOME/Media/wallpapers/"
CURRENT_WALL=$(hyprctl hyprpaper listloaded | grep "eDP-1" | cut -d',' -f2)
CURRENT_WALL_BASENAME=$(basename "$CURRENT_WALL")
WALLPAPER=$(find "$WALLPAPER_DIR" -type f ! -name "$CURRENT_WALL_BASENAME" | shuf -n 1)

hyprctl hyprpaper preload "$WALLPAPER"
hyprctl hyprpaper wallpaper "eDP-1,$WALLPAPER"

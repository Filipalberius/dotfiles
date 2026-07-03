#!/usr/bin/env bash

TERM_CLASS="myterm"
TERM_WORKSPACE="5"
TERM_CMD="alacritty --class $TERM_CLASS"

ADDR=$(hyprctl clients -j | jq -r ".[] | select(.class == \"$TERM_CLASS\") | .address" | head -n1)

if [ -n "$ADDR" ]; then
    hyprctl dispatch focuswindow address:$ADDR
else
    hyprctl dispatch workspace "$TERM_WORKSPACE"
    $TERM_CMD &
fi

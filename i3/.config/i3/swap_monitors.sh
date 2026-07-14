#!/bin/bash
# Swap whichever workspaces are currently on the two monitors

FIRST="DP-2"
SECOND="DP-0"

WS_FIRST=$(i3-msg -t get_workspaces | jq -r --arg o "$FIRST" '.[] | select(.output==$o) | .name')
WS_SECOND=$(i3-msg -t get_workspaces | jq -r --arg o "$SECOND" '.[] | select(.output==$o) | .name')

# Move the workspace from SECOND to FIRST, then the one from FIRST to SECOND
i3-msg "workspace \"$WS_SECOND\"; move workspace to output \"$FIRST\""
i3-msg "workspace \"$WS_FIRST\"; move workspace to output \"$SECOND\""

# Refocus original workspace so the mouse/focus stays predictable
i3-msg "workspace \"$WS_FIRST\""

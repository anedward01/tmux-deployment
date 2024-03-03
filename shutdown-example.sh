#!/usr/bin/env bash
# This script is a hook for the file located at /usr/servers/tmux.sh
# and sends the shutdown procedure for the program.

SESSION_DIR="/usr/servers/Server"
FILE_NAME=$(basename -s .sh $0)
SESSION="tmux -S $SESSION_DIR send-keys -t Servers"
WINDOW="$SESSION:$FILE_NAME"
MANAGE="tmux select-window -t Management"

# Insert shutdown commands here. Begin with $WINDOW to direct commands
# into its proper window. This prevents collisions with other programs

# Example command to stop Minecraft server
#$WINDOW "stop" C-m

# Closes the TMUX window for this filename
$WINDOW "exit" C-m
#!/bin/bash

# This script is a hook for the file located at /usr/servers/tmux.sh
# and adds a window to TMUX session "Servers".

SESSION_DIR="/usr/servers/Server"

# Pulls filename for TMUX window. Typically name this file a concatenated string
# "exampleServer.sh" or "ExampleServer.sh" to avoid issues
FILE_NAME=$(basename -s .sh $0)

SESSION="tmux -S $SESSION_DIR send-keys -t Servers"

WINDOW="$SESSION:$FILE_NAME"

MANAGE="tmux select-window -t Management"

# The following creates a new window, renames it to the corresponding server,
# then reselects the Management window for conflict prevention.
$SESSION":Management" "$MANAGE && tmux new-window && tmux rename-window $FILE_NAME && $MANAGE" C-m

# This is necessary. Without it, the following commands won't find its window.
sleep 0.01

# The following runs the actual server commands to its specific window.
# Make sure the folders are made before launching this script
$WINDOW "cd /usr/servers/serverFiles/example" C-m

# Example command of running a Minecraft server
#$WINDOW "java -Xmx10G -jar server.jar nogui" C-m
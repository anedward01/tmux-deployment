#!/usr/bin/env bash

# Add servers alias to launch TMUX session
# Can be changed to different alias

echo "Adding servers alias to ~/.bash_aliases"
echo "alias servers=\"sudo tmux -S /usr/servers/Server attach -t Servers\"" >> ~/.bash_aliases

echo "run \"source ~/.bashrc\" to load new alias"
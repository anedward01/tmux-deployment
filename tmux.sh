#!/usr/bin/env bash
# This file begins the Terminal MUltipleXor (TMUX) session the servers
# will be running on.

SESSION="tmux -S /usr/servers/Server send-keys -t Servers"
tmux -S "/usr/servers/Server" new -s "Servers" -d
$SESSION "tmux rename-window 'Management'" C-m
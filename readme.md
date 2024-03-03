<h1>Overview</h1>
I love TMUX, so I set it up as a user service running in its own folder and environment. It has extra security features and prevents sudo from being run within the TMUX terminal.
The script installs TMUX by setting up the serverd user and servermod group, setting up the example files, copying the serverd service file, and enabling serverd on boot and running the service.
I also included add-alias.sh which adds "servers" as an alias to connect to the TMUX socket.

<h1>Installation</h1>
Currently the script is designed around Ubuntu Server, but additional support may be added for other operating systems. Simply chmod +x tmux-deployment.sh file and run it as root.
Alongside, chmod +x add-alias.sh and run it without root, along with ~/.bashrc to load the alias.

<h1>Testing</h1>
To test the installation, simply run "servers" or equivalent "sudo tmux -S /usr/servers/Server attach -t Servers" command to hop into the TMUX socket.
If it says No Session Found, restart serverd.service.

#!/bin/bash

# Session names
authserver_session="auth-session"
worldserver_session="world-session"

# Commands
authserver="$HOME/azerothcore-wotlk/acore.sh run-authserver"
worldserver="$HOME/azerothcore-wotlk/acore.sh run-worldserver"

# Create auth session if it doesn't exist
if ! tmux has-session -t $authserver_session 2>/dev/null; then
    if tmux new-session -d -s $authserver_session; then
        echo "Created authserver session: $authserver_session"
    else
        echo "Error creating authserver session: $authserver_session"
        exit 1
    fi
else
    echo "Session $authserver_session already exists"
fi

# Create world session if it doesn't exist
if ! tmux has-session -t $worldserver_session 2>/dev/null; then
    if tmux new-session -d -s $worldserver_session; then
        echo "Created worldserver session: $worldserver_session"
    else
        echo "Error creating worldserver session: $worldserver_session"
        exit 1
    fi
else
    echo "Session $worldserver_session already exists"
fi

# Start authserver
if tmux send-keys -t $authserver_session "$authserver" C-m; then
    echo "Executed \"$authserver\" inside $authserver_session"
    echo "You can attach using: tmux attach -t $authserver_session"
else
    echo "Error executing \"$authserver\" inside $authserver_session"
    exit 1
fi

# Start worldserver
if tmux send-keys -t $worldserver_session "$worldserver" C-m; then
    echo "Executed \"$worldserver\" inside $worldserver_session"
    echo "You can attach using: tmux attach -t $worldserver_session"
else
    echo "Error executing \"$worldserver\" inside $worldserver_session"
    exit 1
fi

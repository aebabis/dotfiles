#!/bin/zsh

session=main
session_exists=$(tmux list-sessions | grep $session)

# window 1 is for current project or primary focus
tmux new-window -t $session:1 -n 'project'
tmux send-keys -t 'project' "cd $projects" C-m C-l
tmux split-window -t 'project' -v -p 20 -c "$HOME/$projects" -d

# attach
tmux attach-session -t $session:1

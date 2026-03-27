#!/bin/zsh

session=main

if ! tmux has-session -t "$session" 2>/dev/null
then
  projects=$(ls ~ | egrep '^[Pp]rojects$' | head -1)
  tmux new-session -d -s $session

  # window 0 is the meta window, for writing dotfiles
  tmux run-shell -t "$session" "$(dirname "$0")/open-project.zsh -w -n '自然' '$HOME/$projects/dotfiles'"

  # window 1 is for dashboard
  tmux new-window -c "$HOME" -t $session:1 -n 'dashboard'
  tmux split-window -t 'dashboard' -v -p 20 -c "$HOME"
  tmux send-keys -t 'dashboard' "yazi" C-m
  tmux split-window -t 'dashboard' -h -p 66 -c "$HOME"
  tmux send-keys -t 'dashboard' "clear; echo \"\033[33mtwin <path>\033[0m to open project in new window\"" C-m
  tmux select-pane -U
  tmux send-keys -t 'dashboard' "nvim \"$HOME/Notes.md\"" C-m
  tmux split-window -t 'dashboard' -h -p 66 -c "$HOME"
  tmux send-keys -t 'dashboard' "lazydocker" C-m

  # attach
  tmux attach-session -t $session:1
fi

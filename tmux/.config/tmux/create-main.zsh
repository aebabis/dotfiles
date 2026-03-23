#!/bin/zsh

session=main
session_exists=$(tmux list-sessions | grep $session)

if [ "$session_exists" = "" ]
then
  projects=$(ls | egrep '^.rojects$' | head -1)
  tmux new-session -d -s $session

  # window 0 is the meta window, for writing dotfiles
  tmux run-shell -t "$session" "$(dirname "$0")/open-project.zsh -w -n '自然' '$HOME/$projects/dotfiles'"

  # window 1 is for current project or primary focus
  tmux run-shell -t "$session" "$(dirname "$0")/open-project.zsh -n 'project' '$HOME/$projects'"

  # window 2 is support window for window 1 (e.g. dev server, scrumboard)
  tmux new-window -t $session:2 -n 'project-aux'
  tmux send-keys -t 'project-aux' "cd $projects" C-m C-l
  tmux split-window -t 'project-aux' -h -c "$HOME/$projects" -d

  # create a 3rd window without naming it
  tmux new-window -t $session:3

  # attach
  tmux attach-session -t $session:1
fi

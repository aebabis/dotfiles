#!/bin/zsh

session=main
session_exists=$(tmux list-sessions | grep $session)

if [ "$session_exists" = "" ]
then
  projects=$(ls | egrep '^.rojects$' | head -1)
  tmux new-session -d -s $session

  # window 0 is the meta window, for writing dotfiles
  tmux rename-window -t 0 '自然'
  tmux send-keys -t '自然' 'nvim ~/Projects/dotfiles' C-m
  tmux split-window -t '自然' -v -p 20 -c "$HOME/$projects/dotfiles" -d

  # window 1 is for current project or primary focus
  tmux new-window -t $session:1 -n 'project'
  tmux send-keys -t 'project' "cd $projects" C-m C-l
  tmux split-window -t 'project' -v -p 20 -c "$HOME/$projects" -d

  # window 2 is support window for window 1 (e.g. dev server, scrumboard)
  tmux new-window -t $session:2 -n 'project-aux'
  tmux send-keys -t 'project-aux' "cd $projects" C-m C-l
  tmux split-window -t 'project-aux' -h -c "$HOME/$projects" -d

  # create a 3rd window without naming it
  tmux new-window -t $session:3

  # attach
  tmux attach-session -t $session:1
fi

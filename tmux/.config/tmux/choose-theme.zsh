#!/bin/zsh

. ~/.shell-functions

if [[ "$(os_appearance)" == "dark" ]]
then
  tmux source-file ~/.config/tmux/theme.dark.tmux.conf
else
  tmux source-file ~/.config/tmux/theme.light.tmux.conf
fi

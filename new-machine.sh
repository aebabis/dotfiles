#!/bin/sh

# Command dependencies
apps="stow go fzf tealdeer"

if command -v brew 2>&1 >/dev/null; then
  brew install $apps
elif command -v apt 2>&1 >/dev/null; then
  sudo apt install $apps
else
  >&2 echo "Installer not detected"
fi

# Plugin and repo dependencies
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

./link.sh

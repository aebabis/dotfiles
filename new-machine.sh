#!/bin/sh

# Run from dotfiles root so link.sh and clone target work regardless of cwd
cd "$(dirname "$0")" || exit 1

rude=$(echo gurshpx | tr "[a-z]" "[n-za-m]")
echo $rude

# Command dependencies
apps="stow fzf tealdeer"

if command -v brew 2>&1 >/dev/null; then
  brew install $apps go $rude
  cargo install --locked tree-sitter-cli
elif command -v apt 2>&1 >/dev/null; then
  sudo apt install $apps golang-go tree-sitter-cli
  sudo apt install python3-dev python3-pip python3-setuptools
  pip3 install $rude --user
else
  >&2 echo "Installer not detected"
fi

# Plugin and repo dependencies
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm

./link.sh

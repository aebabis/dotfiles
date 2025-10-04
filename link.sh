#/!bin/sh
dir=$(dirname "$0")

# ROOT (HOME) DOTFILES
stow  -d "$dir"  -t ~  home

# MODULE (CONFIG) DOTFILES
mkdir -p ~/.config
stow  -d "$dir"  -t ~  ghostty
stow  -d "$dir"  -t ~  lazygit
stow  -d "$dir"  -t ~  nvim
stow  -d "$dir"  -t ~  tmux

# LOCAL (CONFIG) DOTFILES
mkdir -p ~/.local
stow  -d "$dir"  -t ~  bin


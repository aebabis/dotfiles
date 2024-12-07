#/!bin/sh

# ROOT (HOME) DOTFILES
stow --ignore='$(pwd)/*' . -t ~

# MODULES (CONFIG DOTFILES)
mkdir -p .config
stow nvim -t ~
stow tmux -t ~


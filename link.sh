#/!bin/sh

# ROOT (HOME) DOTFILES
stow --ignore='./*' . -t ~

# MODULES (CONFIG DOTFILES)
mkdir -p .config
stow nvim -t ~


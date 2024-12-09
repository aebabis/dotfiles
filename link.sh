#/!bin/sh

# ROOT (HOME) DOTFILES
stow home -t ~

# MODULE (CONFIG) DOTFILES
mkdir -p .config
stow nvim  -t ~
stow tmux  -t ~


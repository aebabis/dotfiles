# Preferences
setopt NO_BEEP # Disable Beep
export CLICOLOR=1
export VISUAL=nvim

autoload -U colors && colors
autoload -Uz compinit && compinit   # Command Autocomplete

# vi mode
bindkey -v
bindkey -M viins '^P' up-line-or-history
bindkey -M viins '^N' down-line-or-history
bindkey -M vicmd '^P' up-line-or-history
bindkey -M vicmd '^N' down-line-or-history

# Prompt
setopt PROMPT_SUBST
PROMPT='%F{243}%~%f %f%F{249}%%%f '

# History Autocomplete
if command -v fzf 2>&1 >/dev/null; then
  source <(fzf --zsh)
else
  setopt SHARE_HISTORY
  HISTFILE=$HOME/.zhistory
  SAVEHIST=1000
  HISTSIZE=999
  setopt HIST_EXPIRE_DUPS_FIRST
fi

# Load nvm, if present
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm

source ~/.zaliases                  # Load aliases
source ~/.zpath       2> /dev/null  # Update $PATH
source ~/.zlocal      2> /dev/null  # Optional (unversioned) config


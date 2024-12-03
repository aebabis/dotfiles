# Preferences
export CLICOLOR=1
setopt NO_BEEP # Disable Beep

# Autocomplete
if command -v fzf 2>&1 >/dev/null; then
  source <(fzf --zsh)
else
  setopt SHARE_HISTORY
  HISTFILE=$HOME/.zhistory
  SAVEHIST=1000
  HISTSIZE=999
  setopt HIST_EXPIRE_DUPS_FIRST
fi

source ~/.zaliases                    # Load aliases
source ~/.zpath         2> /dev/null  # Update $PATH
source ~/.zlocal_config 2> /dev/null  # Optional (unversioned) config

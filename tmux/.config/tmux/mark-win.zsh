#!/bin/zsh
mark_win() {
  if [[ -n "$TMUX" ]]; then
    local rawname=$(tmux display-message -t "$TMUX_PANE" -p '#W' | sed -E 's/^(#\[fg=#[^]]*\])?\*(#\[fg=#[^]]*\])?//');
    if (( $# == 0 )); then
      tmux rename-window -t "$TMUX_PANE" "$rawname"
    else #665544
      tmux rename-window -t "$TMUX_PANE" "#[fg=$1]*#[fg=#{@text}]$rawname"
    fi
  fi
}

mark_win $@;

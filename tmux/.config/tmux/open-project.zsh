#!/bin/zsh
# Usage: ./open-project.zsh [-w] [-s session] [-c command1] [-c command2] [-n name] <dir>
#   -w  configure the current window instead of creating a new one
#   -s  tmux session name (defaults to current session via display-message)

main() {
  # parse options
  local -a c_vals n_vals s_vals w_flag
  zparseopts -D -E -- c+:=c_vals n:=n_vals s:=s_vals w=w_flag

  local session="${s_vals[2]:-$(tmux display-message -p "#S")}"
  local -a commands=(${c_vals:#-c})  # c_vals is (-c val -c val ...), strip the flag entries
  local name="${n_vals[2]}"
  local dir="$1"
  local use_current=$(( ${#w_flag} > 0 ))

  # determine window name using either flag or current window name
  local window
  if [[ -n "$name" ]]; then
    window="$name"
  elif (( use_current )); then
    window=$(tmux display-message -p "#{window_name}")
  else
    window=$(basename "$dir")
  fi

  if (( use_current )); then
    # rename the current window
    tmux rename-window "$window"
  else
    # abort if window name already exists in this session
    if tmux list-windows -t "$session" -F "#{window_name}" | grep -qx "$window"; then
      echo "open-project: window '$window' already exists in session '$session'" >&2
      return 1
    fi

    # create new window
    tmux new-window -n "$window" -c "$dir"
  fi

  # split into top (80%) and bottom (20%) pane, track bottom pane id
  local bottom_pane=$(tmux split-window -t "$session:$window" -v -p 20 -c "$dir" -P -F "#{pane_id}")

  # run nvim in the top pane
  tmux send-keys -t "$session:$window.0" "cd '$dir'" C-m
  tmux send-keys -t "$session:$window.0" "nvim ." C-m

  # split bottom pane into horizontal panes, running a command in each one
  local numcommands=${#commands[@]}
  if [[ $numcommands -gt 0 ]]; then
    local remaining=$((numcommands + 1))
    local cmd new_pane width
    for cmd in "${commands[@]}"; do
      width=$((100 / remaining))
      new_pane=$(tmux split-window -b -t "$bottom_pane" -h -p $width -c "$dir" -P -F "#{pane_id}")
      tmux send-keys -t "$new_pane" "$cmd" C-m
      (( remaining-- ))
    done
  fi

  # switch to new window and focus last pane
  tmux select-window -t "$session:$window"
  tmux select-pane -t "$session:$window.{last}"
}

main "$@"

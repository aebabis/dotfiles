#!/bin/zsh
function nostyle () {
  echo $1 | awk -F: '{gsub(/#[\[][^]]*[\]]/, ""); print}'
}

function left-width () {
  format=$(tmux show-window-options -g | grep "^window-status-format")
  format=${format:22:-1}
  tabText=$(tmux list-windows -F "$(nostyle $format)" | tr -d '\n')
  # Indicators on far left have length of 5
  echo $((5 + $(echo $tabText | wc -m)))
}

function right-width () {
  format=$(tmux show-options -g | grep "^status-right" | head -1)
  format=${format:14:-2}
  formatWithoutStyle=$(echo $format | awk -F: '{gsub(/#[\[][^]]*[\]]/, ""); print}')
  formatWithoutStyle=$(echo $formatWithoutStyle | awk -F: '{gsub(/#\(/, "\$("); print}')
  formatWithoutStyle=$(eval "echo \"$formatWithoutStyle\"")
  rightText=$(tmux display -p "$formatWithoutStyle")
  echo $rightText | wc -m 
}

function center-text () {
  max=$1
  text=" $(
    git rev-parse --abbrev-ref --symbolic-full-name @{u} ||
    git rev-parse --abbrev-ref HEAD
  )"
  size=$(echo $text | wc -m)
  if [[ $size -gt $max ]]; then
    trunc=$(($max - 1))
    text="$(echo $text | cut -c 1-$trunc)…"
  fi
  echo $text
}

totalWidth=$(tmux display -p '#{window_width}')
leftSize=$(left-width)
rightSize=$(right-width)
availableSpace=$(($totalWidth - $leftSize - $rightSize - 1))

if [[ $availableSpace -ge 3 ]]; then
  centerText="$(center-text $availableSpace)"
  centerSize=$(echo $centerText | wc -m)

  preferredLocation=$((($totalWidth - $centerSize) / 2))

  if [[ $preferredLocation -ge $leftSize ]]; then
    echo "#[align=absolute-centre] $centerText "
  else
    echo "#[align=centre]$(printf "%-${availableSpace}s" " $centerText ")"
  fi
fi


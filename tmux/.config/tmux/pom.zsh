#!/bin/zsh
zmodload zsh/mathfunc

MONTH=29.53059
EPOCH=1731727716  # 2024-11-15 22:28:36
PHASES=
COUNT=$(($(echo $PHASES | wc -m) - 1))

OFFSET=$(($MONTH/$COUNT/2))  # Switch to next icon when halfway there

now=$(date +%s)
seconds=$(($now - $EPOCH))
days=$(echo "$seconds/3600/24+$OFFSET" | bc -l)
phase=$((fmod($days, $MONTH)))
index=$(printf "%d" $(($phase*28/$MONTH)))
icon=$(echo $PHASES | cut -c$((index+1)))
if [[ "$1" == "--index" ]]; then
  echo $index
else
  echo $icon
fi

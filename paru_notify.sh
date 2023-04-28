#!/bin/zsh

paru_command="paru $@"
paru_output=""

${paru_command} 2>&1 | while IFS= read -r line; do
  paru_output+="$line\n"
  echo "$line"
  if [[ $line == *"(default=all)"* ]]; then
    # 入力が求められた時にデスクトップ通知と通知音を送る
    notify-send "Paru Update" "Input required for package update"
    canberra-gtk-play -i dialog-information
  fi
done

echo -e "\nParu command output:\n$paru_output"


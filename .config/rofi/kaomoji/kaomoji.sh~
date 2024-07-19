#!/usr/bin/env bash

dir="$HOME/.config/rofi/kaomoji"
styles=($(ls -p --hide="colors.rasi" $dir/styles))
color="${styles[$(( $RANDOM % 10 ))]}"

current_wid=$(xdo id)
# selection=$(rofi -i -dmenu $@ < $(dirname $0)/kaomoji.txt)
selection=$(rofi -i -dmenu -theme jellu.rasi < $(dirname $0)/kaomoji.txt)
kaomoji=$(echo $selection | sed "s|$(echo -e "\ufeff").*||")
echo -n "$kaomoji" | xclip -selection clipboard
xdotool key --window $current_wid --clearmodifiers ctrl+v

#!/bin/zsh

xdef="$HOME/.Xdefaults"

colors=( $( sed -re '/^!/d; /^$/d; /^#/d; s/(\*color)([0-9]):/\10\2:/g;' $xdef | grep 'color[01][0-9]:' | sort | sed  's/^.*: *//g' ) )

echo -e "\e[1;37m 
 Black    Red      Green    Yellow   Blue     Magenta   Cyan    White   
──────────────────────────────────────────────────────────────────────\e[0m"
for i in {0..7}; echo -en "\e[$((30+$i))m $colors[i+1] \e[0m"
echo
for i in {8..15}; echo -en "\e[1;$((22+$i))m $colors[i+1] \e[0m"
echo -e "\n"

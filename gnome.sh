#!/bin/bash

function store {
    echo "storing...";
    if [ ! -d gnome ]; then
	mkdir gnome
    fi
    dconf dump /org/gnome/desktop/wm/keybindings/ > gnome/keybindings.dconf
    git add -A gnome/
    now=$(date +"%Y-%m-%d %H:%M")
    git commit -m "Changes from $now"
    git push origin master
}

function load {
    echo "loading...";
    if [ -f gnome/keybindings.dconf ]; then
	dconf load /org/gnome/desktop/wm/keybindings/ < gnome/keybindings.dconf
    fi
}

case $1 in
    "store" )
	store;;
    "load" )
	load;;
    *)
	echo "usage: ./gnome.sh store or ./gnome.sh load";;
esac
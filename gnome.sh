#!/bin/bash

function store {
    echo "storing...";
    if [ ! -d gnome ]; then
	mkdir gnome
    fi
    dconf dump /org/gnome/desktop/wm/keybindings/ > gnome/keybindings.dconf
    dconf dump /org/gnome/desktop/wm/preferences/ > gnome/preferences.dconf
    dconf dump /org/gnome/shell/ > gnome/shell.dconf
    git add -A gnome/
    now=$(date +"%Y-%m-%d %H:%M")
    git commit -m "Changes from $now"
    git push origin master
}

function load {
    echo "loading...";
    load_file keybindings.dconf /org/gnome/desktop/wm/keybindings/
    load_file preferences.dconf /org/gnome/desktop/wm/preferences/ 
    load_file shell.dconf /org/gnome/shell/
}

function load_file {
echo $1 into $2
   if [ -f gnome/$1.dconf ]; then
	dconf load $2 < gnome/$1.dconf
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

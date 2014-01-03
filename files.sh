#!/bin/bash

script_dir=$PWD/configs

function createlinks {
    echo "Processing \"$1\""
    for file in $(ls -A $1); do
	local current_file_path=$1/$file
	local current_file_stripped=$(echo $current_file_path | sed 's|'$script_dir/'||g')
	if [ ! -e ~/$current_file_stripped ]; then
            echo "Creating ~/$current_file_stripped"
            ln -s $current_file_path ~/$current_file_stripped
        elif [ -d $1/$file ]; then
	    echo "\"$current_file_stripped\" already exists - going deeper"
	    createlinks $current_file_path
        fi
    done
}

case $1 in
    "store" )
	echo "storing..."
	git add -A 
	now=$(date +"%Y-%m-%d %H:%M")
	git commit -m "Changes from $now"
	git push origin master
	;;
    "load" )
	echo "loading..."
	createlinks $script_dir
	;;
    * )
	echo "Usage: ./files.sh store or ./files.sh load"
	;;
esac
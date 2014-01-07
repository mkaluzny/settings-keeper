#!/bin/bash

script_dir=$PWD/configs

function createlinks {
    for file in $(ls -A $1); do
	local current_file_path=$1/$file
	local current_file_stripped=~/$(echo $current_file_path | sed 's|'$script_dir/'||g')
	if [ ! -e $current_file_stripped ]; then
		createlink "$current_file_stripped" $current_file_path
	elif [ -d $current_file_stripped ] && [ ! -h $current_file_stripped ]; then
		printf "\"$current_file_stripped\" already exists - should I override it with symlink? [y/N] "
		read -n 1 key
		printf "\n"
		if [[ $key = "y" ]]; then
			rm -r $current_file_stripped
			createlink "$current_file_stripped" $current_file_path
		else
			createlinks $current_file_path
		fi
        fi
    done
}

function createlink {
	echo "Creating $1"
	ln -s $2 $1
}

case $1 in
    "store" )
	echo "storing..."
	git add -A configs
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

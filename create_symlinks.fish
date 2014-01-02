set script_dir $PWD/configs
function createlinks
    echo "Processing \"$argv\""
    for file in (ls -A $argv)
	set -l current_file_path $argv/$file
	set -l current_file_stripped (echo $current_file_path | sed 's|'$script_dir/'||g')
	if not test -e ~/$current_file_stripped
            echo "Creating ~/$current_file_stripped"
            ln -s $current_file_path ~/$current_file_stripped
        else if test -d $argv/$file
	    echo "\"$current_file_stripped\" already exists - going deeper"
	    createlinks $current_file_path
        end
    end
end
createlinks $script_dir
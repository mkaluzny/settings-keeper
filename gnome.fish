function store
    echo "storing...";
    if not test -d gnome
        mkdir gnome
    end
    dconf dump /org/gnome/desktop/wm/keybindings/ > gnome/keybindings.dconf
    git add -A gnome/
    set -l now (date +"%Y-%m-%d %H:%M")
    git commit -m "Changes from $now"
    git push origin master
end

function load 
    echo "loading...";
    if test -e gnome/keybindings.dconf
        dconf load /org/gnome/desktop/wm/keybindings/ < gnome/keybindings.dconf
    end
end

switch (echo $argv)
    case store
	store
    case load
	load
    case '*'
	echo "Usage: fish gnome.fish store or fish gnome.fish load"
end
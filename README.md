### This project allows you to manage all your configuration files

#### In order to use it you just need to:

1. Fork and checkout this project
2. Move all your config files (eg. .gitconfig, .ssh/, etc) into checkout_dir/configs directory
3. Commit added files into repository:
  ```
cd checkout_dir
./files.sh store
```

4. Now you have to create symlinks:
```
cd checkout_dir
./files.sh load
```

5. Enjoy - all your config files are now being kept in repository
6. There is also specific functionality for:
  * Gnome - allows backuping keyboard shortcuts:
Use ```./gnome.sh store``` to save configuration
and ``` ./gnome.sh load``` to load

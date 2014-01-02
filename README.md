### This project allows you to manage all your configuration files

#### In order to use it you just need to:

1. Fork and checkout this project
2. Move all your config files (eg. .gitconfig, .ssh/, etc) into checkout_dir/configs directory
3. Commit added files into repository:
  ```
cd checkout_dir
git add .
git commit -m "My settings"
git push origin master
```

4. Now you have to create symlinks:
```
cd checkout_dir
fish create_symlinks.fish
```

5. Enjoy - all your config files are now being kept in repository

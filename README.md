## My dot files

This is a repo that stores all important config file mappings in `destination.yaml` on all of my computers

## how to use confsync

In the repo:

```
python3 propogate_dotfiles.py
```

## Quick setup (for the editor)

Best to run it on home directory:

```
bash <(curl -s https://raw.githubusercontent.com/LumenYoung/dotfiles/master/install/nvim_install.sh)
```

## Quick setup (for all)

```
bash <(curl -s https://raw.githubusercontent.com/LumenYoung/dotfiles/master/install/nvim_install.sh)
cd ~/dotfiles
python3 propogate_dotfiles.py
cd ..
```

## ZSH

Use a `~/.local.zsh` file to store zsh commands that will not be synced.

if [[ $(hostname) == "introspector" ]]; then
    export PATH=$PATH:/sbin:/bin:/usr/sbin:/usr/bin:/usr/syno/sbin:/usr/syno/bin:/usr/local/sbin:/usr/local/bin
    alias docker-com=$HOME/docker-com
fi

if [ $(hostname) = "node" ]; then
  export DET_MASTER=https://determined.corp.deepmirror.com:443 
  # alias ezpxy="export http_proxy=http://localhost:8888;export https_proxy=http://localhost:8888;export ALL_PROXY=socks5://localhost:1080"
  alias ezpxy="export http_proxy=http://localhost:8888;export https_proxy=http://localhost:8888"
  alias apdir="cd ~/Desktop/Advanced-programming/tutorials"
  export EDITOR=lvim
fi

if [[ $(uname) == "Darwin" ]]; then
  source /opt/homebrew/opt/powerlevel10k/powerlevel10k.zsh-theme
  unalias ls
fi

# for the archlinux machines
if [[ -f "/etc/arch-release" ]]; then
  if [[ -d "/nix" ]]; then
     export PATH=$PATH:~/.nix-profile/bin
     export NIX_PATH=$NIX_PATH:~/.nix-defexpr/channels/
  fi
fi

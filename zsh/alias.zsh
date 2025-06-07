
# cd and ls
c() { builtin cd "$@" && ls; }

alias lvim-clean-sessions="rm ~/.local/share/lvim/sessions/ -rf"

refresh-build() {
  if [ "$(basename "$(pwd)")" != "build" ]; then
    echo "Warning: this alias should run at the build directory"
    echo "abort, please cd to build directory"
    return
  fi

  cd ..
  rm -rf build
  mkdir build
  cd build
}

# for opening zathura faster
# alias za="zathura"
za() {
  zathura $@ &
}
# for sioyek
# alias si="sioyek"
si() {
  sioyek $@ &
}

alias xo="xdg-open"

alias -g ..='..'
alias -g ...='../..'
alias -g ....='../../..'

alias lg="lazygit"
alias ldocker="lazydocker"

alias cpr='rsync --archive -hh --partial --info=stats1 --info=progress2 --modify-window=1'

alias vifm='vifm .'
alias ra='ranger . '
alias T='tmux new-session -A -s remote' 
alias tmux='tmux -u'
alias sudo="sudo "

alias pgrep="pdfgrep -r -n -i"

# kde xorg systemsettings
alias xcb-system="QT_QPA_PLATFORM=xcb systemsettings"

alias kssh="kitty +kitten ssh"

if (which dolphin > /dev/null); then
  alias d="dolphin . 2>/dev/null &" 
fi

alias xmind="xmind --no-sandbox"
# for fuzzy pdfgrep
alias pf="fuzzy-pdf -m 0"
# for the zoxide
alias z="zoxide "
# for fast go to downloads dir
alias down="cd ~/Downloads && vf "
# for the proxy
alias pxy="export http_proxy=http://127.0.0.1:1089;export https_proxy=http://127.0.0.1:1089;export ALL_PROXY=socks5://127.0.0.1:1089"
# for unproxy
alias unpxy='unset all_proxy; unset http_proxy; unset https_proxy'


alias start='sudo systemctl start'
alias stop='sudo systemctl stop'
alias restart='sudo systemctl restart'
alias status='systemctl status'
alias enable='sudo systemctl enable'
alias disable='sudo systemctl disable'
alias reload='sudo systemctl reload'

alias config-git-user='git config user.name "Lumen Yang" && git config user.email "lumen.yang@lumeny.io"'

alias vf="vfcd . " 

alias btop="btop --force-utf"

# alias ls="exa "

if (which eza > /dev/null); then
  alias ls="eza "
  alias ll="eza -l "
else
  alias ls="ls --color=auto "
  alias ll="ls -l "
fi

alias zshconf="vim ~/.zshrc"
alias conf="cd ~/.config && vim"
alias dot="cd ~/dotfiles && vim"
# for now I'm learning cpp. I want to fast cd to the directory
alias cppcourse="cd /home/yang/Desktop/CPP && vf "
# for helping zotero get rid of enforced dark theme 
alias zotero="GTK_THEME=Default zotero "

uvsh() {
    local venv_name=${1:-'.venv'}
    venv_name=${venv_name//\//} # remove trailing slashes (Linux)
    venv_name=${venv_name//\\/} # remove trailing slashes (Windows)

    local venv_bin=
    if [[ -d ${WINDIR} ]]; then
        venv_bin='Scripts/activate'
    else
        venv_bin='bin/activate'
    fi

    local activator="${venv_name}/${venv_bin}"
    echo "[INFO] Activate Python venv: ${venv_name} (via ${activator})"

    if [[ ! -f ${activator} ]]; then
        echo "[ERROR] Python venv not found: ${venv_name}"
        return
    fi

    # shellcheck disable=SC1090
    . "${activator}"
}

if [[ "${SHELL##*/}" = "zsh" ]]; then
  alias refresh-fzf="rm ~/.local/bin/fzf && exec zsh"
fi

if (which vdirsyncer > /dev/null); then
  alias vsync="vdirsyncer sync"
fi

if (which zellij > /dev/null); then
  alias zj="zellij"
  function zjc() {
    local session_name
    if [ -z "$1" ]; then
      session_name=$(hostname)
    else
      session_name=$1
    fi
    
    if zellij list-sessions | grep -q "$session_name"; then
      echo "Session with name \"$session_name\" already exists. Deleting it."
      zellij delete-session $session_name
    fi
    zellij options --simplified-ui true --pane-frames false --session-name $session_name
  }

  zjd() {
    local session_name="$1"
    if [ -z "$session_name" ]; then
      echo "Please provide a session name."
      return 1
    fi
    zellij delete-session "$session_name"
    read -q "REPLY?Session deleted. Create a new session with the same name? (Y/n) "
    echo
    if [[ $REPLY =~ ^[Yy]$ || $REPLY == "" ]]; then
      zjc "$session_name"
    fi
  }
fi

if (which yazi > /dev/null); then
  function ya() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		cd -- "$cwd"
	fi
	rm -f -- "$tmp"
  }
fi

# if (which lvim > /dev/null); then
#   alias vim="lvim "
# fi

if (which distrobox > /dev/null); then
  alias dsb="distrobox "
fi

if command -v pacman &> /dev/null; then
  alias S='sudo pacman -S'
  alias Sa='paru -Sa'
  alias Syu='sudo pacman -Syu'
  alias R='sudo pacman -R'
  alias Rns='sudo pacman -Rns'
  alias Fy='sudo pacman -Fy'
  alias syu='paru -Syu'
  alias Ss='pacman -Ss'
  alias Si='pacman -Si'
  alias Ssa='paru -Ssa'
  alias Qs='pacman -Qs'
  alias Qi='pacman -Qi'
  alias Ql='pacman -Ql'
  alias Qo='pacman -Qo'
  alias Qe='pacman -Qe'
  alias Qdt='pacman -Qdt'
  alias Qdtq='pacman -Qdtq'
  alias Qql='pacman -Qql'
  alias Fl='pacman -Fl'
  alias Fx='pacman -Fx'
  alias G='paru -G'
fi

function sudo() {
    case $1 in 
        vi|vim|nvim|lvim) command sudo -E "$@";;
        *) command sudo "$@";;
    esac
}

function man() {
  LESS_TERMCAP_md=$'\e[01;31m' \
  LESS_TERMCAP_me=$'\e[0m' \
  LESS_TERMCAP_se=$'\e[0m' \
  LESS_TERMCAP_so=$'\e[01;44;33m' \
  LESS_TERMCAP_ue=$'\e[0m' \
  LESS_TERMCAP_us=$'\e[01;32m' \
  command man "$@"
}

function ln-ccjson() {
  # Get the current directory
  local current_dir=$(pwd)

  # Get the base name of the current directory
  local base_name=$(basename $current_dir)

  # Check if the base name is 'build'
  if [[ $base_name == 'build' ]]; then
    # Get the project root path
    local project_root=$(dirname $current_dir)

    # Check if compile_commands.json exists in the current directory
    if [[ -f "$current_dir/compile_commands.json" ]]; then
      # Create a soft link to the project root
      ln -s "$current_dir/compile_commands.json" "$project_root/compile_commands.json"
      echo "Soft link created successfully."
    else
      echo "Error: compile_commands.json does not exist in the current directory."
    fi
  else
    echo "Error: The base name of the current directory is not 'build'. You should use this alias in the build folder"
  fi
}

function create_justfile_template() {
  cat <<'EOF' > justfile
# Example justfile
# Defines common tasks

# Define variables
build_dir := "build"

# Compile the project
build:
    @echo "Compiling the project..."
    mkdir -p build && cd build && cmake .. && make

# Clean build artifacts
clean:
    @echo "Cleaning up..."
    rm -rf $build_dir

# Run the project
run: build
    @echo "Running the project..."
    ./build/output

# Default task
default: build
EOF

  echo "Template justfile created in the current directory."
}

# Make the function a command by creating an alias
alias createjust="create_justfile_template"

alias update-aider="pip3 install --upgrade aider-chat"

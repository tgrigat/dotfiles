#!/usr/bin/env bash

important_info=()
install_nvm=false

# Parse command line arguments
for arg in "$@"
do
    case $arg in
        --nvm)
        install_nvm=true
        shift # Remove --nvm from processing
        ;;
    esac
done

function check_term() {
	echo "enter check_term"
	if [ "$TERM" != "xterm-256color" ]; then
		if [ "$SHELL" = "/bin/bash" ]; then
			echo 'export TERM="xterm-256color"' >>~/.bashrc
		elif [ "$SHELL" = "/bin/zsh" ]; then
			echo 'export TERM="xterm-256color"' >>~/.zshrc
		fi
	fi
}

function eget_install() {
	# get eget
	echo "enter eget_install"
	curl -o eget.sh https://zyedidia.github.io/eget.sh
	bash eget.sh
	mkdir -p ~/.local/bin
	mv eget ~/.local/bin/

	export PATH=~/.local/bin:$PATH

	# eget
	eget sharkdp/fd --asset ^musl --to ~/.local/bin
	eget BurntSushi/ripgrep --to ~/.local/bin
	eget jesseduffield/lazygit --to ~/.local/bin
	eget sxyazi/yazi --asset musl --to ~/.local/bin
}

function nvm_install() {
	# nvm and then install node
	echo "enter nvm_install"
	touch ~/.bashrc
	curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.5/install.sh | bash
	export NVM_DIR="$HOME/.nvm"
	[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"                   # This loads nvm
	[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion" # This loads nvm bash_completion
	nvm install node

	# Try to run npm install
	if ! npm install -g neovim tree-sitter-cli; then
		important_info+=("npm install failed, but script continues")
		important_info+=("npm install -g neovim tree-sitter-cli")
	fi
}

# Update PATH
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
	important_info+=("~/.local/bin is not in the PATH. Make sure to add it to your config: export PATH=~/.local/bin:\$PATH")
	important_info+=("echo -e '\e[32mecho \"export PATH=~/.local/bin:\$PATH\" >> ~/.bashrc\e[0m'")
else
	echo "~/.local/bin is in the PATH"
fi

# Check for git, python, curl and pip3
for cmd in git curl make; do
	if ! command -v $cmd &>/dev/null; then
		echo "Error: $cmd is not installed."
		exit 1
	fi
done

echo "Start check_term"
check_term

if $install_nvm; then
    echo "Start nvm_install"
    nvm_install
else
    echo "Skipping nvm installation (use --nvm flag to install)"
fi

bash <(curl -s https://raw.githubusercontent.com/LunarVim/LunarVim/master/utils/installer/install-neovim-from-release)

# clone my dotfiles

# if ~/dotfiles not exists, clone repo https://github.com/LumenYoung/dotfiles

if [[ ! -d ~/dotfiles ]]; then
	git clone https://github.com/LumenYoung/dotfiles ~/dotfiles
fi

# Link my config
if [[ -d ~/dotfiles ]]; then
	cd ~/dotfiles || exit
	mkdir -p ~/.config
	ln -sf "$(pwd)/nvim" ~/.config/nvim
	ln -sf "$(pwd)/vim_wrapper.sh" ~/.local/bin/vim
fi

# Print important information at the end
if [ ${#important_info[@]} -ne 0 ]; then
	echo "IMPORTANT INFORMATION:"
	for info in "${important_info[@]}"; do
		echo "$info"
	done
fi

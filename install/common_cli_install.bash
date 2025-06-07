#!/usr/bin/env bash

# Check if ~/.local/bin is in PATH, if not add it
if [[ ":$PATH:" != *":$HOME/.local/bin:"* ]]; then
    export PATH="$HOME/.local/bin:$PATH"
fi

# get eget
curl -o eget.sh https://zyedidia.github.io/eget.sh
bash eget.sh
mv eget ~/.local/bin/

# eget
eget sharkdp/fd --asset ^musl --to ~/.local/bin
eget BurntSushi/ripgrep --to ~/.local/bin
eget jesseduffield/lazygit --to ~/.local/bin
eget zellij-org/zellij --to ~/.local/bin
eget ajeetdsouza/zoxide --to ~/.local/bin
eget junegunn/fzf --to ~/.local/bin
eget casey/just --asset linux-musl --to ~/.local/bin
eget eza-community/eza --asset tar --asset linux-musl --to ~/.local/bin
eget sxyazi/yazi --asset linux-musl --to ~/.local/bin --file yazi
eget sxyazi/yazi --asset linux-musl --to ~/.local/bin --file ya
eget aristocratos/btop --to ~/.local/bin
eget sharkdp/bat --asset linux-musl --to ~/.local/bin
# eget neovim/neovim --to ~/.local/bin/nvim
# eget jpillora/chisel --asset deb --to ~/.local/bin

# eget atuinsh/atuin --to ~/.local/bin
# eget denisidoro/navi --to ~/.local/bin
# eget orf/gping --to ~/.local/bin
# eget jesvedberg/tpix --to ~/.local/bin
# eget hackerb9/lsix --to ~/.local/bin
# eget jesseduffield/lazydocker --to ~/.local/bin

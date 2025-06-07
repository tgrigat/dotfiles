export ZDOTDIR=$HOME/.config/zsh
export EDITOR=nvim
export VISUAL=nvim
export PATH=~/.local/bin:$PATH

# export LESSHISTFILE=-
# export GPG_TTY=$TTY
# export MANPAGER='sh -c "col -bx | bat -pl man"'
# export MANROFFOPT='-c'

typeset -U PATH path

path=(
    ~/.local/bin
    $path
)

# Notes: Modern unix tools.
# 1. dust - du
# 2. duf - df
# 3. procs - ps
# 4. bottom - top
# 5. exa - ls
# 6. zoxide - cd
# 7. ripgrep - grep
# 8. bat - cat
# 9. httpie - curl
# 10. hyperfine - time
# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.

# Switch to Fish only in interactive mode

if [[ -f ~/.local.zsh ]]; then
      source ~/.local.zsh
fi

if command -v fish &>/dev/null; then
    if [[ -o interactive ]] && [[ "$SHELL" != *"fish"* ]] && [[ $(ps -p $$ -ocomm=) != "fish" ]] && [[ -z "$NO_FISH" ]]
    then
        # Check if it's a login shell
        [[ -o login ]] && LOGIN_OPTION='--login' || LOGIN_OPTION=''
        
        # Execute Fish
        exec fish $LOGIN_OPTION
    fi
fi

##############################################################################
# Laptop configurations
##############################################################################

if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Set up the prompt
#----------------------------------------------------------------------------------------------------
# completion settings
#----------------------------------------------------------------------------------------------------
autoload -Uz compinit && compinit -d ~/.cache/zsh/zcompdump
setopt globdots

setopt correct
setopt complete_aliases
setopt auto_menu
setopt complete_in_word
setopt always_to_end
zmodload zsh/complist

zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion::complete:*' gain-privileges 1
zstyle ':completion:*' list-colors ''
zstyle -e ':completion:*' special-dirs '[[ $PREFIX = (../)#(|.|..) ]] && reply=(..)'
zstyle ':completion:*:*:kill:*' menu yes select
zstyle ':completion:*:kill:*'   force-list always
zstyle ':completion:*' cache-path ~/.cache/zsh/zcompcache
zstyle ':completion:*' use-cache on
zstyle ':completion:*' accept-exact '*(N)'

# cd options
setopt autocd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushd_minus
setopt pushd_silent

setopt interactive_comments
setopt auto_continue
# setopt extended_glob
# setopt no_bare_glob_qual
setopt listpacked
setopt magic_equal_subst

# rm option
setopt rm_star_silent

setopt numeric_glob_sort

#----------------------------------------------------------------------------------------------------
# history settings
#----------------------------------------------------------------------------------------------------
HISTORY_IGNORE="(ls|l|ll|cd|pwd|exit|vim|.|..|...)"
HISTSIZE=10000
SAVEHIST=10000
HISTFILE=~/.cache/zsh/zsh_history
setopt hist_ignore_all_dups
setopt hist_ignore_space
setopt hist_find_no_dups
setopt hist_save_no_dups
setopt hist_verify
setopt hist_reduce_blanks
setopt share_history
setopt append_history

#----------------------------------------------------------------------------------------------------
# prompt settings
#----------------------------------------------------------------------------------------------------
# autoload -Uz promptinit && promptinit
# prompt redhat
autoload -U colors && colors
setopt prompt_subst

#----------------------------------------------------------------------------------------------------
# misc settings
#----------------------------------------------------------------------------------------------------

if command -v moar &> /dev/null; then
  export PAGER=moar
fi

#POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(anaconda ...ENVS)

# prompt
if [[ $TTY =~ "/dev/tty" ]]; then
    autoload -Uz promptinit && promptinit
    prompt redhat
else
    if (which starship > /dev/null);then
        # use starship if avaliable
        eval "$(starship init zsh)"
    else
        #========================================
        # powerlevel10k configs
        #========================================
        # left prompts
        if [[ -z "$SSH_CONNECTION" ]]; then
            POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(user dir vcs)
            POWERLEVEL9K_USER_DEFAULT_BACKGROUND='232'
            POWERLEVEL9K_USER_DEFAULT_FOREGROUND='250'
            POWERLEVEL9K_USER_ROOT_BACKGROUND='250'
            POWERLEVEL9K_USER_ROOT_FOREGROUND='232'
        else
            POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(host dir vcs)
            POWERLEVEL9K_HOST_BACKGROUND='232'
            POWERLEVEL9K_HOST_FOREGROUND='250'
            POWERLEVEL9K_SSH_ICON="\uF489"
        fi
        # left colors
        # use some custom grey instead of black to avoid transparency
        POWERLEVEL9K_DIR_DEFAULT_BACKGROUND='045'
        POWERLEVEL9K_DIR_DEFAULT_FOREGROUND='000'
        POWERLEVEL9K_DIR_ETC_BACKGROUND='045'
        POWERLEVEL9K_DIR_ETC_FOREGROUND='000'
        POWERLEVEL9K_DIR_HOME_BACKGROUND='039'
        POWERLEVEL9K_DIR_HOME_FOREGROUND='000'
        POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='039'
        POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='000'
        # right prompts
        POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(vi_mode status root_indicator dir_writable)
        # right colors
        POWERLEVEL9K_STATUS_OK_BACKGROUND='232'
        POWERLEVEL9K_VI_MODE_NORMAL_BACKGROUND='232'
        POWERLEVEL9K_VI_MODE_NORMAL_FOREGROUND='250'
        POWERLEVEL9K_VI_MODE_VISUAL_BACKGROUND='232'
        POWERLEVEL9K_VI_MODE_VISUAL_FOREGROUND='250'
        # only show error status
        POWERLEVEL9K_STATUS_OK=false
        # Vim mode indecator
        POWERLEVEL9K_VI_INSERT_MODE_STRING=''
        POWERLEVEL9K_VI_COMMAND_MODE_STRING='N'
        #POWERLEVEL9K_VI_VISUAL_MODE_STRING='V' #visual mode does not exist(?)
        # shorten the directory path TODO: fix this
        POWERLEVEL9K_SHORTEN_DIR_LENTH=1
        POWERLEVEL9K_SHORTEN_DELIMITER=""
        POWERLEVEL9K_SHORTEN_STRATEGY="truncate_to_last"
        if [[ -f /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme ]]; then
            source /usr/share/zsh-theme-powerlevel10k/powerlevel10k.zsh-theme
        else
            if [[ ! -f ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme ]]; then
                [[ ! -d ~/.local/share/zsh/plugins ]] && mkdir -p ~/.local/share/zsh/plugins
                git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ~/.local/share/zsh/plugins/powerlevel10k
            fi
            source ~/.local/share/zsh/plugins/powerlevel10k/powerlevel10k.zsh-theme
        fi
    fi

    #========================================
    # prompt extensions
    #========================================
    # sudo pacman -S zsh-completions zsh-autosuggestions zsh-syntax-highlighting zsh-history-substring-search
    ZSH_AUTOSUGGEST_STRATEGY=(completion history)
    ZSH_AUTOSUGGEST_USE_ASYNC=1
    ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
    autoload autosuggest-accept
    zle -N autosuggest-accept

    function check_plugin() {
        if [[ -f /usr/share/zsh/plugins/"$1"/"$1".zsh ]]; then
            source /usr/share/zsh/plugins/"$1"/"$1".zsh
        else
            if [[ ! -f ~/.local/share/zsh/plugins/"$1"/"$1".zsh ]]; then
                [[ ! -d ~/.local/share/zsh/plugins ]] && mkdir -p ~/.local/share/zsh/plugins
                git clone --depth=1 https://github.com/zsh-users/"$1".git ~/.local/share/zsh/plugins/"$1"
            fi
            source ~/.local/share/zsh/plugins/"$1"/"$1".zsh
        fi
    }

    check_plugin zsh-syntax-highlighting
    check_plugin zsh-autosuggestions
    check_plugin zsh-history-substring-search

    unset -f check_plugin
fi

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

function auto_compile() {
    if [[ $1 -nt $1.zwc ]] || [[ ! -e $1.zwc ]]; then
        zcompile -R $1
    fi
}

function auto_source() {
    auto_compile $1
    . $1
}

auto_source $ZDOTDIR/plugins.zsh
auto_source $ZDOTDIR/keys.zsh
auto_source $ZDOTDIR/alias.zsh
auto_source $ZDOTDIR/functions.zsh
auto_source $ZDOTDIR/device.zsh
auto_source $ZDOTDIR/env.zsh
auto_source $ZDOTDIR/aider.zsh

if command -v zoxide &> /dev/null ; then
  auto_source $ZDOTDIR/zoxide.zsh
fi

unset -f auto_source

#----------------------------------------------------------------------------------------------------
# auto compile zshrc
auto_compile $ZDOTDIR/.zshrc
unset -f auto_compile

alias mba="micromamba"

# export PYENV_ROOT="$HOME/.pyenv"
# command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
# eval "$(pyenv init -)"

# More Zsh configurations...

# To customize prompt, run `p10k configure` or edit ~/.config/zsh/.p10k.zsh.
[[ ! -f ~/.config/zsh/.p10k.zsh ]] || source ~/.config/zsh/.p10k.zsh

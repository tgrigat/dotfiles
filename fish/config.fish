if status is-login
    exec bash -c "test -e /etc/profile && source /etc/profile;\
    exec fish"
end

set sponge_delay 20
set sponge_purge_only_on_exit true

if status is-interactive
    # Commands to run in interactive sessions can go here
    if command -v zoxide >/dev/null
        zoxide init fish | source
    end

    if test -f ~/.local.fish
        source ~/.local.fish
    end
    set -g fish_key_bindings fish_vi_key_bindings

end


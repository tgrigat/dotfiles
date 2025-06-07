#!/usr/bin/bash
# export GTK_IM_MODULE=fcitx
# export QT_IM_MODULE=fcitx
export XMODIFIERS=@im=fcitx
# setting environmental variables under wayland
if [[ "$XDG_SESSION_TYPE" = "wayland" ]]; then
    export MOZ_ENABLE_WAYLAND=1
    export QT_QPA_PLATFORM=wayland
else
    # fix x11 crashing when relogin from wayland
    unset MOZ_ENABLE_WAYLAND
    unset QT_QPA_PLATFORM
fi
setxkbmap -option caps:escape_shifted_capslock

export PATH=~/.local/bin:$PATH

# for synology support
export QT_QPA_PLATFORM="wayland;xcb"

# enable firefox wayland
export MOZ_ENABLE_WAYLAND=1

# # to proxy all the plasma

# export http_proxy=http://127.0.0.1:1089
# export https_proxy=http://127.0.0.1:1089
# export ALL_PROXY=socks5://127.0.0.1:1089
dbus-update-activation-environment --systemd XDG_CURRENT_DESKTOP=KDE XDG_SESSION_TYPE DISPLAY XAUTHORITY WAYLAND_DISPLAY

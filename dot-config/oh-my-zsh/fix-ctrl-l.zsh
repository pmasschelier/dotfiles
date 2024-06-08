# This fixes the Ctrl-L keybinding which,
# by default, will not simply scroll down
# See: https://wiki.archlinux.org/title/Zsh#Clear_the_backbuffer_using_a_key_binding

function clear-screen-and-scrollback() {
    printf '\x1Bc'
    zle clear-screen
}

zle -N clear-screen-and-scrollback
bindkey '^L' clear-screen-and-scrollback


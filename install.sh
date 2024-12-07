#!/usr/bin/sh

confirm_and_run() {
    local prompt="$1"
    local action="$2"

    read -r -p "$prompt (y/n) " response
    response=${response,,}  # Convert response to lowercase

    if [[ "$response" == "y" ]]; then
        eval "$action"
    else
        echo "Action canceled."
    fi
}

install_nerd_font() {
    LOCAL_FONT_FOLDER=~/.local/share/fonts
    NERD_FONT_FOLDER=$LOCAL_FONT_FOLDER/JetBrainsMono
    mkdir -p $LOCAL_FONT_FOLDER 
    if [[ ! -d $NERD_FONT_FOLDER ]] then
        mkdir -p $NERD_FONT_FOLDER
        curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.tar.xz | tar xJf - -C $NERD_FONT_FOLDER
    fi
}

install_rustup() {
    export RUSTUP_HOME="$XDG_DATA_HOME/rustup"
    export CARGO_HOME="$XDG_DATA_HOME/cargo"
    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
}

install_bun() {
    export BUN_INSTALL="$XDG_DATA_HOME/bun"
    curl -fsSL https://bun.sh/install | bash
}

install_nvm() {
    export NVM_DIR="$XDG_DATA_HOME/nvm"
    export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"
    mkdir -p ~/.local/share/nvm
    PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'
}

mkdir -p ~/bin
stow --dotfiles --target=$HOME . || (rmdir ~/bin 2>&1 > /dev/null && exit 1)

# XDG Base Directory
# See: https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"

confirm_and_run "Do you want to install a JetBrainsMono font ?" "install_nerd_font"
confirm_and_run "Do you want to install rustup ?" "install_rustup"
confirm_and_run "Do you want to install bun ?" "install_bun"
confirm_and_run "Do you want to install nvm ?" "install_nvm"



#!/usr/bin/sh

LOCAL_FONT_FOLDER=~/.local/share/fonts
NERD_FONT_FOLDER=$LOCAL_FONT_FOLDER/JetBrainsMono
mkdir -p ~/bin ~/.config/zsh $LOCAL_FONT_FOLDER ~/.local/share/nvm
if [[ ! -d $NERD_FONT_FOLDER ]] then
	mkdir $NERD_FONT_FOLDER
	curl -L https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.tar.xz | tar xJf - -C $NERD_FONT_FOLDER
fi
stow --dotfiles --target=$HOME .

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -fsSL https://bun.sh/install | bash
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'

#!/usr/bin/sh

mkdir -p ~/bin ~/.config ~/.local/share/fonts
[[ -d ~/.local/share/fonts/JetBrainsMono ]] || curl https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.tar.xz | tar xf -C ~/.local/share/fonts
stow --dotfiles --target=~ .

#!/usr/bin/sh

mkdir -p ~/bin ~/.config/zsh ~/.local/share/fonts ~/.local/share/nvm
[[ -d ~/.local/share/fonts/JetBrainsMono ]] || curl https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/JetBrainsMono.tar.xz | tar xf -C ~/.local/share/fonts
stow --dotfiles --target=~ .

curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
curl -fsSL https://bun.sh/install | bash
PROFILE=/dev/null bash -c 'curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash'

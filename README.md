# My configuration files

## Installation

### Minimal requirements

To install this configuration you should at least have `git`, `stow` and `unzip` (for bun install) installed.

Moreover this configuration is intended to be used with zsh

On Fedora you can change to use zsh with these commands:
```sh
sudo dnf install zsh
sudo chsh $USER
> /bin/zsh
```

### Cloning this repository

```sh
git clone --recurse-submodules https://github.com/pmasschelier/dotfiles.git
```

### With Fedora:

```
sudo dnf install neovim bat fzf ripgrep fd-find
sudo dnf copr enable pgdev/ghostty
sudo dnf install ghostty
sudo dnf copr enable atim/lazygit -y
sudo dnf install lazygit
sudo dnf fastfetch procs git-delta duf procs glances
cargo install du-dust
./install.sh
```

## Backup

You can use the backup-exclude.txt file to filter your backup
```sh
tar czvf "`date --iso-8601`.tar.gz" -X backup-exclude.txt .
```

## Neovim configuration

My neovim configuration is based on the LazyVim distribution.
I manage it as a separate repository using git-subtree package.

[See here for more informations](https://www.atlassian.com/git/tutorials/git-subtree)

## Javascript configuration

I use node and bun as javascript runtime. The installation folders are controlled by:
```
export NVM_DIR="$XDG_DATA_HOME/nvm"
export NPM_CONFIG_USERCONFIG="$XDG_CONFIG_HOME/npmrc"
export BUN_INSTALL="$XDG_DATA_HOME/bun"
```

$NVM_DIR and bun are installed under $XDG_DATA_HOME.
You can edit the given config file for npm with:
```
npm config edit --location=user
```

You can choose the version of npm with nvm:
```
# install and use node v17
nvm install 17
nvm use 17
# restore to system version
nvm use system
```

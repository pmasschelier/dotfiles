echo "Running .zenv..."

# Setup PATH variable
typeset -U path PATH
OPT_PATHS=`echo /opt/*/bin /opt/*/build`
# z parameter expansion flags:
# Split the result of the expansion into words using shell parsing to find the words
# See: https://zsh.sourceforge.io/Doc/Release/Expansion.html
path=($path $HOME/bin ${(z)OPT_PATHS})
export PATH

# Compilation flags
export ARCHFLAGS="-march=native"

# XDG Base Directory
# See: https://wiki.archlinux.org/title/XDG_Base_Directory
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"
export XDG_STATE_HOME="$HOME/.local/state"


# Ensure Zsh directories exist.
() {
  local zdir
  for zdir in $@; do
    [[ -d "${(P)zdir}" ]] || mkdir -p -- "${(P)zdir}"
  done
} XDG_{CONFIG,CACHE,DATA,STATE}_HOME

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'  # For remote session
else
  export EDITOR='nvim' # For local session
fi

. "$HOME/.cargo/env"

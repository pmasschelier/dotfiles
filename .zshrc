# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH

# Path to your oh-my-zsh installation.
export ZSH="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh"
[[ -f "$HOME/bin/gef.py" ]] || wget -O ~/bin/gef.py -q https://gef.blah.cat/py

ZDOTDIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
# ZSH_COMPDUMP=$ZSH/cache/.zcompdump-$HOST
HISTFILE="$ZDOTDIR/zhistfile"

# Download oh-my-zsh, if it's not there yet
if [ ! -d "$ZSH" ]; then
	mkdir -p `dirname $ZSH`
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

[[ -d "$ZDOTDIR" ]] || mkdir -p $ZDOTDIR

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
HYPHEN_INSENSITIVE="true"

# Uncomment one of the following lines to change the auto-update behavior
# zstyle ':omz:update' mode disabled  # disable automatic updates
# zstyle ':omz:update' mode auto      # update automatically without asking
# zstyle ':omz:update' mode reminder  # just remind me to update when it's time

# Uncomment the following line to change how often to auto-update (in days).
# zstyle ':omz:update' frequency 13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# You can also set it to another string to have that shown instead of the default red dots.
# e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
# Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
ZSH_CUSTOM="${XDG_CONFIG_HOME:-$HOME/.config}/oh-my-zsh"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	# The Big Three
	zsh-syntax-highlighting
	zsh-autosuggestions
	zsh-completions
	# builtin plugins
	aliases # see: als --help
	alias-finder # suggest aliases 
	bgnotify # send notification for long-running commands
	bun # sets up completion for Bun
	colored-man-pages # adds colors to man pages
	copyfile # add copyfile command
	copypath # add copypath command
	fzf # enables fzf fuzzy auto-completion and key bindings
	git
	sudo # Appuyer 2 fois sur échap pour ajouter sudo
	web-search
	systemd
	# Other custom plugins
	fzf-tab # set fzf key-bindings and completion
)

[[ -f "/etc/redhat-release" ]] && plugins+=dnf

source $ZSH/oh-my-zsh.sh

# User configuration

#################### Configuration of completion plugin #################### 

# zstyle ':completion:*:make:*:targets' call-command true
# zstyle ':completion:*:*:make:*' tag-order 'targets'
# zstyle ':completion:*' menu no
# zstyle ':completion:*:*:*:*:paths' command 'fd --hidden --exclude .git .'
# zstyle ':completion:*:*:*:*:path-directories' command "echo test" # 'fd --type=d --hidden --exclude .git .'
# zstyle ':completion:*:*:*:*:command' command "echo test" # 'fd --type=d --hidden --exclude .git .'

# set descriptions format to enable group support
# NOTE: don't use escape sequences here, fzf-tab will ignore them
# zstyle ':completion:*:descriptions' format '[%d]'
# zstyle ':completion:*:*:*:*:processes' command "ps -u $USER -o pid,user,comm -w -w"

OPT_PATHS=`echo /opt/*/bin /opt/*/build | sed "s/ /:/g"`
export PATH="$PATH:$HOME/bin:$OPT_PATHS"
export MANPATH="/usr/share/man:$MANPATH"
export LESSOPEN='|~/bin/fzf-preview.zsh %s'

# --- setup fzf theme ---

# fg="#CBE0F0"
# bg="#011628"
# bg_highlight="#143652"
# purple="#B388FF"
# blue="#06BCE4"
# cyan="#2CF9ED"
#
# export FZF_DEFAULT_OPTS="--color=fg:${fg},bg:${bg},hl:${purple},fg+:${fg},bg+:${bg_highlight},hl+:${purple},info:${blue},prompt:${cyan},pointer:${cyan},marker:${cyan},spinner:${cyan},header:${cyan}"
# unset FZF_DEFAULT_OPTS

# -- Use fd instead of fzf --

export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

export FZF_CTRL_T_OPTS="--preview 'fzf-preview.zsh {}'"
export FZF_ALT_C_OPTS="$FZF_CTRL_T_OPTS"

# Use fd (https://github.com/sharkdp/fd) for listing path candidates.
# - The first argument to the function ($1) is the base path to start traversal
# - See the source code (completion.{bash,zsh}) for the details.
# _fzf_compgen_path() {
#   fd --hidden --exclude .git . "$1"
# }
#
# # Use fd to generate the list for directory completion
# _fzf_compgen_dir() {
#   fd --type=d --hidden --exclude .git . "$1"
# }
# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'  # For remote session
else
  export EDITOR='nvim' # For local session
fi

# Compilation flags
export ARCHFLAGS="-march=native"

# bun completions
[ -s "/home/tintin/.bun/_bun" ] && source "/home/tintin/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

# docker
export DOCKER_BUILDKIT=1

source "${XDG_CONFIG_HOME:-$HOME/.config}/broot/launcher/bash/br"
source "$HOME/.local/share/fzf-git.sh/fzf-git.sh"

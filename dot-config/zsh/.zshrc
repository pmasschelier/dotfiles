# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="${XDG_DATA_HOME:-$HOME/.local/share}/oh-my-zsh"

ZSH_CACHE_DIR="${ZSH_CACHE_DIR:-$ZSH/cache}"
# Alternative: store cache files in .cache folder
# ZSH_CACHE_DIR="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"

# Change completion cache filename (default: ${ZDOTDIR:-$HOME}/.zcompdump-${SHORT_HOST}-${ZSH_VERSION} )
ZSH_COMPDUMP="$ZSH_CACHE_DIR/zcompdump"

# Change history file (default: $HOME/.zsh_history)
HISTFILE="$ZSH_CACHE_DIR/zsh_history"

# Download oh-my-zsh, if it's not there yet
if [ ! -d "$ZSH" ]; then
	mkdir -p `dirname $ZSH`
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended --keep-zshrc
fi

[[ -d "$ZDOTDIR" ]] || mkdir -p $ZDOTDIR

[[ -f "$HOME/bin/gef.py" ]] || wget -O ~/bin/gef.py -q https://gef.blah.cat/py

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

# bun completions
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"

# nvm
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# docker
export DOCKER_BUILDKIT=1

source "${XDG_CONFIG_HOME:-$HOME/.config}/broot/launcher/bash/br"
source "$HOME/.local/share/fzf-git.sh/fzf-git.sh"

# Setup direnv
# See: https://direnv.net/
if (( $+commands[direnv] )); then
	eval "$(direnv hook zsh)"
fi


# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes.
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

alias c="clear"
alias cat="bat --pager=never --plain"
alias stow="stow --dotfiles"
alias ltree="tree -dL 3 | lolcat"

# tar
alias tarls="tar -tvf"
alias untar="tar -xf"

# Fix typos
alias cd..='cd ..'

# Compilers options
alias zcc="gcc $ARCHFLAGS -Wall -Wextra -pedantic -std=c11 -fno-common -fno-builtin"
alias zpp="g++ $ARCHFLAGS -Wall -Wextra -pedantic -std=c++20 -fno-common -fno-builtin"
alias disasm="objdump --source-comment='; ' --disassembler-color=extended --disassembler-options=intel --no-show-raw-insn"
if (( $+commands[zigup] )); then
	alias zigup="zigup --install-dir $ZIG_INSTALL --path-link $HOME/.local/bin/zig"
fi

alias sld="streamlink --hls-segment-threads 2 -p mpv -a '--cache=yes --demuxer-max-bytes=8192KiB --hwdec=auto-safe'"
alias ytb-music="yt-dlp -x -f 'bestaudio[ext=m4a]' -o '~/Musique/tmp/%(title)s.%(ext)s' --no-playlist --embed-thumbnail"
alias ytb-playlist="yt-dlp -x -f 'bestaudio[ext=m4a]' -o '~/Musique/tmp/%(playlist)s/%(playlist_index)s - %(title)s.%(ext)s' --yes-playlist --embed-thumbnail --embed-metadata"
# alias sudo="sudo -v; sudo "

# systemctl aliases
alias sysstart="sudo systemctl start"
alias sysrestart="sudo systemctl restart"
alias sysstatus="sudo systemctl status"
alias sysstop="sudo systemctl stop"

# alias nvim="alacritty -e nvim &"

alias myip="curl http://ipecho.net/plain; echo"
alias path='echo $PATH | sed "s/:/\n/g"'


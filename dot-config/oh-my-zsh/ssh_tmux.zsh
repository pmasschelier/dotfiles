function ssh_tmux() { ssh -t "$@" "tmux a || tmux"; }

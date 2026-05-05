export PATH="$PATH:$HOME/.hoop/bin"

alias hl='hoop login'

# Run hoop connect every second
# Usage: hc [p] [rw]
hc() {
  local p=5435 e=stag
  [[ $1 == p ]] && { p=5433; e=prod; }
  while :; do hoop connect talisman-$e-${2:-ro} --port $p; sleep 1 || break; done
}

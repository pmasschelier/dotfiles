export PATH="$PATH:$HOME/.hoop/bin"

alias hl='hoop login'

# Run hoop connect every second
# Usage: hc [p] [rw]
hc() {
    # Turn off job control notifications
    setopt local_options no_monitor no_notify
    # Opens a new fd that points wherever fd 2 is currently pointing
    exec {ferr}>&2
    local p=5435 e=stag bad pid line
    [[ $1 == p ]] && { p=5433; e=prod; }
    local role=talisman-$e-${2:-ro}
    while :; do
        bad=0
        # Start hoop connect asynchronously
        coproc hoop connect $role --port $p
        pid=$!
        # read from hoop stdout line by line
        while read -r -p line; do
            if [[ $line == *"wrong format"* ]]; then 
                bad=1
                kill $pid 2>/dev/null
                break
            fi
            print -r -- "$line"
        done
        # Wait for the subprocess to be killed
        wait $pid 2>/dev/null
        (( bad )) && { gum confirm "hoop logged out — re-login?" && hoop login || break; }
        sleep 1 || break
    done
}

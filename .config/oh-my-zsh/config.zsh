#################### Plugins configurations #################### 

#################### Configuration of zsh-completions plugin #################### 

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

#################### Configuration of completion plugin #################### 

# autoload -Uz compinit && compinit

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

#################### Configuration of bgnotify plugin #################### 
#
# bgnotify_bell=false   ## disable terminal bell
# bgnotify_threshold=4  ## set your own notification threshold
#
# function bgnotify_formatted {
#   ## $1=exit_status, $2=command, $3=elapsed_time
#
#   # Humanly readable elapsed time
#   local elapsed="$(( $3 % 60 ))s"
#   (( $3 < 60 ))   || elapsed="$((( $3 % 3600) / 60 ))m $elapsed"
#   (( $3 < 3600 )) || elapsed="$((  $3 / 3600 ))h $elapsed"
#
#   [ $1 -eq 0 ] && title="Holy Smokes Batman" || title="Holy Graf Zeppelin"
#   [ $1 -eq 0 ] && icon="$HOME/icons/success.png" || icon="$HOME/icons/fail.png"
#   bgnotify "$title - took ${elapsed}" "$2" "$icon"
# }

#################### Configuration of alias-finder plugin #################### 

zstyle ':omz:plugins:alias-finder' autoload yes # disabled by default
zstyle ':omz:plugins:alias-finder' longer yes # disabled by default
zstyle ':omz:plugins:alias-finder' exact yes # disabled by default
zstyle ':omz:plugins:alias-finder' cheaper yes # disabled by default

#################### Configuration of fzf-tab plugin #################### 

# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# give a preview of commandline arguments when completing `kill`
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-preview \
  '[[ $group == "[process ID]" ]] && ps --pid=$word -o cmd --no-headers -w -w'
zstyle ':fzf-tab:complete:(kill|ps):argument-rest' fzf-flags --preview-window=down:3:wrap

# zstyle ':fzf-tab:complete:*:*' fzf-preview 'less ${(Q)realpath}'

# show_file_or_dir_preview="if [ -d $ ]; then eza --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza --tree --level 3 --color=always ${(Q)realpath} | head -200'
zstyle ':fzf-tab:complete:*:*' fzf-preview 'fzf-preview.zsh $realpath' # 'less ${(Q)realpath}'
# zstyle ':fzf-tab:complete:*:path-directories' fzf-preview 'echo test' # 'eza --tree --level 3 --color=always ${(Q)realpath} | head -200'
# zstyle ':fzf-tab:complete:*:*' fzf-flags --preview-window=bottom:100:wrap
zstyle ':fzf-tab:complete:*:options' fzf-preview 
zstyle ':fzf-tab:complete:*:argument-1' fzf-preview

zstyle ':fzf-tab:complete:(-command-|-parameter-|-brace-parameter-|export|unset|expand):*' fzf-preview 'echo ${(P)word}'


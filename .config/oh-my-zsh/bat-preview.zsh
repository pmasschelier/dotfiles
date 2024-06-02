#!/usr/bin/zsh

bat-preview ()
{
	bat --list-themes | fzf --preview="bat --theme={} --color=always $1"
}


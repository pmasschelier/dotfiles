#!/usr/bin/zsh

mime=$(file -bL --mime-type "$1")
category=${mime%%/*}
kind=${mime##*/}

if [ -d "$1" ]; then
	if (( $+commands[eza] )); then
		eza --tree -L 2 --git -hl --color=always --icons "$1"
	else
		ls --color "$1"
	fi
# elif [ "$category" = image ]; then
# 	chafa "$1"
# 	exiftool "$1"
# elif [ "$kind" = vnd.openxmlformats-officedocument.spreadsheetml.sheet ] || \
# 	[ "$kind" = vnd.ms-excel ]; then
# 	in2csv "$1" | xsv table | bat -ltsv --color=always
elif [ "$category" = text ] || [ "$kind" = json ] || [ "${kind:0:3}" = svg ]; then
	if (( $+commands[bat] )); then
		bat --plain --color=always "$1"
	else
		cat "$1"
	fi
elif [ "$category" = application ] && [ "$kind" = "x-executable" ]; then
	readelf -h "$1"
else
	echo "MIME: $category/$kind"
	lesspipe.sh "$1" || file "$1"
fi
# lesspipe.sh don't use eza, bat and chafa, it use ls and exiftool. so we create a lessfilter.

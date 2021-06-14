#! /usr/bin/env fish


while read -S -p "set_color green; echo; echo (git branch --show-current)/(basename (git rev-parse --show-toplevel); set_color efefef; commandline -i 'git '" cmd
  clear
	eval "$cmd"
end

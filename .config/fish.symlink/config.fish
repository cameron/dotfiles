set PATH "$HOME/bin" "$HOME/src/dotfiles/bin" "/usr/local/Cellar/ruby/2.6.5/bin" "$HOME/Library/Python/3.7/bin/" "/usr/local/bin" "$HOME/.rbenv/shims/" "/usr/local/go/bin" "./.bin/" "$HOME/.cargo/bin" $PATH
set -x GOPATH "$HOME/src/ftx/go/ftx/" $GOPATH

set -U EDITOR emacs
set -x EDITOR emacs # git didn't pick up the -U invocation
set -x PUSHD_USER cameron

set fish_greeting

function __create_and_or_attach_to_tmux --on-variable PWD --description "\
If the switched-to directory has a .tmux file, attempt to attach to an
exiting tmux session according to the name of the directory. If such a
session does not exist, run the .tmux file to create one and attach to it.
"
  status --is-command-substitution; and return
  if test -f .tmux.workspace-init
			tmux.workspace-join
  end
end

set -U fish_color_autosuggestion      brwhite
set -U fish_color_cancel              -r
set -U fish_color_command             brgreen
set -U fish_color_comment             brmagenta
set -U fish_color_cwd                 green
set -U fish_color_cwd_root            red
set -U fish_color_end                 brmagenta
set -U fish_color_error               brred
set -U fish_color_escape              brcyan
set -U fish_color_history_current     --bold
set -U fish_color_host                normal
set -U fish_color_match               --background=brblue
set -U fish_color_normal              normal
set -U fish_color_operator            cyan
set -U fish_color_param               brblue
set -U fish_color_quote               yellow
set -U fish_color_redirection         bryellow
set -U fish_color_search_match        'bryellow' '--background=brblack'
set -U fish_color_selection           'white' '--bold' '--background=brblack'
set -U fish_color_status              red
set -U fish_color_user                brgreen
set -U fish_color_valid_path          --underline
set -U fish_pager_color_completion    normal
set -U fish_pager_color_description   yellow
set -U fish_pager_color_prefix        'white' '--bold' '--underline'
set -U fish_pager_color_progress      'white' '--background=cyan'

alias emacs "emacs -nw"

set -x LDFLAGS "-L/usr/local/opt/openssl@1.1/lib -L/usr/local/lib -L/usr/local/opt/expat/lib"
set -x CFLAGS "-I/usr/local/opt/openssl@1.1/include/ -I/usr/local/include -I/usr/local/opt/expat/include"
set -x CPPFLAGS "-I/usr/local/opt/openssl@1.1/include/ -I/usr/local/include -I/usr/local/opt/expat/include"

set fish_prompt_pwd_dir_length 3

function fish_prompt
		set repo_path (git rev-parse --show-toplevel 2> /dev/null)
		set prompt_path (prompt_pwd)
		if ! test -z "$repo_path"
				set repo_name (basename $repo_path)
				set prompt_path (pwd | sed "s/.*$repo_name/$repo_name/")
				set branch (git branch --show-current)
		end

		set_color brwhite
		echo -n $prompt_path
		if set -q branch
				set_color green
				echo -n " $branch"
				set_color white
		end
		echo -n ' > '

		if set -q TMUX_GIT; and set -q branch
				commandline -i 'git ' # prefix the command line with 'git' (trying it out as a feature of a dedicated git shell in workspaces)
		end
end

set -x PYTHONPATH "$HOME/src/python3/"
set PATH "$HOME/bin" "$HOME/src/go/bin" "$HOME/src/dotfiles/bin" "/usr/local/Cellar/ruby/2.6.5/bin" "$HOME/Library/Python/3.7/bin/" "/usr/local/bin" "$HOME/.rbenv/shims/" "/usr/local/go/bin" "./.bin/" "$HOME/.cargo/bin" "/opt/homebrew/bin" "$PYENV_ROOT/bin" "$PATH" "$HOME/src/deepatlas/bugle/" "$HOME/src/google-cloud-sdk/bin"
set PATH "$HOME/src/gpt/" "$PATH"
set -x GOPATH "$HOME/src/go/" $GOPATH
eval (pyenv init --path)



set -U EDITOR emacs
set -x EDITOR emacs # git didn't pick up the -U invocation
set -x PUSHD_USER cameron
set -x DOCKER_DEFAULT_PLATFORM linux/amd64
set fish_greeting

function __workspace_hook --on-variable PWD
  status --is-command-substitution; and return

  if test -f ./.tmux.workspace-init
			tmux.workspace-join
	else if test -n "$TMUX_PROJECT"
			set repo_path (git rev-parse --show-toplevel 2> /dev/null)
			if ! test -z "$repo_path"
					tmux rename-window (basename $repo_path)
			end
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
alias ll "ls -al"
alias kc 'kubectl'

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

# Created by `pipx` on 2024-07-11 17:13:35
set PATH $PATH /Users/cam/.local/bin

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/cam/Downloads/google-cloud-sdk/path.fish.inc' ]; . '/Users/cam/Downloads/google-cloud-sdk/path.fish.inc'; end

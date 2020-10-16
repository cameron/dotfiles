
set PATH "$HOME/bin" "$HOME/src/dotfiles/bin" "$HOME/Library/Python/3.7/bin/" $PATH

set -U EDITOR emacs
set -x EDITOR emacs # git didn't pick up the -U invocation

set fish_greeting

function __create_and_or_attach_to_tmux --on-variable PWD --description "\
If the switched-to directory has a .tmux file, attempt to attach to an
exiting tmux session according to the name of the directory. If such a
session does not exist, run the .tmux file to create one and attach to it.
"
  status --is-command-substitution; and return
  if test -f .tmux
     and not set -q TMUX_PROJECT
     # TODO wth is going on w/TMUX_PROJECT value getting exported to previously instantiated projects??
     set -x TMUX_PROJECT (pwd | sed 's/\/Users\/cameron\/src\///' | tr -d './-')
     tmux has-session -t $TMUX_PROJECT 2> /dev/null
     if test $status -eq 1
       ./.tmux
     end
     tmux.attach-to-project-session
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

function fish_prompt --description 'Write out the prompt'
    # Just calculate these once, to save a few cycles when displaying the prompt
    if not set -q __fish_prompt_hostname
    set -g __fish_prompt_hostname (set_color -d white)(hostname|cut -d . -f 1)(set_color normal)
    end

    if not set -q __fish_prompt_normal
    set -g __fish_prompt_normal (set_color normal)
    end

    if not set -q __git_cb
    set __git_cb " "(set_color brown)(git branch ^/dev/null | grep \* | sed 's/* //')(set_color normal)""
    end

    switch $USER

				case root

						if not set -q __fish_prompt_cwd
								if set -q fish_color_cwd_root
										set -g __fish_prompt_cwd (set_color $fish_color_cwd_root)
								else
										set -g __fish_prompt_cwd (set_color $fish_color_cwd)
								end
						end

						printf '%s@%s:%s%s%s%s# ' $USER $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

				case '*'

						if not set -q __fish_prompt_cwd
								set -g __fish_prompt_cwd (set_color $fish_color_cwd)
						end

						printf '%s@%s %s%s%s%s > ' (set_color -d white)$USER(set_color normal) $__fish_prompt_hostname "$__fish_prompt_cwd" (prompt_pwd) "$__fish_prompt_normal" $__git_cb

    end
end

# WORK STUFF (migrate to subdirectory config?)

set -x PUSHD_USER cameron



source (rbenv init -|psub)

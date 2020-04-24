set PATH "$HOME/bin" "$HOME/src/dotfiles/bin" "/usr/local/Cellar/ruby/2.6.5/bin" "$HOME/Library/Python/3.7/bin/" $PATH

set -U EDITOR emacs
set -x EDITOR emacs # git didn't pick up the -U invocation

set fish_greeting

function __create_and_or_attach_to_tmux --on-variable PWD --description "\
If the switched-to directory has a .tmux file, attempt to attach to an
exiting tmux session according to the name of the directory. If such a
session does not exist, run the .tmux file to create and attach to a
new one.
"
  status --is-command-substitution; and return
  if test -f .tmux
     and not set -q TMUX_PROJECT
     set -x sessionName (pwd | sed 's/\/Users\/cameron\/src\///' | tr -d './-')
     tmux has-session -t $sessionName
     if test $status -eq 1
       set -x TMUX_PROJECT $sessionName
       ./.tmux # TODO handle errors in this script better
     end
     tmux-attach-to-project-session $sessionName
     set -e TMUX_PROJECT
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

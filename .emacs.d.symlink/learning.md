_Keeping tabs on new keys + workflow stuff_

# Emacs
- debugger
  - c continue
  - d continue and break on next lisp function
  - b break on frame exit
  - u dont break on frame exit
  - j b + c
  - debug-on-entry is useful entering the debugger when a specific function is called
  - debug-on-error might also be useful, especially if you're writing elisp (otherwise, i tend to ignore errors unless they block my work)
  - *the docs do not do a good job of explaining how to "step over" an expression*
    - first, select the line(s) that you do not wish to step further into
    - then move the cursor to the next line in the stack (the one you do want to step further into) and press d again
  - more at https://www.gnu.org/software/emacs/manual/html_node/elisp/Debugger-Commands.html
- indent-rigidly
  - C-i (broke)
- ace-jump-word
  - M-j
- expand region
  - C-q
    - select outward from cursor
      - replace text by typing immediately
      - next?: use fast keys
- magit
  - magit-commit-create
    - write a helper to automatically state/write commit message?
- lsp works!!
  - https://github.com/emacs-lsp/lsp-ui (peek mode looks rad)
  - lsp-ui-find-workspace-symbol !!
  - on deck:
    - treemacs: https://github.com/emacs-lsp/lsp-treemacs

  - issues
    - autocomplete does not include packages
- more: https://github.com/emacs-tw/awesome-emacs

# Tmux

- iTerm2 "send hex code" makes tmux bindings amazing
  - Cmd-j/k/l for window navigation
  - pane nav?

# Fish
- opt-<arrow> cycles through recent directory history!!!

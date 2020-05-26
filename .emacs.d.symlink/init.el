;; TODO
;; look into use-package for everything

(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("melpa" . "http://stable.melpa.org/packages/")
        ))

(setq install-these-packages '(ace-jump-mode
                               auto-compile ;
                               auto-complete
                               fish-mode
                               flx-ido
                               magit
                               expand-region
                               elm-mode
                               lsp-mode
                               lsp-ui
                               company
                               go-mode
                               ag
                               doom-themes
                               use-package
                               markdown-mode
                               yasnippet
                               projectile
                               json-mode
                               yaml-mode))

(dolist (package install-these-packages)
  (unless (package-installed-p package)
    (package-install package)))


(require 'auto-compile)
(auto-compile-on-load-mode)
(auto-compile-on-save-mode)
(setq load-prefer-newer t) ; will use .el instead of .elc if newer
(package-initialize)


;;
;; global-ish settings
;;

(menu-bar-mode -1)
(desktop-save-mode 1)
(show-paren-mode)
(global-linum-mode t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'after-init-hook 'global-company-mode)
(setq column-number-mode t)
(setq vc-follow-symlinks nil) ; warn, do not prompt, about symlinks
(setq indent-tabs-mode nil)
(setq auto-save-file-name-transforms `((".*" "~/.emacs.d/autosaves" t)))

(setq lsp-ui-doc-enable nil) ; seems to break long elm files; is annoying anyway
(global-eldoc-mode -1)
(eldoc-mode -1)
(add-hook 'elm-mode-hook #'lsp)
(setq read-process-output-max (* 1024 5120)) ; for lsp performance

;; (defun my-elm ()
;;   (define-key lsp-mode-map (kbd "C-q") 'lsp-expand-selection)
;;   )
;(add-hook 'elm-mode-hook 'my-elm)
; TODO in lsp-mode, overwrite expand-selection w/lsp-extend-selection

(use-package elm-mode
	:mode "\\.elm\\'")

(use-package lsp-mode
  :mode "\\.elm\\'"
  :bind ("C-q" . lsp-extend-selection))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist '(("." . "~/.emacs.d/autosaves")))
 '(css-indent-offset 2)
 '(debug-on-error nil)
 '(desktop-path '("."))
 '(desktop-save t)
 '(electric-pair-mode t)
 '(elm-indent-after-keywords '(("of" 2) ("in" 2 0) ("{" 2) "if" "then" "else" "let"))
 '(elm-indent-offset 2)
 '(elm-tags-on-save t)
 '(fill-column 90)
 '(frame-background-mode 'dark)
 '(gc-cons-threshold 50000000)
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(js2-strict-inconsistent-return-warning nil)
 '(js2-strict-missing-semi-warning nil)
 '(js2-strict-trailing-comma-warning nil)
 '(js3-boring-indentation t)
 '(js3-consistent-level-indent-inner-bracket t)
 '(lsp-diagnostic-package :none)
 '(lsp-enable-on-type-formatting nil)
 '(lsp-enable-symbol-highlighting nil)
 '(lsp-log-io nil)
 '(package-selected-packages
	 '(lsp-mssql flycheck-elm flycheck lsp-ui company list-packages-ext lsp-mode elm-mode js2-mode yasnippet yaml-imenu use-package projectile magit json-mode ivy go-mode flx-ido fish-mode expand-region doom-themes auto-complete ag ace-jump-mode))
 '(projectile-enable-caching t)
 '(projectile-globally-ignored-directories
	 '(".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "build" "node_modules" "dist" "FB SketchKit.sketchplugin/Contents/Resources/" "FB SketchKit.sketchplugin/Contents/Sketch/SemaphoreExporter/webview/" "FB SketchKit.sketchplugin/Contents/Sketch/Data/webview/selectQuery/" "FB SketchKit.sketchplugin/Contents/Sketch/SemaphoreNative/webview/"))
 '(projectile-globally-ignored-file-suffixes '("*.min.js" ".png" ".gif" ".json"))
 '(projectile-globally-ignored-files '("*.log*" "*#*" "TAGS"))
 '(projectile-mode-line
	 '(:eval
		 (if
				 (file-remote-p default-directory)
				 " Projectile"
			 (format " Projectile[%s]"
							 (projectile-project-name)))))
 '(python-indent-offset 2)
 '(safe-local-variable-values '((flycheck-disabled-checkers emacs-lisp-checkdoc)))
 '(sh-basic-offset 2)
 '(sh-indentation 2)
 '(solarized-broken-srgb t)
 '(solarized-termcolors 256)
 '(split-height-threshold nil)
 '(split-width-threshold nil)
 '(tab-width 2)
 '(tramp-default-method "ssh")
 '(tramp-mode nil)
 '(vline-idle-time 0.04))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-ignored ((t (:inherit brightgreen))))
 '(font-lock-comment-face ((t (:foreground "color-242"))))
 '(font-lock-doc-face ((t (:inherit font-lock-comment-face :foreground "color-243"))))
 '(js2-external-variable ((t (:foreground "color-33"))))
 '(js2-function-call ((t (:inherit color-229))))
 '(js3-external-variable-face ((t (:foreground "color-51"))))
 '(js3-function-param-face ((t (:foreground "color-34"))))
 '(linum ((t (:foreground "brightgreen" :weight bold))))
 '(region ((t (:background "color-25"))))
 '(smerge-refined-added ((t (:inherit smerge-refined-change :background "color-84"))))
 '(vline ((t (:background "color-236")))))

(require 'ag)

(delete-selection-mode 1) ;; replace region with inserted text

;; auto-close () and {}
(electric-pair-mode)

;;
;; flx-ido config
;;
(ido-mode 1)
(ido-everywhere 1)
(flx-ido-mode 1)

;; disable ido faces to see flx highlights.
(setq ido-enable-flex-matching t)
(setq ido-use-faces nil)

;;
;; personal config
;;

(projectile-mode)

(defun my-mode-line ()
  (interactive)
  (setq mode-line-format
        (list
         "%l %p " ;; line number + position
         "%*%b " ;; modified? filename
         "%m"))) ;; mode

(add-hook 'after-init-hook 'my-mode-line )
(add-hook 'after-init-hook 'my-mode-line 'global-company-mode)

(defun open-current-file-in-finder ()
  (interactive)
  (shell-command "open -R ."))

;;
;; keys
;;

;; read somewhere that C-x ought to prefix general commands, and C-m major mode-specific ones

(global-unset-key (kbd "C-t"))
(global-unset-key (kbd "M-t"))
(global-set-key (kbd "C-t") 'transpose-sexps)
(global-set-key (kbd "M-t") 'transpose-chars)

(global-unset-key (kbd "C-h h"))
(global-unset-key (kbd "M-o"))
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-l") 'goto-line)
(global-set-key (kbd "M-e") 'eval-buffer)
(global-set-key (kbd "M-c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-x C-b") 'projectile-find-file)
(global-set-key (kbd "C-x g") 'projectile-grep)
(global-set-key (kbd "C-x C-x") 'pop-global-mark)

(global-unset-key (kbd "ESC <left>"))
(global-unset-key (kbd "C-x m"))
(global-set-key (kbd "C-x C-m") 'call-last-kbd-macro)

(global-unset-key (kbd "M-j"))
(global-set-key (kbd "M-j") 'ace-jump-word-mode)

(global-unset-key (kbd "M-i"))
(global-set-key (kbd "M-i") 'indent-rigidly)

(global-unset-key (kbd "C-x o"))
(global-set-key (kbd "C-x o") 'open-current-file-in-finder)

(global-unset-key (kbd "C-;"))
(global-set-key (kbd "C-;") 'ace-jump-mode)


;; unset/override some things i often fatfinger
(setq mac-command-modifier 'super)
(global-unset-key (kbd "M-}"))


;;
;; map file types to modes
;;
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.jxa$" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . gfm-mode))
(add-to-list 'auto-mode-alist '("\\.elm$" . elm-mode))






;;
;; mode settings and hooks
;;
(setq-default js-indent-level 2)

(add-hook 'sql-mode-hook (lambda () (interactive) (column-marker-1 80)))

(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))


(use-package php-mode
  :mode "\\.php\\'")


;; go
(add-hook 'go-mode-hook
          (lambda () (interactive)
            (column-marker-1 80)
            (local-set-key (kbd "C-h h") 'godoc-at-point)))


;; projectile
(add-to-list 'projectile-globally-ignored-files "*#*")
(add-to-list 'projectile-globally-ignored-files "*.log*") ;; this is a little sketch

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; yasnippet
(use-package yasnippet
  :defer f
  :init (yas-global-mode 1)
  )


;; M-x customize-face vline to change the colorp
(use-package vline
	:load-path "~/.emacs.d/thirdparty")
;(vline-mode)
;(vline-global-mode)


(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Enable custom neotree theme (all-the-icons must be installed!)
  (doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
  (doom-themes-treemacs-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

;
;; smex -- ido-like M-x replacement
;(global-set-key (kbd "M-x") 'smex)
;(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ;; vanilla M-x

(require 'expand-region)

; TODO figure out how to set this up as a backup to the lsp-mode binding above
;(global-unset-key (kbd "C-q"))
;(global-set-key (kbd "C-q") 'er/expand-region)
;(global-set-key (kbd "C-SPC") 'set-mark-command)

;; in case one wants to map one key to another...
;; (global-set-key (kbd "C-h") (kbd "<backspace>"))


(defun my-gfm-mode-hook ()
  (visual-line-mode 1)
  (auto-fill-mode)
  )
(add-hook 'gfm-mode-hook 'my-gfm-mode-hook)

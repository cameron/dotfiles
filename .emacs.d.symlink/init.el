(setq package-archives
      '(("gnu" . "http://elpa.gnu.org/packages/")
        ("marmalade" . "http://marmalade-repo.org/packages/")
        ("melpa" . "http://stable.melpa.org/packages/")))

(package-initialize)
;(package-refresh-contents)


(setq install-these-packages '(smart-tab
                               ace-jump-mode
                               rjsx-mode
                               flx-ido
                               magit
                               expand-region
                               go-mode
                               ag
                               eglot
                               yasnippet
                               projectile
                               json-mode
                               yaml-mode))



(dolist (package install-these-packages)
  (unless (package-installed-p package)
    (package-install package)))

(add-to-list 'load-path "~/.emacs.d/thirdparty/")

(require 'ag)

(setq auto-save-file-name-transforms
  `((".*" "~/.emacs.d/autosaves" t)))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(backup-directory-alist (quote (("." . "~/.emacs.d/autosaves"))))
 '(css-indent-offset 2)
 '(custom-enabled-themes (quote (solarized-dark)))
 '(custom-safe-themes
   (quote
    ("ecb9fe1d5b165a35499191a909b2b5710a52935614058b327a39bfbbb07c7dc8" "b9b1a8d2ec1d5c17700e1a09256f33c2520b26f49980ed9e217e444c381279a9" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" default)))
 '(custom-theme-directory "~/.emacs.d/themes/")
 '(eglot-put-doc-in-help-buffer (lambda (var) nil))
 '(electric-pair-mode t)
 '(elm-indent-after-keywords
   (quote
    (("of" 2)
     ("in" 2 0)
     ("{" 2)
     "if" "then" "else" "let")))
 '(elm-indent-offset 2)
 '(elm-tags-on-save t)
 '(frame-background-mode (quote dark))
 '(js-indent-level 2)
 '(js2-basic-offset 2)
 '(js2-strict-inconsistent-return-warning nil)
 '(js2-strict-missing-semi-warning nil)
 '(js2-strict-trailing-comma-warning nil)
 '(js3-boring-indentation t)
 '(js3-consistent-level-indent-inner-bracket t)
 '(package-selected-packages
   (quote
    (yasnippet tide yaml-mode suscolors-theme go-mode solarized-theme ctags expand-region column-marker json-mode ace-jump-mode ace-jump ace-jumpe company company-mode magit flx-ido projectile rjsx rjsx-mode helm smart-tab)))
 '(projectile-enable-caching t)
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".ensime_cache" ".eunit" ".git" ".hg" ".fslckout" "_FOSSIL_" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "build" "node_modules" "dist" "FB SketchKit.sketchplugin/Contents/Resources/" "FB SketchKit.sketchplugin/Contents/Sketch/SemaphoreExporter/webview/" "FB SketchKit.sketchplugin/Contents/Sketch/Data/webview/selectQuery/" "FB SketchKit.sketchplugin/Contents/Sketch/SemaphoreNative/webview/")))
 '(projectile-globally-ignored-file-suffixes (quote ("*.min.js" ".png" ".gif" ".json")))
 '(projectile-globally-ignored-files (quote ("*.log*" "*#*" "TAGS")))
 '(projectile-mode-line
   (quote
    (:eval
     (if
         (file-remote-p default-directory)
         " Projectile"
       (format " Projectile[%s]"
               (projectile-project-name))))))
 '(python-indent-offset 2)
 '(sh-indentation 2)
 '(solarized-broken-srgb t)
 '(solarized-termcolors 256)
 '(split-height-threshold nil)
 '(split-width-threshold nil)
 '(tab-width 2)
 '(tramp-default-method "ssh")
 '(tramp-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(dired-ignored ((t (:inherit brightgreen))))
 '(js2-external-variable ((t (:foreground "color-33"))))
 '(js2-function-call ((t (:inherit color-229))))
 '(js3-external-variable-face ((t (:foreground "color-51"))))
 '(js3-function-param-face ((t (:foreground "color-34"))))
 '(linum ((t (:foreground "brightgreen" :weight bold))))
 '(region ((t (:background "color-25"))))
 '(smerge-refined-added ((t (:inherit smerge-refined-change :background "color-84")))))

;(add-to-list 'grep-find-ignored-files "*#")


(load-theme 'suscolors t)

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

;; unset/override some things i often fatfinger
(setq mac-command-modifier 'super)
(global-unset-key (kbd "M-}"))


(global-unset-key (kbd "C-t"))
(global-unset-key (kbd "M-t"))
(global-set-key (kbd "C-t") 'transpose-sexps)
(global-set-key (kbd "M-t") 'transpose-chars)
(global-unset-key (kbd "C-h h"))
(global-unset-key (kbd "M-o"))
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-l") 'goto-line)
(global-set-key (kbd "M-e") 'eval-buffer)
(global-set-key (kbd "M-o") 'other-window)
(global-set-key (kbd "M-c") 'comment-or-uncomment-region)
(global-set-key (kbd "C-c m") 'compile)
(global-set-key (kbd "C-x C-b") 'projectile-find-file)
(global-set-key (kbd "C-x b") 'ido-switch-buffer)
(global-set-key (kbd "C-x g") 'projectile-grep)
(global-set-key (kbd "C-x C-x") 'pop-global-mark)
(global-unset-key (kbd "ESC <left>"))
(global-set-key (kbd "ESC <left>") 'previous-buffer)
(global-set-key (kbd "ESC <right>") 'next-buffer)
(global-unset-key (kbd "C-x m"))
(global-set-key (kbd "C-x C-m") 'call-last-kbd-macro)
(global-unset-key (kbd "M-j"))
(global-set-key (kbd "M-j") 'ace-jump-word-mode)

;; no tabs
(setq-default indent-tabs-mode nil)

;; js indentation
(setq-default js-indent-level 2)

;; follow symlinks w/warning, but w/o prompt
(setq vc-follow-symlinks nil)

;; rjsx mode for all js
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(menu-bar-mode -1)

(global-smart-tab-mode)

(show-paren-mode)

(global-linum-mode t)

(add-hook 'sql-mode-hook (lambda () (interactive) (column-marker-1 80)))

(add-hook 'python-mode-hook (lambda () (interactive) (column-marker-1 80)))
(add-hook 'python-mode-hook 'hs-minor-mode)
(global-unset-key (kbd "C-x C-h"))
(global-set-key (kbd "C-x C-h") 'hs-toggle-hiding)

(require 'expand-region)
(global-set-key (kbd "M-;") 'er/expand-region)


(defun open-current-file-in-finder ()
  (interactive)
  (shell-command "open -R ."))

(global-unset-key (kbd "C-x o"))
(global-set-key (kbd "C-x o") 'open-current-file-in-finder)

(add-to-list 'auto-mode-alist '("\\.jxa$" . js2-mode))

;; php
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

;; go
(add-hook 'go-mode-hook
          (lambda () (interactive)
            (column-marker-1 80)
            (local-set-key (kbd "C-h h") 'godoc-at-point)))

(setq column-number-mode t)

;; always
(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-to-list 'projectile-globally-ignored-files "*#*")
(add-to-list 'projectile-globally-ignored-files "*.log*") ;; this is a little sketch


(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)

(add-hook 'typescript-mode-hook #'setup-tide-mode)

(add-to-list 'load-path
              "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)

(global-unset-key (kbd "C-;"))
(global-set-key (kbd "C-;") 'ace-jump-mode)

; eglot
(add-hook 'elm-mode-hook 'eglot-ensure)
(require 'eglot)
(add-to-list 'eglot-server-programs '(elm-mode . ("elm-language-server" "--stdio")))

; disable flymake
(add-hook 'eglot--managed-mode-hook (lambda () (flymake-mode -1)))

;; my emacs init file
;;; add package sources

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

;; customize frame
;;; set up custom theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/zenburn-emacs/")
(load-theme 'zenburn t)
;;; start in fullscreen mode
(toggle-frame-fullscreen)
;;; inhibit startup screen
(setq inhibit-startup-screen t)
;;; remove menu bar
(menu-bar-mode -1)
;;; remove tool bar
(tool-bar-mode -1)
;;; remove scroll bar
(toggle-scroll-bar -1)
;;; set fringe color to same as background
(set-face-attribute 'fringe nil
		    :foreground (face-foreground 'default)
		    :background (face-background 'default))
;;; set color of vertical window divider to same as theme background
(set-face-attribute 'vertical-border nil
		    :foreground (face-background 'default))
;;; change default font size
(set-face-attribute 'default (selected-frame) :height 100)
;;; enable electric pair mode for all buffers
(electric-pair-mode)
;;; enable row highlighting
(global-hl-line-mode)

;; hooks
;;; disable auto-fill-mode in fundamental mode
(add-hook 'fundamental-mode-hook (lambda () (auto-fill-mode -1)))
;;; enable auto-revert-mode in doc-view-mode
(add-hook 'doc-view-mode-hook 'auto-revert-mode)

;; add package repository
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;;; list of packages installed
;; company
;; exec-path-from-shell
;; magit

;; custom key bindings
(global-set-key (kbd "C-x g") 'magit-status)
;;; right option as option
(setq mac-right-option-modifier 'mac-right-option)
;;; move between windows with shift and arrow keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
;;; save with C-s instead of C-x C-s
(global-set-key (kbd "C-s") 'save-buffer)

;; custom set variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (company magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; company
(add-hook 'after-init-hook 'global-company-mode)

;; set up r
;; export environment variables to avoid r resorting to C
;; LC_ALL and LANG are set in .bashrc
(load "~/.emacs.d/addins/exec-path-from-shell/exec-path-from-shell.el")
(exec-path-from-shell-copy-env "LC_ALL")
(exec-path-from-shell-copy-env "LANG")
;; stolen from http://stackoverflow.com/questions/2901198/useful-keyboard-shortcuts-and-tips-for-ess-r
;;; control and up/down arrow keys to search history with matching what you've already typed
(define-key comint-mode-map [C-up] 'comint-previous-matching-input-from-input)
(define-key comint-mode-map [C-down] 'comint-next-matching-input-from-input)
;;; comment-uncomment a selected region with C-d or C-maj-d
(defun uncomment-region (beg end)
  "Like `comment-region' invoked with a C-u prefix arg."
  (interactive "r")
  (comment-region beg end -1))
(define-key ess-mode-map (kbd "C-d") 'comment-region)
(define-key ess-mode-map (kbd "C-S-d") 'uncomment-region)
(define-key ess-mode-map "\C-l" 'ess-eval-line-and-step)
(define-key ess-mode-map "\C-p" 'ess-eval-function-or-paragraph-and-step)
(define-key ess-mode-map "\C-r" 'ess-eval-region)

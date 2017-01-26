;; my emacs init file

;; the following four sections need to go in this order
;;; 1. require package
(require 'package)
;;; 2. add melpa to package archives
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;;; 3. initialize package
(package-initialize)

;;; list of packages installed
;; company
;; company-auctex
;; company-statistics
;; exec-path-from-shell
;; magit
;; pdf-tools
;; yasnippet

;; add to load path
(add-to-list 'load-path "~/.emacs.d/addins/company-auctex/")
(add-to-list 'load-path "~/.emacs.d/addins/yasnippet")

;; auctex
;;; enable parse on load
(setq TeX-parse-self t)
;;; enable parse on save
(setq TeX-auto-save t)

;; company
(add-hook 'after-init-hook 'global-company-mode)
;;; tell company not to downcase by default
(setq company-dabbrev-downcase 0)
;;; set the timer to 0.05, to make suggestions appear faster
(setq company-idle-delay 0.05)
;;; manually complete with C-tab
(defun complete-or-indent ()
    (interactive)
    (if (company-manual-begin)
        (company-complete-common)
      (indent-according-to-mode)))
(global-set-key [C-tab] 'complete-or-indent)

;; company-auctex
(require 'company-auctex)
(company-auctex-init)

;; company-statistics
(add-hook 'after-init-hook 'company-statistics-mode)

;; exec-path-from-shell
(load "~/.emacs.d/addins/exec-path-from-shell/exec-path-from-shell.el")
(exec-path-from-shell-initialize)

;; org-mode
;;; setup files ending in “.csv” to open in org-mode
(add-to-list 'auto-mode-alist '("\\.csv\\'" . org-mode))

;; pdf-tools
;; requires the following to be put in .bashrc
;; $ export PKG_CONFIG_PATH=/usr/local/Cellar/zlib/1.2.8/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig
;;; install pdf-tools
(pdf-tools-install)
;;; make pdf files open in pdf-view-mode
(add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))

;; reftex
;;; so that reftex finds my bibtex library
(setq reftex-default-bibliography '("~/Documents/research/bibtex/library.bib"))

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
;;; and in latex-mode
(add-hook 'latex-mode-hook (lambda () (auto-fill-mode -1)))
;;; and in org-mode
(add-hook 'org-mode-hook (lambda () (auto-fill-mode -1)))
;;; enable auto-revert-mode in doc-view-mode
(add-hook 'doc-view-mode-hook 'auto-revert-mode)
;;; and in pdf-view-mode
(add-hook 'pdf-view-mode-hook 'auto-revert-mode)
;;; enable linum-mode for all new files
(add-hook 'find-file-hook (lambda () (linum-mode 1)))

;; custom key bindings
;;; C-x g to open magit status buffer
(global-set-key (kbd "C-x g") 'magit-status)
;;; right option as option
(setq mac-right-option-modifier 'mac-right-option)
;;; move between windows with shift and arrow keys
(when (fboundp 'windmove-default-keybindings)
  (windmove-default-keybindings))
;;; save with C-x s instead of C-x C-s
(global-set-key (kbd "C-x s") 'save-buffer)

;; custom set variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-table-convert-region-max-lines 9999)
 '(package-selected-packages
   (quote
    (yasnippet company-auctex company-statistics pdf-tools company magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; set up r
;; set LANG to avoid r resorting to C
(setenv "LANG" "en_US.UTF-8")
;; stolen from http://stackoverflow.com/questions/2901198/useful-keyboard-shortcuts-and-tips-for-ess-r
;;; control and up/down arrow keys to search history with matching what you've already typed
(define-key comint-mode-map [C-up] 'comint-previous-matching-input-from-input)
(define-key comint-mode-map [C-down] 'comint-next-matching-input-from-input)
;;; comment-uncomment a selected region with C-d or C-maj-d
(defun uncomment-region (beg end)
  "Like `comment-region' invoked with a C-u prefix arg."
  (interactive "r")
  (comment-region beg end -1))
(define-key ess-mode-map (kbd "C-x d") 'comment-region)
(define-key ess-mode-map (kbd "C-S-d") 'uncomment-region)
(define-key ess-mode-map "C-x l" 'ess-eval-line-and-step)
(define-key ess-mode-map "C-x p" 'ess-eval-function-or-paragraph-and-step)
(define-key ess-mode-map "C-x r" 'ess-eval-region)

;; set up tex engine
(setq-default TeX-engine 'xetex)
(setq-default TeX-PDF-mode t)

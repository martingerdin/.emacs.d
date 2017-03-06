;; my emacs init file

;; current machine
;; MacBook Pro (Retina, 15-inch, Mid 2014)
;; 2,8 GHz Intel Core i7 processor
;; 16 GB 1600 MHz DDR3 memory
;; OS X El Capitan version 10.11.4

;; current emacs version
;; GNU Emacs 25.2.1 (x86_64-apple-darwin13.4.0, Carbon Version 157 AppKit 1265.21) of 2017-02-05
;; from https://github.com/railwaycat/homebrew-emacsmacport
;; installed using brew cask to help spotlight find it

;; start with shell only
(shell)
(delete-other-windows)

;; add to load path
(add-to-list 'load-path "~/.emacs.d/addins/company-auctex/")
(add-to-list 'load-path "~/.emacs.d/addins/yasnippet")
(add-to-list 'load-path "~/.emacs.d/addins/polymode")
(add-to-list 'load-path "~/.emacs.d/addins/polymode/modes")
(add-to-list 'load-path "/usr/local/opt/emacs-mac/share/emacs/site-lisp/ess/")

;; the following four sections need to go in this order
;;; 1. require package
(require 'package)
;;; 2. add melpa to package archives
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
;;; 3. initialize package
(package-initialize)

;; custom set variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-table-convert-region-max-lines 9999)
 '(org-use-speed-commands t)
 '(package-selected-packages
   (quote
    (navi-mode font-lock-studio outshine auctex fill-column-indicator markdown-mode yasnippet company-auctex company-statistics pdf-tools company magit))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;; list of packages installed
;; company
;; company-auctex
;; company-statistics
;; ess
;; exec-path-from-shell
;; fill-column-indicator
;; magit
;; markdown-mode
;; navi-mode
;; outshine
;; pdf-tools
;; polymode
;; yasnippet

;; auctex
;;; enable parse on load
(setq TeX-parse-self t)
;;; enable parse on save
(setq TeX-auto-save t)
;;; set TeX master to nil
(setq-default TeX-master nil)

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

;; ess
(require 'ess-site)

;; exec-path-from-shell
(load "~/.emacs.d/addins/exec-path-from-shell/exec-path-from-shell.el")
(exec-path-from-shell-initialize)

;; fill-column
(setq-default fill-column 80)

;; fill-column-indicator
(require 'fill-column-indicator)
(define-globalized-minor-mode global-fci-mode fci-mode (lambda () (fci-mode 1)))
(global-fci-mode 1)

;; LaTeX-mode
(setq LaTeX-reftex-cite-format-auto-activate nil)
;;; setup files ending in ".Rtex" to open in latex-mode
(add-to-list 'auto-mode-alist '("\\.Rtex\\'" . LaTeX-mode))

;; navi-mode
(require 'navi-mode)

;; org-mode
;;; setup files ending in “.csv” to open in org-mode
(add-to-list 'auto-mode-alist '("\\.csv\\'" . org-mode))
;;; save clock history across emac sessions
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

;; outshine
;;; set outshine prefix key
(defvar outline-minor-mode-prefix "\M-#")
;;; require and add hook
(require 'outshine)
(add-hook 'outline-minor-mode-hook 'outshine-hook-function)
;;; use org-mode's speed keys
(setq outshine-use-speed-commands t)

;; pdf-tools, kept in case pdf-tools starts supporting retina displays
;; may require (pdf-tools-install to be run when started on new machine, to build server)
;; requires the following to be put in .bashrc
;; $ export PKG_CONFIG_PATH=/usr/local/Cellar/zlib/1.2.8/lib/pkgconfig:/usr/local/lib/pkgconfig:/opt/X11/lib/pkgconfig
;;; install pdf-tools
;;; (pdf-tools-install)
;;; make pdf files open in pdf-view-mode 
;;; (add-to-list 'auto-mode-alist '("\\.pdf\\'" . pdf-view-mode))

;; reftex
;;; add reftex to latex mode
(add-hook 'LaTeX-mode-hook 'reftex-mode)
;;; so that reftex finds my bibtex library
(setq reftex-default-bibliography '("~/Documents/research/temporary/bibtex/library.bib"))

;; show-paren-mode
;;; set delay to 0
(setq show-paren-delay 0)
;;; global on
(show-paren-mode 1)

;; customize frame
;;; set up custom theme
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/zenburn-emacs/")
(load-theme 'zenburn t)
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
;; change default font to courier
(set-face-font 'default "-outline-Courier New-normal-normal-normal-mono-11-*-*-*-c-*-iso8859-1")

;; hooks
;;; add outline minor mode to LaTeX-mode
(add-hook 'LaTeX-mode-hook 'outline-minor-mode)
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
;;; bind comment-or-uncomment-region to M-c
(global-set-key (kbd "M-c") 'comment-or-uncomment-region)
;;; org-mode store and insert link
(global-set-key (kbd "C-c l") 'org-store-link)
(global-set-key (kbd "C-c C-l") 'org-insert-link)
;;; C-x SPC to enable rectangle-mark-mode
(global-set-key (kbd "C-x SPC") 'rectangle-mark-mode)
;;; C-x g to open magit status buffer
(global-set-key (kbd "C-x g") 'magit-status)
;;; C-d to delete-forward-char
(global-set-key (kbd "C-d") 'delete-forward-char)
;;; right option as option
(setq mac-right-option-modifier 'mac-right-option)
;;; left option as meta
(setq mac-option-modifier 'meta)
;; change keybindings to move around windows easier
(define-prefix-command 'my-prefix-map)
(define-key global-map (kbd "C-'") 'my-prefix-map)
(define-key my-prefix-map (kbd "C-w") 'windmove-up)
(define-key my-prefix-map (kbd "C-x") 'windmove-down)
(define-key my-prefix-map (kbd "C-a") 'windmove-left)
(define-key my-prefix-map (kbd "C-d") 'windmove-right)
;;; save with C-x s instead of C-x C-s
(global-set-key (kbd "C-x s") 'save-buffer)

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

;;; start in fullscreen mode
(toggle-frame-fullscreen)
(put 'upcase-region 'disabled nil)

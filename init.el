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
;;; 2. add to package archives
(setq package-archives
      '(("melpa" . "https://melpa.org/packages/")
        ("gnu" . "https://elpa.gnu.org/packages/")
        ("org" . "http://orgmode.org/elpa/")))
;;; 3. initialize package
(package-initialize)

;; custom set variables
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(delete-selection-mode t)
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
;; elpy
;; ess
;; exec-path-from-shell
;; fill-column-indicator
;; magit
;; markdown-mode
;; navi-mode
;; org-ref
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
;;; begin commands
(setq company-begin-commands '(self-insert-command org-self-insert-command c-electric-lt-gt c-electric-colon))
;;; capf
(defun my-org-mode-hook ()
  (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))
(add-hook 'org-mode-hook #'my-org-mode-hook)

;; company-auctex
(require 'company-auctex)
(company-auctex-init)

;; company-statistics
(add-hook 'after-init-hook 'company-statistics-mode)

;; doc-view
(setq doc-view-resolution 300)

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
;;; make window shifting work also in org mode
(add-hook 'org-mode-hook 
	  (lambda ()
	    (define-prefix-command 'my-prefix-map)
	    (define-key org-mode-map (kbd "C-'") 'my-prefix-map)
	    (define-key my-prefix-map (kbd "C-w") 'windmove-up)
	    (define-key my-prefix-map (kbd "C-x") 'windmove-down)
	    (define-key my-prefix-map (kbd "C-a") 'windmove-left)
	    (define-key my-prefix-map (kbd "C-d") 'windmove-right)))
;;; set up org mode agenda
(setq org-agenda-files (list "~/Documents/agenda/research-agenda.org"))
;;; enable babel languages
(org-babel-do-load-languages
   'org-babel-load-languages
   '((R . t)
     (latex . t)
     (emacs-lisp . t)))
;;; change compiler from latex to latexmk
(setq org-latex-pdf-process (list "latexmk -f -pdf %f"))
;;; add custom easy templates
(add-to-list 'org-structure-template-alist
             '("RR" "#+TITLE:README\n#+OPTIONS: author:nil date:nil toc:nil num:nil \n#+TODO: TODO MEETING Me Someoneelse | DONE \n* Short summary \n* Aim and research questions \n** Aim \n** Research questions \n* Ethics \n* Tasks")
	     '("bib" ":PROPERTIES: \n :BTYPE: article|book \n :AUTHOR: Firstname Surname and Firstname Surname and ... \n:JOURNAL: \n:VOLUME: \n:NUMBER: 3 \n:YEAR: \n:MONTH: January \n:CUSTOM_ID: \n  :END:"))

;; org-ref
;;; set default bibliography
(setq reftex-default-bibliography '("~/Documents/research/temporary/bibtex/library.bib"))
;;; see org-ref for use of these variables
(setq org-ref-bibliography-notes ""
      org-ref-default-bibliography '("~/Documents/research/temporary/bibtex/library.bib")
      org-ref-pdf-directory "")

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

;; stata
(setq inferior-STA-program-name
      "/Applications/Stata/StataMP.app/Contents/MacOS/stata-mp")

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
;;; and to r-mode
(add-hook 'ess-mode-hook 'outline-minor-mode)
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
; (add-hook 'find-file-hook (lambda () (linum-mode 1)))

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
;;; ispell
(global-set-key (kbd "M-*") 'ispell-word)
(global-set-key (kbd "M-^") 'flyspell-region)

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

;; set up spell check
;;; stolen from http://blog.binchen.org/posts/what-s-the-best-spell-check-set-up-in-emacs.html
;; find aspell and hunspell automatically
(cond
 ;; try hunspell at first
  ;; if hunspell does NOT exist, use aspell
 ((executable-find "hunspell")
  (setq ispell-program-name "hunspell")
  (setq ispell-local-dictionary "en_GB-large")
  (setq ispell-local-dictionary-alist
        ;; Please note the list `("-d" "en_US")` contains ACTUAL parameters passed to hunspell
        ;; You could use `("-d" "en_US,en_US-med")` to check with multiple dictionaries
        '(("en_US" "[[:alpha:]]" "[^[:alpha:]]" "[']" nil ("-d" "en_GB-large") nil utf-8)
          )))

 ((executable-find "aspell")
  (setq ispell-program-name "aspell")
  ;; Please note ispell-extra-args contains ACTUAL parameters passed to aspell
  (setq ispell-extra-args '("--sug-mode=ultra" "--lang=en_US"))))
;;; ignore specific regions
(add-to-list 'ispell-skip-region-alist '("^#+BEGIN_SRC" . "^#+END_SRC"))

;; set up tex engine
(setq-default TeX-engine 'xetex)
(setq-default TeX-PDF-mode t)

;;; start in fullscreen mode
(toggle-frame-fullscreen)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)

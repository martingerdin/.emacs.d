;; my emacs init file
;;; add package sources
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))

;;; list of packages installed
;; magit


;; custom key bindings
(global-set-key (kbd "C-x g") 'magit-status)
(setq mac-right-option-modifier 'mac-right-option) ; right option as option

;;init-program

;; customize
;; (custom-set-variables
;;  '(helm-gtags-path-style 'relative)
;;  '(helm-gtags-ignore-case t)
;;  '(helm-gtags-auto-update key))


(add-to-list 'load-path (expand-file-name "~/.emacs.d/local/mobdebug-mode/mobdebug-mode"))
(eval-after-load "lua-mode"
  '(progn
     (require 'mobdebug-mode nil t)
     ;; if you prefer evil mode
     ;;(setq mobdebug-use-evil-binding t)

     ))


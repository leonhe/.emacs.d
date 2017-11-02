;;; lua-mode -- Summary
;;; Commentary:
;;; Code:
(autoload 'lua-mode "lua-mode" "Lua editiing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
  
(add-hook 'lua-mode-hook (lambda ()
			   (hs-minor-mode t)
			   ;;(helm-gtags-mode t)
			   ))

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

(use-package company-lua
  :ensure t
  )

(provide 'init-lua)
;;; init-lua.el ends here

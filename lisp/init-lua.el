;;; lua-mode -- Summary
;;; Commentary:
;;; Code:

;; Enter key executes newline-and-indent
(defun set-newline-and-indent ()
  "Map the return key with `newline-and-indent'"
  (local-set-key (kbd "RET") 'newline-and-indent))
(add-hook 'lua-mode-hook 'set-newline-and-indent)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/local/mobdebug-mode"))


(use-package lua-mode
  :ensure t
  :init
  (add-hook 'lua-mode-hook (lambda ()
			   (hs-minor-mode t)
			   ;;(helm-gtags-mode t)
			   (semantic-mode t)
			   ))
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
  (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
  (autoload 'lua-mode "lua-mode" "Lua editiing mode." t)
  (require 'mobdebug-mode nil t)
  (setq mobdebug-use-evil-binding t)
  :bind(:map lua-mode-map
	     ("C-c C-k" . lua-kill-proces)
	     ))
(defun my-lua-mode-company-init ()
(setq-local company-backends '((company-lua
                                  company-etags
                                  company-dabbrev-code
                                  company-yasnippet)))
)
(use-package company-lua
  :ensure t
  :init
  (add-hook 'lua-mode-hook #'my-lua-mode-company-init)

  )

(provide 'init-lua)
;;; init-lua.el ends here

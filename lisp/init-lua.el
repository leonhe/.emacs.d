;;; lua-mode -- Summary
;;; Commentary:
;;; Code:

(use-package lua-mode
  :ensure t
  :init
  (add-hook 'lua-mode-hook (lambda ()
			   (hs-minor-mode t)
			   ;;(helm-gtags-mode t)
			   ))
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
  (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
  (autoload 'lua-mode "lua-mode" "Lua editiing mode." t)
  :bind(:map lua-mode-map
	     ("C-c C-k" . lua-kill-proces)
	     ))
(use-package company-lua
  :ensure t
  )

(provide 'init-lua)
;;; init-lua.el ends here

(use-package lua-mode
  :ensure t)
(use-package flymake-lua
  :ensure t
  :hook
  (lua-mode . flymake-lua-load))

(use-package company-lua
  :ensure t
  :init
  (defun my-lua-mode-company-init ()
    (setq-local company-backends '((company-lua
				    company-etags
				    company-dabbrev-code
				    company-yasnippet))))
  (add-hook 'lua-mode-hook #'my-lua-mode-company-init)
  )
(provide 'init-lua)

;;lua-mode
(autoload 'lua-mode "lua-mode" "Lua editiing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(add-hook 'lua-mode-hook (lambda ()
			   (hs-minor-mode t)
			   (helm-gtags-mode t)
			   ))
(provide 'init-lua)

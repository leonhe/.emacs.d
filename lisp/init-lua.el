;;lua-mode
(require-package 'lua-mode)
(require-package 'flymake-lua)
(require-package 'company-lua)
(autoload 'lua-mode "lua-mode" "Lua editiing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))


(provide 'init-lua)

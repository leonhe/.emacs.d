;;lua-mode
(add-to-list 'load-path "~/.emacs.d/mode/lua-mode/")
(autoload 'lua-mode "lua-mode" "Lua editiing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))


(provide 'init-lua)

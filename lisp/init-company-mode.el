;;intilze company-mode
(add-to-list 'load-path "~/.emacs.d/mode/company-mode/")
(autoload 'company-mode "company" nil t)
(company-mode 1)
;;(global-key-binding (kbd "M-/") 'company--auto-completion)
(add-hook 'after-init-hook 'global-company-mode)
(provide 'init-company-mode)

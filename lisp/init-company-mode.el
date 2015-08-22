;;intilze company-mode

(add-to-list 'load-path "~/.emacs.d/mode/company-mode/")
(autoload 'company-mode "company" nil t)

(add-hook 'after-init-hook 'company-mode)

(provide 'init-company-mode)

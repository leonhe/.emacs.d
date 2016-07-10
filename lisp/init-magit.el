;;git-emacs
(require-package 'magit)
(global-magit-file-mode 1)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(provide 'init-magit)

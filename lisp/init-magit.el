;;git-emacs
(global-magit-file-mode 1)
(global-git-commit-mode)
(smerge-mode t)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
;;(global-set-key (kbd "C-x  ") 'magit-checkout)
(global-set-key (kbd "C-x M-s") 'magit-checkout-stage)
;;出现冲突解决热键
(global-set-key (kbd "C-c ^ m") 'smerge-keep-mine)
(global-set-key (kbd "C-c ^ a") 'smerge-keep-all)
(global-set-key (kbd "C-c ^ o") 'smerge-keep-other)
(global-set-key (kbd "C-c ^ c") 'smerge-keep-current)
(global-set-key (kbd "C-c ^ b") 'smerge-keep-base)

;;stash
(global-set-key (kbd "C-c g s ") 'magit-stash)
(global-set-key (kbd "C-c g a") 'magit-stash-apply)
;;(require 'magit-gitflow)
;;(add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
(provide 'init-magit)

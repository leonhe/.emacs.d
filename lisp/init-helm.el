;;intilze helm-mode
(setq tramp-mode nil)
(setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
(require-package 'helm)
(require-package 'helm-gtags)
(require-package 'helm-mt)
(require 'helm-config)
(helm-mode 1)
;;keyboard bind
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-h x") 'helm-apropos)
(global-set-key (kbd "C-x p i") 'helm-imenu)
(global-set-key (kbd "C-c C-g f") 'helm-gtags-find-files)
;;bookmark
(global-set-key (kbd "C-x r l") 'helm-bookmarks)
(global-set-key (kbd "C-x r s") 'bookmark-set)
(global-set-key (kbd "C-x r d") 'bookmark-delete)


(provide 'init-helm)

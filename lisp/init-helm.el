;;intilze helm-mode
(setq tramp-mode nil)
(setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
(require-package 'helm)
(require-package 'helm-gtags)

(require 'helm-config)
(helm-mode 1)
;;keyboard bind
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-h x") 'helm-apropos)
(provide 'init-helm)

;;intilze helm-mode
(setq tramp-mode nil)
(setq tramp-ssh-controlmaster-options "-o ControlMaster=auto -o ControlPath='tramp.%%C' -o ControlPersist=no")
(add-to-list 'load-path "~/.emacs.d/mode/emacs-async/")
(add-to-list 'load-path "~/.emacs.d/mode/helm/")
(require 'helm-config)
(helm-mode 1)
;;keyboard bind
;;(global-set-key (kbd "M-x" 'helm-M-x)
(provide 'init-helm)

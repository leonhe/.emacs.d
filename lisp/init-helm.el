;;intilze helm-mode
(require 'helm-config)
(helm-mode 1)
(helm-gtags-mode 1)
(helm-projectile-on)
(setq projectile-indexing-method 'alien)
(setq projectile-enable-caching t)

;;keyboard bind
(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-h x") 'helm-apropos)
(global-set-key (kbd "C-c C-g f") 'helm-gtags-find-files)
(global-set-key (kbd "C-c C-g g") 'helm-gtags-create-tags)
(global-set-key (kbd "C-c C-g s") 'helm-gtags-find-symbol)
(global-set-key (kbd "C-c C-g d") 'helm-gtags-show-stack)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
;;bookmark
(global-set-key (kbd "C-x r l") 'helm-bookmarks)
(global-set-key (kbd "C-x r s") 'bookmark-set)
(global-set-key (kbd "C-x r d") 'bookmark-delete)


(provide 'init-helm)

;;intilze helm-mode
(require 'helm-config)
(setq projectile-indexing-method 'alien)
(setq projectile-enable-caching t)
(setq projectile-tags-command "ctags-exuberant -Re -f \"%s\" %s")
(use-package helm
  :ensure t
  :init
  (helm-mode 1)
  ;;(helm-gtags-mode 1)
  (helm-projectile-on)
  (helm-autoresize-mode 1)
  :bind(
	  ("C-x c h" . helm-register)
	  ("C-x c g d" . helm-do-grep-ag)
	  ("C-x c g p" . helm-do-ag-project-root)
	  ("C-x c g f" . helm-do-ag-this-file)
	  ("C-x c g b" . helm-do-ag-buffers)
	  ("C-x c g g" . helm-do-ag)
	  ("M-." . helm-source-etags-select)
  ))


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

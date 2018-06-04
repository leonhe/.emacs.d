;;git-emacs
(global-magit-file-mode 1)
(require 'magit-mode)
(use-package magit-svn
  :ensure t
  )
(add-hook 'magit-mode-hook 'magit-svn-mode)
(global-git-commit-mode)
(smerge-mode t)
(global-set-key (kbd "C-c g s") 'magit-status)
(global-set-key (kbd "C-c g f") 'magit-stage-file)
(global-set-key (kbd "C-c g p") 'magit-dispatch-popup)
(global-set-key (kbd "C-c g r") 'magit-checkout-stage)
(global-set-key (kbd "C-c g c") 'magit-commit)
(global-set-key (kbd "C-c g c") 'magit-commit)
(global-set-key (kbd "C-c g b") 'magit-checkout)
(global-set-key (kbd "C-c g P") 'magit-push-current)
;;出现冲突解决热键
(global-set-key (kbd "C-c ^ m") 'smerge-keep-mine)
(global-set-key (kbd "C-c ^ a") 'smerge-keep-all)
(global-set-key (kbd "C-c ^ o") 'smerge-keep-other)
(global-set-key (kbd "C-c ^ c") 'smerge-keep-current)
(global-set-key (kbd "C-c ^ b") 'smerge-keep-base)

;;stash
(global-set-key (kbd "C-c g h") 'magit-stash)
(global-set-key (kbd "C-c g a") 'magit-stash-apply)
(require-package 'magit-svn);
(add-hook 'magit-mode-hook 'magit-svn-mode)
;; (use-package magit-gitflow
;;   :ensure t
;;   :config
;;   (add-hook 'magit-mode-hook 'turn-on-magit-gitflow)
;;   )
;; (setq magit-refresh-status-buffer nil)
;; (setq auto-revert-buffer-list-filter
;;       'magit-auto-revert-repository-buffers-p)
(provide 'init-magit)

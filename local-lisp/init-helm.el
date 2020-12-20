(use-package helm
  :ensure t
  :diminish helm-mode
  :init
  (progn
    (require 'helm-config)
    (setq helm-candidate-number-limit 100)
    ;; From https://gist.github.com/antifuchs/9238468
    (setq helm-idle-delay 0.0 ; update fast sources immediately (doesn't).
          helm-input-idle-delay 0.01  ; this actually updates things
                                        ; reeeelatively quickly.
          helm-yas-display-key-on-candidate t
          helm-quick-update t
          helm-M-x-requires-pattern nil
          helm-ff-skip-boring-files t)
    (helm-mode))
  ;; (helm-autoresize-mode 1)
  :bind(
	("M-x" . helm-M-x)
	("C-x C-f" . helm-find-files)
	("C-x b" . helm-buffers-list)
	))
;; (use-package helm-map
;;   :ensure t)
(use-package helm-swoop
  :bind
  (("C-S-s" . helm-swoop)
   ("M-i" . helm-swoop)
   ("M-s s" . helm-swoop)
   ("M-s M-s" . helm-swoop)
   ("M-I" . helm-swoop-back-to-last-point)
   ("C-c M-i" . helm-multi-swoop)
   ("C-x M-i" . helm-multi-swoop-all)
   )
  :config
  (progn
    (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
    (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop))
  )

(use-package helm-projectile
  :ensure t
  :after (helm)
  :config
  (helm-projectile-on)
  )
(use-package helm-ag
  :ensure t
  :after helm)

(use-package ace-jump-helm-line
  :ensure t
  :after helm
  :init
  (setq ace-jump-helm-line-keys (number-sequence ?a ?z))
  (setq ace-jump-helm-line-style 'at)
  (setq ace-jump-helm-line-default-action 'select)
  (setq ace-jump-helm-line-background t)
  (setq ace-jump-helm-line-autoshow-use-linum t)
  )

(provide 'init-helm)

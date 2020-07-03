;;; init-ivy.el ---  ivy-mode setting
(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :ensure t
  :init (ivy-rich-mode 1))

(use-package ivy-avy
  :ensure t
  )
(use-package ivy-emoji
  :ensure t
  )
(use-package ivy-explorer
  :ensure t
  :init (ivy-explorer-mode 1))
(use-package neotree
  :ensure t
  :bind(
	("C-c h" . neotree-toggle)
	)
  )
(use-package counsel-projectile
  :ensure t
  :after (ivy)
  :init
  (counsel-projectile-mode)
  )
(use-package ivy
  :ensure t
  :config 
  (ivy-mode 1)
  :init
  (setq ivy-use-virtual-buffers t)
  (setq enable-recursive-minibuffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq ivy-fixed-height-minibuffer t)
  ;; (setq ivy-posframe-hide-minibuffer nil)
  (global-set-key (kbd "C-s") 'swiper-isearch)
  (global-set-key (kbd "M-x") 'counsel-M-x)
  (global-set-key (kbd "C-x C-f") 'counsel-find-file)
  (global-set-key (kbd "M-y") 'counsel-yank-pop)
  (global-set-key (kbd "<f1> l") 'counsel-find-library)
  (global-set-key (kbd "C-x b") 'ivy-switch-buffer)
  (global-set-key (kbd "C-c v") 'ivy-push-view)
  (global-set-key (kbd "C-c V") 'ivy-pop-view)
  )

(use-package counsel
  :ensure t
  )
(use-package ivy-posframe
  :ensure t
  :after counsel
  :init
  (setq ivy-posframe-parameters
	'((left-fringe . 10)
	  (right-fringe . 10))) 
  (setq ivy-posframe-display-functions-alist '(
					       (complete-symbol . ivy-posframe-display-at-point)
					       (t . ivy-posframe-display-at-frame-top-center)))
  
  :config
  ;; (setq ivy-posframe-display-functions-alist
  ;; 	'((swiper          . ivy-posframe-display-at-point)
  ;; 	  (complete-symbol . ivy-posframe-display-at-point)
  ;; 	  (counsel-M-x     . ivy-posframe-display-at-window-bottom-left)
  ;; 	  (t               . ivy-posframe-display)))
  (ivy-posframe-mode t)
  )
;; (global-set-key (kbd "SPC") 'hydra-vi/body)
(provide 'init-ivy)
;;; init-ivy.el ends here

;;; init-ivy.el ---  ivy-mode setting

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
  :after (ivy)
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

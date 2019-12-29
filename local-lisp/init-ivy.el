;; (use-package hydra-ivy
;;   :ensure t
;;   )
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
(  
setq ivy-use-virtual-buffers t)
(setq enable-recursive-minibuffers t)
(setq ivy-count-format "(%d/%d) ")
(global-set-key (kbd "C-s") 'swiper-isearch)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "M-y") 'counsel-yank-pop)
(global-set-key (kbd "<f1> l") 'counsel-find-library)
;; (global-set-key (kbd "<f2> i") 'counsel-info-lookup-symbol)
;; (global-set-key (kbd "<f2> u") 'counsel-unicode-char)
;; (global-set-key (kbd "<f2> j") 'counsel-set-variable)
(global-set-key (kbd "C-x b") 'ivy-switch-buffer)
(global-set-key (kbd "C-c v") 'ivy-push-view)
(global-set-key (kbd "C-c V") 'ivy-pop-view)
  )

(use-package counsel
  :ensure t
  )


(use-package swiper-helm
  :ensure t)
(defhydra hydra-vi (:pre (set-cursor-color "#40e0d0")
                    :post (progn
                            (set-cursor-color "#ffffff")
                            (message
                             "Thank you, come again.")))
  "vi"
  ("l" forward-char)
  ("h" backward-char)
  ("j" next-line)
  ("k" previous-line)
  ("q" nil "quit")
  ("/" swiper)
  )
;; (global-set-key (kbd "SPC") 'hydra-vi/body)
(provide 'init-ivy)
;;; init-ivy.el ends here

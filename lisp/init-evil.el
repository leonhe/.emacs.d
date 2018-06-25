;;; init-evil.el --- initilze evil-mode
;;; Commentary:
;;; Code:
 (defvar my-leader-map (make-sparse-keymap)
  "Keymap for \"leader key\" shortcuts.")
     
(use-package evil
  :ensure t
:config
 (progn
  (evil-mode 1)

  (setq evil-auto-indent t)
   (define-key evil-normal-state-map (kbd "SPC") my-leader-map)
   (add-hook 'easy-hugo-mode-hook 'turn-off-evil-mode) ;;close eays-hugo-mode evil
   )
:bind (:map my-leader-map 
      ("g" . magit-status)
      ("b" . helm-buffers-list)
      ("f" . helm-find-files)
      ("p" . projectile-command-maps)
      ("a" . org-agenda)
      ("c" . org-capture)
	))
 (use-package evil-collection
   :after evil
   :ensure t
   :init
   (setq evil-want-integration nil)
   :config
   (evil-collection-init))
(use-package evil-magit
  :after evil
  :ensure t
  :config
  (evil-magit-init)
)
(provide 'init-evil)
;;; init-evil.el ends here

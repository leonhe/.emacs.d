;;; init-evil.el --- initilze evil-mode
;;; Commentary:
;;; Code:
 (defun my-leader-map (make-sparse-keymap)
  "Keymap for \"leader key\" shortcuts.")
     
(use-package evil
  :ensure t
  :init
  (evil-mode 1)
 :config
   (setq evil-auto-indent t)
   (define-key evil-normal-state-map (kbd "SPC") 'my-leader-map)
  (add-hook 'easy-hugo-mode-hook 'turn-off-evil-mode) ;;close eays-hugo-mode evil
  ;; :bind(:map
  ;; 	     ("b" . helm-buffers-list)
  ;; 	     ("g" . magit-status)
  ;; 	)
  )
(provide 'init-evil)
;;; init-evil.el ends here

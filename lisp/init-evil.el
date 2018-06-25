;;; init-evil.el --- initilze evil-mode
;;; Commentary:
;;; Code:
 (defvar my-leader-map (make-sparse-keymap)
   "Keymap for \"leader key\" shortcuts.")
(defun evil-toggle-input-method ()
  "when toggle on input method, switch to evil-insert-state if possible.
    when toggle off input method, switch to evil-normal-state if current state is evil-insert-state"
  (interactive)
  (if (not current-input-method)
      (if (not (string= evil-state "insert"))
	  (evil-insert-state))
    (if (string= evil-state "insert")
	(evil-normal-state)
      ))
  (toggle-input-method))


(use-package evil
  :ensure t
  :config
  (progn
    (evil-mode 1)
    (setq evil-auto-indent t)
    (define-key evil-normal-state-map (kbd "SPC") my-leader-map)
;;    (global-set-key (kbd "C-\\") 'evil-toggle-input-method)
    (add-hook 'easy-hugo-mode-hook 'turn-off-evil-mode) ;;close eays-hugo-mode evil
   )
  :bind (
	 ("M-\\" . 'evil-toggle-input-method)
	 :map my-leader-map 
	     ("g" . magit-status)
	     ("b" . helm-buffers-list)
	     ("f" . helm-find-files)
	     ("p" . projectile-command-maps)
	     ("a" . org-agenda)
	     ("c" . org-capture)
	     ("l" . helm-imenu)))
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

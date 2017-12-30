;;; lua-mode -- Summary
;;; Commentary:
;;; Code:

;; Enter key executes newline-and-indent
(defun my-lua-mode-company-init ()
  (setq-local company-backends '((company-lua
                                  company-etags
				  company-gtags
                                  company-dabbrev-code
                                  company-yasnippet)))
)

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config (setq dumb-jump-selector 'ivy) ;; (setq dumb-jump-selector 'helm)
  :ensure t)

 (use-package company-lua
   :ensure t
   )

(use-package lua-mode
  :ensure t
  :config
  (progn
    (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
    (add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
    (add-to-list 'load-path (expand-file-name "~/.emacs.d/local/mobdebug-mode"))
    (autoload 'lua-mode "lua-mode" "Lua editiing mode." t)
    (add-hook 'lua-mode-hook (lambda ()
			       (hs-minor-mode t)
			       (helm-gtags-mode t)
			       (semantic-mode t)
			       (my-lua-mode-company-init)			       ))
    (require 'mobdebug-mode nil t)
  )
  :bind(:map lua-mode-map
	     ("C-c C-k" . lua-kill-proces)
	     ))

(provide 'init-lua)
;;; init-lua.el ends here

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
  :ensure t
  
  :config
  (progn 
    (dumb-jump-mode)
    (setq dumb-jump-selector 'ivy)    
    )
  :bind(
	("C-M-j" . dumb-jump-go)
   )
  )
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

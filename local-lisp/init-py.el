(use-package pyenv-mode
  :ensure t
  :config
  (pyenv-mode t)
(defun projectile-pyenv-mode-set ()
  "Set pyenv version matching project name."
  (let ((project (projectile-project-name)))
    (if (member project (pyenv-mode-versions))
        (pyenv-mode-set project)
      (pyenv-mode-unset))))

(add-hook 'projectile-after-switch-project-hook 'projectile-pyenv-mode-set)
  )
(use-package elpy
  :ensure t
  :hook ((elpy-mode . flycheck-mode)
	 ;; (pyenv-mode . elpy-rpc-restart)
	 )
  :init
  (elpy-enable)
  :config
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules)))
(provide 'init-py)

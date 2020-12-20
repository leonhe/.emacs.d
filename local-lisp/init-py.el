;;python development env
;; (use-package pyenv-mode
;;   :after (elpy projectile)
;;   :ensure t
;;   :config
;;   (pyenv-mode t)
;;   (defun projectile-pyenv-mode-set ()
;;   "Set pyenv version matching project name."
;;   (let ((project (projectile-project-name)))
;;     (if (member project (pyenv-mode-versions))
;;         (pyenv-mode-set project)
;;       (pyenv-mode-unset))))
;;   (add-hook 'projectile-after-switch-project-hook 'projectile-pyenv-mode-set)
;;   )a

(use-package company-jedi
  :ensure t
  :after (company)
  :defer t
  :config
  (add-to-list 'company-backends #'company-jedi)
  )
(use-package realgud
  :ensure t

  )
(use-package py-autopep8
  :ensure t
  )
;; (use-package flycheck-pyflakes
;;   :ensure t)
(use-package elpy
  :ensure t
  :defer t
  :hook ((elpy-mode . flycheck-mode)
	 (elpy-mode . py-autopep8-enable-on-save)
	 (elpy-mode . company-jedi)
	 )
  :init
  (advice-add 'python-mode :before 'elpy-enable)
  (setq company-frontends
 	'(company-tng-frontend
	  company-pseudo-tooltip-frontend
	  company-echo-metadata-frontend))
  (add-hook 'company-mode-hook
	  (lambda ()
            (substitute-key-definition
             'company-complete-common
             'company-yasnippet-or-completion
             company-active-map)))
  :config
  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
  ;; (setq elpy-rpc-pythonpath nil
  ;; 	python-shell-interpreter "~/.pyenv/shims/python"
  ;; 	python-shell-interpreter-args "-i"
  ;; 	elpy-rpc-python-command "~/.pyenv/shims/python"
  ;; 	elpy-rpc-virtualenv-path "current"
  ;; 	)
   )

(provide 'init-py)

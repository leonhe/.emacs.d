;;; init-cocos.el --- cocos2d-x c++ develop configurations
;;; Commentary:
;;; Code:
;;(global-ede-mode t)
(add-hook 'after-init-hook 'global-company-mode)
(add-hook 'c++-mode-hook (lambda()
			   (semantic-mode t)
			   (setq flycheck-clang-language-standard "c++11" )
			   (ivy-mode t)
			   (function-args-mode t)
			   ))
;; yasnippet
(use-package yasnippet
	     :ensure t
	     :init
	     (yas-global-mode 1)
	     (yas-reload-all)
	     :config
	     (add-to-list 'yas-snippet-dirs (locate-user-emacs-file "snippets")))
(add-hook 'c++-mode 'semantic)

(use-package semantic
  :ensure t
  :config
  (global-semanticdb-minor-mode t)
  (global-semantic-idle-completions-mode t)
  (global-semantic-idle-scheduler-mode t)
  
  :bind (("C-c , f" . semantic-ia-fast-jump)
	 )
  )

(use-package irony
  :ensure t
  :init
  (add-hook 'c++-mode-hook 'irony-mode)
  (add-hook 'c-mode-hook 'irony-mode)
  (add-hook 'objc-mode-hook 'irony-mode)
  (add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)
  )

(use-package function-args
  :ensure t
  :init
  :config
  (set-default 'semantic-case-fold t)
  )
(provide 'init-cocos)
;;; init-cocos.el ends here

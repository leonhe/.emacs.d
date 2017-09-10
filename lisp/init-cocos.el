;;; init-cocos.el --- cocos2d-x c++ develop configurations
;;; Commentary:
;;; Code:
(global-ede-mode t)
(add-hook 'after-init-hook 'global-company-mode)
(use-package semantic
  :ensure t
  :config
  (global-semanticdb-minor-mode t)
  (global-semantic-idle-completions-mode t)
  (global-semantic-idle-scheduler-mode t)
  (semantic-add-system-include "~/Works/HaoyunOs/cocos2d")
  :bind (("C-c , f" . semantic-ia-fast-jump)
	 )
  )

(use-package irony
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

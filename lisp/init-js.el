;;; init-js.el ---                                -*- lexical-binding: t; -*-
;; Copyright (C) 2017  Yuanfei He
;; Author: Yuanfei He;;; init-js.el --- base file <hi@leonhe.me>
;; Keywords: 
;;; Commentary:
;; Javascript 
;;; Code:

(require 'web-mode)
(require 'js2-mode)
(require 'ac-js2)
(require 'indium)
(require 'js2-refactor)

;; Mac系统中需要用 exec-path-from-shell-initialize 加载环境变量, 否则找不到 indium server
;; (when (featurep 'cocoa)
;;   ;; Initialize environment from user's shell to make eshell know every PATH by other shell.
;;   (require 'exec-path-from-shell)
;;   (exec-path-from-shell-initialize))

(add-hook 'js2-mode-hook #'js2-refactor-mode)
(add-hook 'js-mode-hook #'indium-interaction-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)
;;(add-hook 'typescript-mode-hook 'prettier-js-mode)

(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              )))
;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

(add-hook 'js2-mode-hook (lambda()
			   ;;(setq indium-debugger-mode 1)
			   ;;(setq indium-nodejs-inspect-brk t)
			   ;;(setq indium-script-enable-sourcemaps t)
			   ;;(setup-tide-mode t)
			   (tern-mode)
			   (hs-minor-mode t)
			   (company-mode)
			   (set (make-local-variable 'company-backends) '((company-tern company-etags company-dabbrev-code) company-dabbrev))
			   ))


(setq hippie-expand-try-function-list '(try-expand-debbrev
					try-expand-debbrev-all-buffers
					try-expand-debbrev-from-kill
					try-complete-file-name-partially
					try-complete-file-name
					try-expand-all-abbrevs
					try-expand-list
					try-expand-line
					try-complete-lisp-symbol-partially
					try-complete-lisp-symbol))
(global-set-key (kbd "M-/") 'hippie-expand)


(setq company-tooltip-align-annotations t)

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :init
  ;;setting get tsserver maximum allowed response
  (setq tide-server-max-response-length 10240000) 
  (setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /tmp/tss.log"))
  (setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))
  (setq tide-always-show-documentation t)
  :hook (
	 (typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))
(add-hook 'typescript-mode 'tide-mode)
;; (use-package lsp-mode
;;   :commands lsp
;;   :ensure t
;;   :init
;;   (lsp)
;;   (setq lsp-auto-guess-root t)
;;   (setq lsp-response-timeout 20)
;;   (setq lsp-enable-completion-at-point nil)
;;   ;;  (setq imenu-create-index-function lsp-mode)
;;   :bind (
;; 	 ("C-c d" . lsp-find-definition)
;; 	 )
;;   :hook(
;; 	(typescript-mode . lsp)
;; 	)
;;   )

;; (use-package dap-mode
;;   :ensure t
;;   :after lsp-mode
;;   :config
;;   (dap-mode 1)
;;   (dap-ui-mode 1)
;;   (require 'dap-chrome)
;;   (dap-register-debug-template "Chrome::Run"
;;   (list :type "chrome"
;;         :cwd nil
;;         :request "launch"
;;         :file "index.html"
;;         :reAttach t
;;         :program nil
;;         :name "Chrome::Run"))
;;   )
;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode
;;   :init
;;   (setq lsp-ui-doc-enable nil
;;       lsp-ui-peek-enable nil
;;       lsp-ui-sideline-enable nil
;;       lsp-ui-imenu-enable nil
;;       lsp-ui-flycheck-enable t
;;       )
;;   :bind (
;; 	 ;;"C-c l" . lsp-ui-imenu)
;; 	 ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
;; 	 ([remap xref-find-references] . lsp-ui-peek-find-references)
;; 	 )
;;   )

;; (use-package company-lsp
;;   :ensure t
;;   :commands company-lsp)

;; (use-package helm-lsp
;;   :ensure t
;;   :commands helm-lsp
;;   )
;; (add-hook 'js2-mode 'lsp)


(provide 'init-js)
;;; init-js.el ends here



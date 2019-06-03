;;; init-js.el ---                                -*- lexical-binding: t; -*-
;; Copyright (C) 2017  Yuanfei He
;; Author: Yuanfei He;;; init-js.el --- base file <hi@leonhe.me>
;; Keywords: 
;;; Commentary:
;; Javascript 
;;; Code:

(use-package typescript-mode
  :ensure t
  ;; :init
  ;; (hs-minor-mode)
  :hook
  (typescript-mode . hs-minor-mode)
  )
(add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))

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


;; (use-package lsp-mode
;;   :commands lsp
;;   :ensure t
;;   :config
;;   (lsp-register-client
;;  (make-lsp-client :new-connection (lsp-stdio-connection "typescript-language-server --stdio")
;;                   :major-modes '(typescript-mode)
;;                   :server-id 'typescript-language-server))
;;   :init
;;   (setq lsp-auto-guess-root t lsp-prefer-flymake nil)
;;   (setq lsp-response-timeout 20)
;;   (setq lsp-enable-completion-at-point t)
;;   (setq lsp-print-io t)
;;   ;;  (setq imenu-create-index-function lsp-mode)
;;   :bind
;;   ("M-." . lsp-find-implementation)
;;   :hook(
;;   	(typescript-mode . lsp)
;;   	)
;;   )

;; (use-package dap-mode
;;   :ensure t
;;   :after lsp-mode
;;   :config
;;   (dap-mode 1)
;;   (dap-ui-mode 1)
;;   (dap-register-debug-provider
;;  "programming-language-name"
;;  (lambda (conf)
;;    (plist-put conf :debugPort 5256)
;;    (plist-put conf :host "localhost")
;;    conf))
;;   (require 'dap-chrome)
;;   (dap-register-debug-template "Chrome::Run"
;;   (list :type "chrome"
;;         :cwd nil
;;         :request "launch"
;;         :file "index.html"
;;         :reAttach t
;; 	:url "http://127.0.0.1:5256/index.html"
;;         :program nil
;; 	:
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
;;(add-hook 'js2-mode 'lsp)


(provide 'init-js)
;;; init-js.el ends here



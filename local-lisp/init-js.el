;;; init - js.el-- - -* - lexical - binding: t; -* -
;; Copyright(C) 2017  Yuanfei He
;; Author: Yuanfei He;;; init - js.el-- - base file < hi@leonhe.me>
;; Keywords:
;;; Commentary:
;; Javascript
;;; Code:
;; debug mode
;; (use - package eglot
;;   : ensure t
;;   : config
    ;;;; (add - to - list 'eglot-server-programs
    ;;;; `(python-mode . ("pyls" "-v" "--tcp" "--host"
;;   ;;                             "localhost" "--port" :autoport)))
;;   (add-to-list 'eglot-server-programs '(typescript-mode . ("typescript-language-server" "--stdio")))
;;   (global-key-binding (kbd "M-\.") 'xref-find-definitions)
;;   :hook
;;   (typescript-mode . eglot-ensure)
;;   ;; :bind
;;   ;; (
;;   ;;  :map eglot-mode-map
;;   ;;  ("M-." . xref-find-definitions)
;;   ;;  )
;;   )
;; (use-package dap-mode
;;   :ensure t
;;   :after (:any lsp)
;;   :init 
;;   (require 'dap-chrome)
;;   (require 'dap-node)
;;   (dap-mode 1)
;;   (dap-ui-mode 1)
;;   :config
;; (dap-register-debug-template "Node Run Configuration"
;;                              (list :type "node"
;;                                    :cwd nil
;;                                    :request "launch"
;;                                    :program "${workspaceFolder}/src/server.ts" 
;;                                    :name "Node::Run"))
;;  ;; (dap-register-debug-template "Node Project"
;;  ;;  (list :type "node"
;;  ;; 	:request "launch"
;;  ;;        :cwd nil 
;;  ;;        :request "launch"
;;  ;; 	:preLaunchTask "tsc: build - tsconfig.json"
;;  ;; 	:outFiles "build/**/*.js"
;;  ;; 	:programs "src/server.ts"
;;  ;;        :name "Launch Program"))

;;  ;; ;; (dap-register-debug-template "Chrome Browse URL"
;;  ;;  (list :type "chrome"
;;  ;;        :cwd nil
;;  ;;        :mode "url"
;;  ;;        :request "launch"
;;  ;;        :webRoot nil
;;  ;;        :url "http://192.168.191.51:3000/index.html" 
;;  ;;        :name "Egret Browse URL"))

;;   :bind  (:map dap-mode-map
;;    	       ("C-c r s" . dap-debug)
;; 	       ("C-c r b" . dap-breakpoint-toggle)
;; 	       ("C-c r l" . dap-ui-locals)
;; 	       ("C-c r v" . dap-ui-sessions)
;; 	       ("C-c r c" . dap-continue)
;; 	       ("C-c r n" . dap-next)
;;  	       ))
(use-package js-comint
  :ensure t
  :config
  (setq inferior-js-program-command "node --interactive")
  )
(use-package typescript-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
  :init
  (add-hook 'typescript-mode-hook 'hs-minor-mode-hook)
  (add-hook 'typescript-mode-hook 'evil-vimish-fold-mode-hook)
  )

;; (use-package tss
;;   :ensure t
;;   :config
;;   ;; Key binding
;;   (setq tss-popup-help-key "C-:")
;;   (setq tss-jump-to-definition-key "C->")
;;   (setq tss-implement-definition-key "C-c i")
;;   (tss-config-default)
;;   )



(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              )))

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
  :after(evil-collection typescript-mode company flycheck)
  :init
  ;;setting get tsserver maximum allowed response
  (setq tide-hl-identifier-idle-time 0.5)
  (setq tide-jump-to-definition-reuse-window t)
  (setq tide-completion-enable-autoimport-suggestions t)
  (setq tide-server-max-response-length 10240000)
  (setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /tmp/tss.log"))
  (setq tide-format-options '(:insertSpaceAfterFunctionKeywordForAnonymousFunctions t :placeOpenBraceOnNewLineForFunctions nil))
  (setq tide-always-show-documentation t)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (setq tide-tsserver-executable "/usr/local/bin/tsserver")
  ;;(flycheck-add-next-checker 'typescript-tide '(warning . typescript-tslint) 'append)
  ;; (add-hook 'write-file-hooks 'tide-restart-server)
  (add-hook 'before-save-hook 'tide-format-before-save)
  :hook (
	 (typescript-mode . tide-setup)
         ;; (typescript-mode . tide-hl-identifier-mode)
	 ))
(use-package vue-mode
  :ensure t
  :mode ("\\.vue'" . vue-mode)
  )
(use-package indium
  :ensure t
  :after (js-mode)
  )
(use-package json
  :ensure t
  :mode ("\\.json'" . json-mode))

;; (use-package lsp-mode
;;   :commands lsp
;;   :ensure t
;;   ;; :config				;
;;   ;; (lsp-register-client
;;   ;;  (make-lsp-client :new-connection (lsp-stdio-connection "typescript-language-server --stdio")
;;   ;;                 :major-modes '(typescript-mode)
;;   ;;                 :server-id 'typescript-language-server))
;;    :init
;;   (setq lsp-message-project-root-warning t)
;;   (setq create-lockfiles nil)
;;   (setq lsp-enable-eldoc t)
;;   (setq lsp-auto-guess-root t lsp-prefer-flymake nil)
;;   (setq lsp-response-timeout 20)
;;   (setq lsp-enable-completion-at-point t)
;;   (setq lsp-print-io t)
;;   (setq lsp-keymap-prefix "s-l")
;;   :bind(
;;    ("C-c j" . lsp-find-implementation)
;;    ("C-c r" . lsp-find-references)
;;    )
;;   :hook(
;;   	(typescript-mode . lsp)
;;   	)
;;   )

;; (use-package lsp-treemacs
;;   :commands lsp-treemacs-errors-list
;;   :ensure t
;;   )
;; ;; (use-package lsp-ui
;; ;;    :ensure t
;; ;;    :commands lsp-ui-mode
;; ;;    :init
;; ;;    (setq lsp-ui-doc-enable nil
;; ;;        lsp-ui-peek-enable nil
;; ;;        lsp-ui-sideline-enable nil
;; ;;        lsp-ui-imenu-enable nil
;; ;;        lsp-ui-flycheck-enable t
;; ;;        )
;; ;;    :bind (
;; ;;  	 ;;"C-c l" . lsp-ui-imenu)
;; ;;  	 ([remap xref-find-definitions] . lsp-ui-peek-find-definitions)
;; ;;  	 ([remap xref-find-references] . lsp-ui-peek-find-references)
;; ;;  	 )
;; ;;    )

;; (use-package company-lsp
;;   :ensure t
;;   :commands company-lsp
;;   :config
;;   ;; Enable LSP backend.
;;   (push 'company-lsp company-backends)
;;   )
(use-package company-glsl
  :ensure t)
(use-package glsl-mode
  :ensure t
  :mode (
	 ("\\.frag'" . glsl-mode)
	 ("\\.vert'" . glsl-mode)
	 ))
(use-package js2-mode
  :ensure t
  :mode (
	 ("\\.js'" . js2-mode)
	 )
  :hook(
	(js-mode . js2-minor-mode)
	)
  :init
  (add-to-list 'auto-mode-alist '("\\.jsx?\\'" . js2-jsx-mode))
  (add-to-list 'interpreter-mode-alist '("node" . js2-jsx-mode))
  )
(provide 'init-js)
;;; init-js.el ends here













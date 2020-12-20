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
(use-package dap-mode
  :ensure t
  :after (:any lsp)
  :init 
  (require 'dap-chrome)
  (require 'dap-node)
  (require 'dap-python)
  (dap-mode 1)
  (dap-ui-mode 1)
  :config
(dap-register-debug-template "Node Run Configuration"
                             (list :type "node"
                                   :cwd nil
                                   :request "launch"
                                   :program "${workspaceFolder}/src/server.ts" 
                                   :name "Node::Run"))
 ;; (dap-register-debug-template "Node Project"
 ;;  (list :type "node"
 ;; 	:request "launch"
 ;;        :cwd nil 
 ;;        :request "launch"
 ;; 	:preLaunchTask "tsc: build - tsconfig.json"
 ;; 	:outFiles "build/**/*.js"
 ;; 	:programs "src/server.ts"
 ;;        :name "Launch Program"))

 ;; ;; (dap-register-debug-template "Chrome Browse URL"
 ;;  (list :type "chrome"
 ;;        :cwd nil
 ;;        :mode "url"
 ;;        :request "launch"
 ;;        :webRoot nil
 ;;        :url "http://192.168.191.51:3000/index.html" 
 ;;        :name "Egret Browse URL"))

  :bind  (:map dap-mode-map
   	       ("C-c r s" . dap-debug)
	       ("C-c r b" . dap-breakpoint-toggle)
	       ("C-c r l" . dap-ui-locals)
	       ("C-c r v" . dap-ui-sessions)
	       ("C-c r c" . dap-continue)
	       ("C-c r n" . dap-next)
 	       ))
;; (use-package js-comint
;;   :ensure t
;;   :config
;;   (setq inferior-js-program-command "node --interactive")
;;   )
;; (use-package typescript-mode
;;   :ensure t
;;   :config
;;   (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
;;   :init
;;   (add-hook 'typescript-mode-hook 'hs-minor-mode-hook)
;;   (add-hook 'typescript-mode-hook 'evil-vimish-fold-mode-hook)
;;   )


;; ;; (use-package tss
;; ;;   :ensure t
;; ;;   :config
;; ;;   ;; Key binding
;; ;;   (setq tss-popup-help-key "C-:")
;; ;;   (setq tss-jump-to-definition-key "C->")
;; ;;   (setq tss-implement-definition-key "C-c i")
;; ;;   (tss-config-default)
;; ;;   )



;; (add-hook 'web-mode-hook
;;           (lambda ()
;;             (when (string-equal "tsx" (file-name-extension buffer-file-name))
;;               )))

;; (setq hippie-expand-try-function-list '(try-expand-debbrev
;; 					try-expand-debbrev-all-buffers
;; 					try-expand-debbrev-from-kill
;; 					try-complete-file-name-partially
;; 					try-complete-file-name
;; 					try-expand-all-abbrevs
;; 					try-expand-list
;; 					try-expand-line
;; 					try-complete-lisp-symbol-partially
;; 					try-complete-lisp-symbol))
;; (global-set-key (kbd "M-/") 'hippie-expand)


(use-package tide
  :ensure t
  :after(js2-mode evil-collection typescript-mode company flycheck)
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
(flycheck-add-next-checker 'javascript-eslint 'javascript-tide 'append)
  (add-hook 'before-save-hook 'tide-format-before-save)
  :hook (
	 (typescript-mode . tide-setup)
	 (js2-mode . tide-setup)
	 ))
(use-package vue-mode
  :ensure t
  :mode ("\\.vue'" . vue-mode)
  )
(use-package indium
  :ensure t
  :after (js-mode)
  )
(use-package add-node-modules-path
  :ensure t
  :config
  (add-hook 'js-mode-hook #'add-node-modules-path))

(use-package json
  :ensure t
  :mode ("\\.json'" . json-mode))

(setq-default js-indent-level 2)

(use-package js2-mode
  :mode "\\.js\\'"
  :config
  (setq-default js2-ignored-warnings '("msg.extra.trailing.comma")
	))

(use-package js2-refactor
  :config
  (js2r-add-keybindings-with-prefix "C-c C-m")
  (add-hook 'js2-mode-hook 'js2-refactor-mode))
(use-package rjsx-mode)
(use-package prettier-js
  :config
  (setq prettier-js-args '(
                           "--trailing-comma" "es5"
                           "--single-quote" "true"
                           "--print-width" "100"
                           ))
  (add-hook 'js2-mode-hook 'prettier-js-mode)
  (add-hook 'rjsx-mode-hook 'prettier-js-mode))



(use-package company-glsl
  :ensure t)
(use-package glsl-mode
  :ensure t
  :mode (
	 ("\\.frag'" . glsl-mode)
	 ("\\.vert'" . glsl-mode)
	 ))

(provide 'init-js)
;;; init-js.el ends here













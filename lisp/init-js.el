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

(defun setup-tide-mode()
  "Typescript develop configure."
  (interactive)
  (setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /tmp/tss.log"))
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (hs-minor-mode t)
  (tide-hl-identifier-mode +1)
  (setq tide-always-show-documentation t)
;;  (setq tide-imenu-flatten nil)
  (company-mode +1)
  )
(setq company-tooltip-align-annotations t)
;;
(defun save-format-file()
  "Use shell command format code."
  (interactive)
  (tide-format-before-save)
  ;; (shell-command (concat "prettier --write " (buffer-file-name)))
  ;; (auto-revert-buffers)
  ;; (do-auto-save)

  )



;;formats the buffer before saving
(add-hook 'before-save-hook 'save-format-file)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; (use-package lsp-mode
;;   :commands lsp
;;   :ensure t
;;   :init
;;   (lsp)
;;   (setq lsp-auto-guess-root t)
;;   (setq lsp-response-timeout 20)
;;   (setq lsp-enable-completion-at-point nil)
;;   :bind (
;; 	 ("M-." . lsp-goto-implementation)
;; 	 )
;;   )

;; (use-package lsp-ui
;;   :ensure t
;;   :commands lsp-ui-mode
;;   :bind (
;; 	 ("C-c l" . lsp-ui-imenu)
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
;; (add-hook 'typescript-mode-hook #'lsp)
 (add-hook 'typescript-mode-hook 'flycheck-mode)

(provide 'init-js)
;;; init-js.el ends here



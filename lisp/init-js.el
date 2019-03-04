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
(require 'tide)

;; Mac系统中需要用 exec-path-from-shell-initialize 加载环境变量, 否则找不到 indium server
;; (when (featurep 'cocoa)
;;   ;; Initialize environment from user's shell to make eshell know every PATH by other shell.
;;   (require 'exec-path-from-shell)
;;   (exec-path-from-shell-initialize))

(add-hook 'js2-mode-hook #'js2-refactor-mode)
(add-hook 'js-mode-hook #'indium-interaction-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))

(add-hook 'js2-mode-hook 'prettier-js-mode)
(add-hook 'web-mode-hook 'prettier-js-mode)

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
(setq tide-tsserver-process-environment '("TSS_LOG=-level verbose -file /tmp/tss.log"))

(defun setup-tide-mode ()
  "Typescript develop configure."
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (add-hook 'before-save-hook 'save-format-file)
  (eldoc-mode +1)
  (hs-minor-mode t)
  (tide-hl-identifier-mode +1)
  (global-set-key (kbd "C-c .") 'tide-references)
  (company-mode +1))
;;
(defun save-format-file()
  "Use shell command format code."
  (interactive)
  (tide-format-before-save)
  ;; (shell-command (concat "prettier --write " (buffer-file-name)))
  ;; (auto-revert-buffers)
  ;; (do-auto-save)

  )

;; formats the buffer before saving
(add-hook 'typescript-mode-hook #'setup-tide-mode)

(provide 'init-js)
;;; init-js.el ends here



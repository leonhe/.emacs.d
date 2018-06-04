;;; init-js.el --- s                               -*- lexical-binding: t; -*-
;; Copyright (C) 2017  Yuanfei He
;; Author: Yuanfei He;;; init-js.el --- base file <hi@leonhe.me>
;; Keywords: 
;;; Commentary:
;; Javascript 
;;; Code:
(use-package js2-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.js" . js2-mode))
  :bind-keymap
  ("C-c j" . js2-mode-map)
  )
(use-package indium
  :ensure t
  :init
  :config
  (setq indium-debugger-mode 1)
  (setq indium-nodejs-inspect-brk t)
  (setq indium-script-enable-sourcemaps t)
  )

(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

;; (defun setup-tide-mode ()
;;   (interactive)
;;   (tide-setup)
;;   (flycheck-mode +1)
;;   (setq flycheck-check-syntax-automatically '(save mode-enabled))
;;   (eldoc-mode +1)
;;   (tide-hl-identifier-mode +1)
;;   ;; company is an optional dependency. You have to
;;   ;; install it separately via package-install
;;   ;; `M-x package-install [ret] company`
;;   (company-mode +1))

;; ;; aligns annotation to the right hand side
;; (setq company-tooltip-align-annotations t)

;; ;; formats the buffer before saving
;; (add-hook 'before-save-hook 'tide-format-before-save)

;; (add-hook 'typescript-mode-hook #'setup-tide-mode)
(provide 'init-js)
;;; init-js.el ends here



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
(add-hook 'js2-mode-hook #'js2-refactor-mode)

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))


(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              )))
;; enable typescript-tslint checker
;;(flycheck-add-mode 'typescript-tslint 'web-mode)



(add-hook 'js2-mode-hook (lambda()
			   ;;(setq indium-debugger-mode 1)
			   ;;(setq indium-nodejs-inspect-brk t)
			   ;;(setq indium-script-enable-sourcemaps t)
			   ;;(setup-tide-mode t)
			   (tern-mode)
			   (company-mode)
			   (set (make-local-variable 'company-backends) '((company-tern company-etags company-dabbrev-code) company-dabbrev))
			   ))
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))

(provide 'init-js)
;;; init-js.el ends here



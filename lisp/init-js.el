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

(provide 'init-js)
;;; init-js.el ends here



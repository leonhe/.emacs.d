;;; init-flycheck.el -- flycheck mode configure
;;; Commentary:
;; This is flycheck mode conf file
;;; Code:
(require-package 'flycheck)
(require-package 'flycheck-tip)
(global-flycheck-mode)
(require-package 'flycheck-color-mode-line)
(require 'flycheck-color-mode-line)
(eval-after-load "flycheck"
  '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
(setq flycheck-highlighting-mode 'sexps)
(setq flycheck-warning nil)
(setq flycheck-error t)
(setq flycheck-info t)
(provide 'init-flycheck)
;;; init-flycheck ends here

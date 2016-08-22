(require-package 'flycheck)
(require-package 'flycheck-tip)
(global-flycheck-mode)
(require-package 'flycheck-color-mode-line)
(setq flycheck-highlighting-mode 'sexps)

(require 'flycheck-color-mode-line)

(eval-after-load "flycheck"
    '(add-hook 'flycheck-mode-hook 'flycheck-color-mode-line-mode))
(add-hook 'lua-mode-hook 'flymake-lua-load)
(setq flycheck-warning nil)
(setq flycheck-error t)
(setq flycheck-info t)
(provide 'init-flycheck)

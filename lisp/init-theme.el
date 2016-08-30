(require-package 'powerline)
(require 'powerline)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/ample-zen")
(add-hook 'after-init-hook '(lambda ()
			      (load-theme 'ample-zen t)
			      ))

(powerline-default-theme)
(show-paren-mode t)
(setq show-paren-style 'expression)
(load-theme 'ample-zen t)
(set-default-font "Source Code Pro Medium-14")

(provide 'init-theme)

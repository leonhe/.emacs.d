;;; init-theme.el --- theme manager
;;; Commentary:
;;; Code:

(require 'powerline)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/ample-zen")
(add-hook 'after-init-hook '(lambda ()
			      (load-theme 'ample-zen t)
			      ))

(powerline-default-theme)
(show-paren-mode t)
(defvar show-paren-style 'expression)
(load-theme 'ample-zen t)
(set-frame-font "Source Code Pro Medium-18")

(provide 'init-theme)
;;; init-theme.el ends here

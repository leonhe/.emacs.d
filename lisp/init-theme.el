;;; init-theme.el --- theme manager
;;; Commentary:
;;; Code:
(require 'powerline)
(add-hook 'after-init-hook '(lambda ()
			      (load-theme 'monokai t)
			      ))
(powerline-default-theme)
(show-paren-mode t)
(defvar show-paren-style 'expression)
(set-frame-font "Source Code Pro Medium-18")


(setq
 monokai-foreground "#0000FF"
 monokai-background "#000000"
 )

(provide 'init-theme)
;;; init-theme.el ends here

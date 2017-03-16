;;; init-theme.el --- theme manager
;;; Commentary:
;;; Code:
(require 'powerline)
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-banners-directory "~/.emacs.d/assets/")
(setq dashboard-banner-logo-title "~~Happy Codeing,Happy Life~~")
(setq dashboard-startup-banner "~/.emacs.d/assets/logo.png")
(setq dashboard-items '((recents  . 5)
                        (bookmarks . 5)))

(add-hook 'after-init-hook '(lambda ()
			      ;;(load-theme 'monokai t)
			      (load-theme 'ample-zen t)
			      ))
(powerline-default-theme)
(show-paren-mode t)
(defvar show-paren-style 'expression)
(set-frame-font "Source Code Pro Medium-18")


(setq
 ;; monokai-foreground "#0000FF"
 ;; monokai-background "#000000"
 ;; monokai-blue ""
 )

(provide 'init-theme)
;;; init-theme.el ends here

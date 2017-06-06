;;; init-theme.el --- theme manager
;;; Commentary:
;;; Code:
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/ample-zen")
(require 'powerline)
(require 'dashboard)
(dashboard-setup-startup-hook)
(setq dashboard-banners-directory "~/.emacs.d/assets/")
(setq dashboard-banner-logo-title "~~Happy Codeing,Happy Life~~")
(setq dashboard-startup-banner "~/.emacs.d/assets/logo.png")
(setq dashboard-items '((projects . 5)
			(recents  . 5)
                        (bookmarks . 5)
			))

(add-hook 'after-init-hook '(lambda ()
			      ;;(load-theme 'monokai t)
			      (load-theme 'ample-zen t)
			      ))
(powerline-default-theme)

(show-paren-mode t)
(defvar show-paren-style 'expression)
(set-frame-font "Source Code Pro Medium-18")

;;which key
(require 'which-key)
(which-key-mode)
(setq which-key-popup-type 'minibuffer)
(setq which-key-side-window-location 'bottom)
(setq which-key-sort-order 'which-key-key-order)

(provide 'init-theme)
;;; init-theme.el ends here

;;; init-theme.el --- theme manager
;;; Commentary:
;;; Code:
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(require-package 'dracula-theme)

(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (add-to-list 'dashboard-items '(agenda) t)
  (setq dashboard-banners-directory "~/.emacs.d/assets/")
  (setq dashboard-banner-logo-title "~~Happy Codeing,Happy Life~~")
  (setq dashboard-startup-banner "~/.emacs.d/assets/logo.png")
  (setq dashboard-items '((agenda . 5)
			  (projects . 5)
			  (recents  . 5)
			  ))
  )


(require 'powerline)

(use-package all-the-icons
  :ensure t
  )

(powerline-center-theme)

(add-hook 'after-init-hook '(lambda ()
			      ;;(load-theme 'eiio-theme t)
			      ;;(load-theme 'ample-zen t)
			      (load-theme 'dracula t)
			      ))

(show-paren-mode t)
(defvar show-paren-style 'expression)
(set-frame-font "Source Code Pro Medium-14")

;;which key
(require 'which-key)
(ace-window-display-mode t)
(which-key-mode)
(setq which-key-popup-type 'minibuffer)
(setq which-key-side-window-location 'bottom)
(setq which-key-idle-delay 0.5)
(which-key-add-key-based-replacements
  "C-c ^" "smerge")
(which-key-add-key-based-replacements
  "C-c w" "windows")
(which-key-add-key-based-replacements
  "C-c !" "flycheck")
(which-key-add-key-based-replacements
  "C-c e" "emms")
(which-key-add-key-based-replacements
    "C-c C-g" "grep & find")
(all-the-icons-octicon "file-binary")  ;; GitHub Octicon for Binary File
(all-the-icons-faicon  "cogs")         ;; FontAwesome icon for cogs
(all-the-icons-wicon   "tornado")      ;; Weather Icon for tornado

(setq inhibit-compacting-font-caches t)

(provide 'init-theme)
;;; init-theme.el ends here

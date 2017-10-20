;;; init-theme.el --- theme manager
;;; Commentary:
;;; Code:
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

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
;;(require 'dashboard)
(use-package all-the-icons
  :ensure t
  )
(powerline-default-theme)
;; (defun custom-modeline-modified
;;   ((let* ((config-alist
;; 	   '(("*" all-the-icons-faicon-family all-the-icons-(format "message" format-args)aicon "chain-broken" :height 1.2 :v-adjust -0.0)
;; 	     ("-" all-the-icons-faicon-family all-the-icons-faicon "link" :height 1.2 :v-adjust -0.0)
;; 	     ("%" all-the-icons-octicon-family all-the-icons-octicon "lock" :height 1.2 :v-adjust 0.1)))
;; 	  (result (cdr (assoc (format-mode-line "%*") config-alist))))
;;      (propertize (apply (cadr result) (cddr result))
;; 		 'face `(:family ,(funcall (car result)))))))
  
;; (defun custom-modeline-window-number ()
;;   (propertize (format " %c" (+ 9311 (window-numbering-get-number)))
;;               'face `(:height ,(/ (* 0.90 powerline/default-height) 100.0))
;;               'display '(raise 0.0)))
;;   (setq mode-line-format '("%e" (:eval 
;;   (concat
;;    ;;(custom-modeline-modified)
;;    (custom-modeline-window-number)
;;     ;;(custom-modeline-mode-icon)
;;     ;;(custom-modeline-icon-vc)
;;     ;; (custom-modeline-region-info)
;;     ;; (custom-modeline-flycheck-status)
;;     ;; (custom-modeline-suntime)
;;     ;; (custom-modeline-weather)
;;     ;;(custom-modeline-time)
;;     ))))


(add-hook 'after-init-hook '(lambda ()
			      ;;(load-theme 'eiio-theme t)
			      (load-theme 'ample-zen t)

			      ))

(show-paren-mode t)
(defvar show-paren-style 'expression)
(set-frame-font "Source Code Pro Medium-18")

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
;;avy-mode
(avy-setup-default)
(all-the-icons-octicon "file-binary")  ;; GitHub Octicon for Binary File
(all-the-icons-faicon  "cogs")         ;; FontAwesome icon for cogs
(all-the-icons-wicon   "tornado")      ;; Weather Icon for tornado

(setq inhibit-compacting-font-caches t)

(provide 'init-theme)
;;; init-theme.el ends here

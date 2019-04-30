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
  :init
  (setq inhibit-compacting-font-caches t)
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

;;(set-frame-font "Monaco-14")
;;(set-frame-font "Yuanti SC-14")
(set-fontset-font t 'han (font-spec :family "PingFang SC" :size 12))
(setq face-font-rescale-alist '(("PingFang SC" . 1.0) ("Yuanti SC" . 1.2) ("Monaco" . 1.4)))

(defun custom-modeline-mode-icon()
  (format " %s"
    (propertize icon
                'help-echo (format "Major-mode: `%s`" major-mode)
                'face `(:height 0.5 :family ,(all-the-icons-icon-family-for-buffer)))))

;; (defun custom-modeline-modified
;;   ((let* ((config-alist
;;             '(("*" all-the-icons-faicon-family all-the-icons-faicon "chain-broken" :height 1.2 :v-adjust -0.0)
;;               ("-" all-the-icons-faicon-family all-the-icons-faicon "link" :height 1.2 :v-adjust -0.0)
;;               ("%" all-the-icons-octicon-family all-the-icons-octicon "lock" :height 1.2 :v-adjust 0.1)))
;;            (result (cdr (assoc (format-mode-line "%*") config-alist))))
;;       (propertize (apply (cadr result) (cddr result))
;;                   'face `(:family ,(funcall (car result))))))


;; (defun -custom-modeline-github-vc ()
;;   (let ((branch (mapconcat 'concat (cdr (split-string vc-mode "[:-]")) "-")))
;;     (concat
;;      (propertize (format " %s" (all-the-icons-alltheicon "git")) 'face `(:height 1.2) 'display '(raise -0.1))
;;      " · "
;;      (propertize (format "%s" (all-the-icons-octicon "git-branch"))
;;                  'face `(:height 1.3 :family ,(all-the-icons-octicon-family))
;;                  'display '(raise -0.1))
;;      (propertize (format " %s" branch) 'face `(:height 0.9)))))

;; (defun -custom-modeline-svn-vc ()
;;   (let ((revision (cadr (split-string vc-mode "-"))))
;;     (concat
;;      (propertize (format " %s" (all-the-icons-faicon "cloud")) 'face `(:height 1.2) 'display '(raise -0.1))
;;      (propertize (format " · %s" revision) 'face `(:height 0.9)))))

;; (defun custom-modeline-icon-vc ()
;;   (when vc-mode
;;     (cond
;;       ((string-match "Git[:-]" vc-mode) (-custom-modeline-github-vc))
;;       ((string-match "SVN-" vc-mode) (-custom-modeline-svn-vc))
;;       (t (format "%s" vc-mode)))))

;; (setq mode-line-format '("%e" (:eval 
;;   (concat
;;    ;; (custom-modeline-modified)
;;     ;; (custom-modeline-window-number)
;;    (custom-modeline-mode-icon)
;;    ;; (custom-modeline-icon-vc)	  
;;     ;; (custom-modeline-region-info)
;;     ;; (custom-modeline-flycheck-status)
;;     ;; (custom-modeline-suntime)
;;     ;; (custom-modeline-weather)
;;     ;; (custom-modeline-time)
;;     ))))
;; (setq mode-line-format
;;           (list
;;            ;; value of `mode-name'
;;            "%m: "
;;            ;; value of current buffer name
;;            ":buffer %b, "
;;            ;; value of current line number
;;            "line %l "
;;            "-- user: "
;;            ;; value of user
;;            (getenv "USER")))

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

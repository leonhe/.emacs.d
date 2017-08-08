;;; init-org-mode.el --- org mode configure
;;; Commentary:
;;; Code:
;;(add-to-list 'org-modules 'org-mac-iCal)
(add-to-list 'auto-mode-alist '("\\.org\\'". org-mode))
(add-to-list 'auto-mode-alist '("\\.og\\'" . org-mode))
(setq org-directory "~/Note/")
(require 'org-bullets)
(require 'pomidor)
(require 'org-pomodoro)
(require 'ox-md)
(require 'ox-publish)
(require 'org-mime)

;;setting org directory
(global-set-key "\C-col" 'org-store-link)
(global-set-key "\C-coc" 'org-capture)
(global-set-key "\C-coa" 'org-agenda)
(global-set-key "\C-cob" 'org-iswitchb)

(setq org-priority-faces '((?A . (:foreground "red" :weight 'bold))
			   (?B . (:foreground "yellow"))
			   (?C . (:foreground "green"))))
(defun eiio-init-orgmode()
  "initilze org-mode"
  ;;(message "init org-mode")
  (setq truncate-lines nil);;org 支持自动换行
  (org-bullets-mode 1)
  (org-indent-mode t)
  (setq org-log-done 'time)   ;;显示任务完成时间
  (setq org-refile-use-outline-path t)
  ;;ical
  (setq org-agenda-include-diary t)
  )
 ;;setting workflow state
  (setq org-todo-keywords
           '((sequence "TODO(t)" "|" "NEXT(n)" "|"  "DONE(d)")
             (sequence "HOLD(h)" "|" "WAITING(w)" "|" "CANCELED(c)")
            ))

;;设置关键字颜色
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("NEXT" :foreground "blue" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("WAITING" :foreground "orange" :weight bold)
	      ("HOLD" :foreground "magenta" :weight bold)
	      ("CANCELLED" :foreground "#F0F0F0" :weight bold)
	      )))

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))


(add-hook 'org-mode-hook 'eiio-init-orgmode)

(setq org-agenda-exporter-settings
      '(
	(ps-number-of-columns 2)
	(ps-landscape-mode t)
	(org-agenda-add-entry-text-maxlines 5)
	(org-clock-out-remove-zero-time-clocks t)
	(org-agenda-repeating-timestamp-show-all t)
	))

(defun my-after-load-org()
  (setq org-clock-out-remove-zero-time-clocks t)
  (setq org-agenda-include-diary t)
  (setq org-agenda-compact-blocks t)
  (setq org-clock-persist 'history)
  (org-clock-persistence-insinuate)

  (setq org-refile-targets (quote (("inbox.org" :maxlevel . 1)
				 ("somemaybe.org" :maxlevel . 2)
				 ("task.org" :maxlevel . 2)
				 ("project.org" :maxlevel . 2))))

  ;;capture
(setq org-capture-templates
      '(("t" "TODO" entry (file+headline "todo/inbox.org" "Inbox")
	 "* TODO %?\n  %i\n")
	("n" "Day Note" entry (file+datetree "note/day.org")
	 "* %?\n Entered on %U\n  %i\n")
	("b" "Inbox Note" entry (file+datetree "note/inbox.org")
	 "* %?\n Entered on %U\n  %i\n")
	))
(define-key global-map "\C-coc" 'org-capture)
(setq org-html-doctype "xhtml5")

  )
(eval-after-load "org" '(my-after-load-org))


(setq org-directory "~/Note/")
(setq org-publish-project-alist
           '(("res"
               :base-directory  "~/Note/wiki/assets"
               :base-extension "jpg\\|gif\\|png\\|js\\|css\\|svg\\|ttf\\|woff"
	       :recursive t
	       :publishing-directory "/ssh:git@wiki.local#1383:/var/www/html/images/"
               :publishing-function org-publish-attachment)
	     ("public"
               :base-directory  "~/Note/wiki/"
               :base-extension "org"
	       :recursive t
	       :publishing-directory "/ssh:git@wiki.local#1383:/var/www/html/"
               :publishing-function org-html-publish-to-html
	       :sitemap-filename "index.html"
	       :auto-sitemap t
	       :sitemap-title "Wiki"
	       )
	     
	     ("wiki" :components ("res" "public"))
	     ))

(add-to-list 'org-modules 'org-timer)
(setq org-timer-default-timer 25)
(add-hook 'org-clock-in-hook (lambda ()
			       (if (not org-timer-current-timer) 
				   (org-timer-set-timer '(16)))))

;; (add-hook 'org-pomodoro (lambda ()
;; 			  (org-pomodoro-start)
;; 			  ))
(add-hook 'org-pomodoro-started-hook (lambda ()
				       (pomidor-stop)
				       ))
(add-hook 'org-pomodoro-finished-hook (lambda ()
					(pomidor-break)
					))


(defun org-custom-link-img-follow (path)
  (org-open-file-with-emacs
   (format "../images/%s" path)))

(defun org-custom-link-img-export (path desc format)
  (cond
   ((eq format 'html)
    (format "<img src=\"/images/%s\" alt=\"%s\"/>" path desc))))

(org-add-link-type "img" 'org-custom-link-img-follow 'org-custom-link-img-export)

;;create a post of hugo blog template
(add-to-list 'org-structure-template-alist
                 '("hugo" "#+STARTUP: showall \n#+TITLE:  \n#+BEGIN_EXPORT html\n --- \n title:\n draft:true\n date:\n categories:\n tags:\n ---\n#+END_EXPORT \n"))

(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%Y-%m-%d>" . "<%Y-%m-%d %H:%M>"))


;;org-mode&omnifocus rsync task item
;; (setq rsync_file_path "~/Documents/Emacs_Omnifocus.scpt")
;; (setq todo-file-path (concat org-directory "test.org"))
;; (defun eiio-org-omnifocus-getResult()
;;   "return excute osascript command result json string"
;;   (interactive)
;;   (let((excute-command-str (format "osascript %s" "~/Documents/Emacs_Omnifocus.scpt")))
;;     ;;excute command
;;     (shell-command-to-string excute-command-str))
;; )

(setq org-mime-library 'mml)
(add-hook 'message-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c M-o") 'org-mime-htmlize)))
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c M-o") 'org-mime-org-buffer-htmlize)))
(setq org-mime-export-options '(:section-numbers nil
                                   :with-author nil
                                   :with-toc nil))
(provide 'init-org-mode)
;;; init-org-mode.el ends here

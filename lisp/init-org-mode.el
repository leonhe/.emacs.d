;; init-org-mode.el --- org mode configure
;;; Commentary:
;;; Code:
;;(add-to-list 'org-modules 'org-mac-iCal)
(use-package org
  :ensure t
  :mode (("\\.org\\'" . org-mode)
	 ("\\.og\\'" . org-mode))
  :interpreter ("org" . org-mode)
  :bind  (("C-c o a" . org-agenda)
	  ("C-c o b" . org-iswitchb)
	  ("C-c s t" . org-tags-view)
	  ;;:map org-mode-map
	)  
  :config
  (progn
    (org-bullets-mode 1)
    (setq org-agenda-archives-mode t)
    (setq org-directory "~/Note/")
    (setq org-default-notes-file "~/Note/todo/inbox.org")
    (setq org-priority-faces '((?A . (:foreground "red" :weight 'bold))
			       (?B . (:foreground "yellow"))
			       (?C . (:foreground "green"))))
    (setq org-agenda-files
	  '(quote
	    ("~/Note/wiki/personal/day.org"
	     "~/Note/note/inbox.org"
	     "~/Note/todo/task.org"
	     "~/Note/todo/inbox.org")))
    (setq org-mobile-inbox-for-pull "~/Note/todo/inbox.org")
    (setq org-mobile-files (list "~/Note/todo/inbox.org"
				 "~/Note/todo/task.org"
				 "~/Note/todo/project.org"
				 "~/Note/todo/book.org"
				 "~/Note/todo/house.org"
				 ))
    (defvar org-mobile-directory "/ssh:root@leonhe.me:/var/www/webdav/Org/")
    ))

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
  )


  (require 'org-pomodoro)
  (require 'ox-md)
  (require 'ox-publish)
  (require  'org-mime)
(defun eiio-init-orgmode()
  "initilze org-mode"
  ;;(message "init org-mode")
  (setq truncate-lines nil);;org 支持自动换行
  (org-indent-mode t)
  (setq org-log-done 'time)   ;;显示任务完成时间
  (setq org-refile-use-outline-path t)
  ;;ical
  (defvar org-agenda-include-diary t)
  )

(defun eiio-init-orgmode()
  "initilze org-mode"
  ;;(message "init org-mode")

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

(defvar org-agenda-exporter-settings
      '(
	(ps-number-of-columns 2)
	(ps-landscape-mode t)
	(org-agenda-add-entry-text-maxlines 5)
	(org-clock-out-remove-zero-time-clocks t)
	(org-agenda-repeating-timestamp-show-all t)
	))

(defun my-after-load-org()
  (defvar org-clock-out-remove-zero-time-clocks t)
  (defvar org-agenda-include-diary t)
  (defvar org-agenda-compact-blocks t)
  (defvar org-clock-persist 'history)
  (org-clock-persistence-insinuate)

  (setq org-refile-targets (quote (("inbox.org" :maxlevel . 1)
				 ("somemaybe.org" :maxlevel . 2)
				 ("task.org" :maxlevel . 2)
				 ("project.org" :maxlevel . 2))))

  ;;capture
(defvar org-capture-templates
      '(("t" "TODO" entry (file+headline "todo/inbox.org" "Inbox")
	 "* TODO %?\n  %i\n")
	("n" "Day Note" entry (file+datetree "~/Note/wiki/personal/day.org")
	 "* %?\n Entered on %U\n  %i\n")
	("b" "Inbox Note" entry (file+datetree "note/inbox.org")
	 "* %?\n Entered on %U\n  %i\n")
	))
(define-key global-map "\C-coc" 'org-capture)
(defvar org-html-doctype "xhtml5")

  )
(eval-after-load "org" '(my-after-load-org))


(setq org-publish-project-alist
           '(("res"
	      :base-directory  "~/Note/static/wiki/"
	      :base-extension "jpg\\|gif\\|png\\|js\\|css\\|svg\\|ttf\\|woff\\|ico"
	       :recursive t
	       :publishing-directory "/ssh:root@leonhe.me:/var/www/wiki/"
	       ;;:publishing-directory "/ssh:pi@192.168.1.12#1383:/var/www/html/"
;;	       :publishing-directory "~/Note/wiki_public/"
               :publishing-function org-publish-attachment)
	     ("public"
	      :base-directory  "~/Note/wiki/"
	      :base-extension "org"
	      :recursive t
	      :publishing-directory "/ssh:root@leonhe.me:/var/www/wiki/"
	      :publishing-function org-html-publish-to-html
	      :section-numbers nil
	      :table-of-contents nil
	      :html-head "<link rel=\"stylesheet\" title=\"Standard\" href=\"./style/worg.css\" type=\"text/css\" />
<link rel=\"alternate stylesheet\" title=\"Zenburn\" href=\"./style/worg-zenburn.css\" type=\"text/css\" />
<link rel=\"alternate stylesheet\" title=\"Classic\" href=\"./style/worg-classic.css\" type=\"text/css\" />
<link rel=\"SHORTCUT ICON\" href=\"./org-mode-unicorn.ico\" type=\"image/x-icon\" />
<link rel=\"icon\" href=\"./org-mode-unicorn.ico\" type=\"image/ico\" />"
	       ;; :html-preamble ,(with-temp-buffer (insert-(format "message" format-args)ile-contents "/home/emacs/git/worg/preamble.html") (buffer-string))
	      :html-postamble ""
	      :htmlized-source t
	      :auto-sitemap 
	      :sitemap-title "Wiki"
	      :sitemap-ignore-case t
	       :makeindex t
	       :with-date nil
	       :with-email t
	       )
	     
	     ("wiki" :components ("res" "public"))
	     ))

(add-to-list 'org-modules 'org-timer)
(defvar org-timer-default-timer 25)
(add-hook 'org-clock-in-hook (lambda ()
			       (if (not (defvar org-timer-current-timer)) 
				   (org-timer-set-timer '(16)))))

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

(defvar org-mime-library 'mml)
(add-hook 'message-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c M-o") 'org-mime-htmlize)))
(add-hook 'org-mode-hook
          (lambda ()
            (local-set-key (kbd "C-c M-o") 'org-mime-org-buffer-htmlize)))
(defvar org-mime-export-options '(:section-numbers nil
                                   :with-author nil
                                   :with-toc nil))
(provide 'init-org-mode)
;;; init-org-mode.el ends here

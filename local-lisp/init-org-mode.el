;	   ;;:sitemap-filename "posts.org"
; init-org-mode.el --- org mode configure
;;; Commentary:
;;; Code:
(add-to-list 'load-path "~/.emacs.d/local-package/org-reveal/")
(add-to-list 'load-path "~/.emacs.d/local-package/org-wiki/")
(add-to-list 'load-path "~/.emacs.d/local-package/org-recipes/")

(use-package org-mime
  :ensure t
  )
(use-package htmlize
  :ensure t)
;; (use-package org-super-agenda
;;    :ensure t)
(use-package org-bullets
  :ensure t)
(require 'ox-md)
(require 'ox-publish)
(require 'ox-beamer)
(require 'htmlize)
(require 'org-bullets)
;; (require 'org-super-agenda)
(require 'org-habit)
(require 'org-recipes)
(require 'org-wiki)

(setq org-image-actual-width t)
(setq calendar-mark-diary-entries-flag t)
(setq org-agenda-window-setup 'current-window) 
;;agenda key bind
(global-set-key (kbd "C-c d") 'org-agenda-list)
(global-set-key (kbd "C-c m") 'org-agenda-month-view)
(defun indent-org-block-automatically ()
  (when (org-in-src-block-p)
   (org-edit-special)
    (indent-region (point-min) (point-max))
    (org-edit-src-exit)))

(run-at-time 1 10 'indent-org-block-automatically)

;;org-wiki
(setq org-wiki-location-list
      '(
        "~/Org/wiki/"
        ))

;; Initialize first org-wiki-directory or default org-wiki 
(setq org-wiki-location (car org-wiki-location-list))
(setq org-wiki-default-read-only nil)
(setq org-wiki-close-root-switch t)
(setq org-wiki-server-port "9000")
(setq org-wiki-server-host "0.0.0.0")   ;; Listen all hosts (default value)
(define-key global-map "\C-cwi" 'org-wiki-insert-new)
(define-key global-map "\C-cws" 'org-wiki-switch-root)
(define-key global-map "\C-cwh" 'org-wiki-index)
;;(define-key global-map "\C-cwl" 'org-wiki-helm)
;;(define-key global-map "\C-cws" 'org-wiki-switch)
(add-hook 'org-mode-hook 'org-indent-mode)
			   

;;(require 'ox-reveal)

(setq org-agenda-archives-mode t)
(setq org-directory "~/Org/")
(setq org-default-notes-file "~/Org/task/inbox.org")
(setq org-priority-faces '((?A . (:foreground "red" :weight 'bold))
			   (?B . (:foreground "yellow"))
			   (?C . (:foreground "green"))))


;;setting agenda directioy
(setq org-agenda-files
      (file-expand-wildcards "~/Org/task/*.org"
			     "~/Org/task/*.org_archive"))

(use-package ob-typescript
  :ensure t
  :config
  (require 'ob-typescript)
  )
(require 'ob-ledger)
(use-package ledger-mode
  :ensure t)
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (ledger . t)
   (emacs-lisp . t)
   (ruby . t)
   (typescript .t)
   (js . t)
   
))



;;bind key
(define-key global-map "\C-coc" 'org-capture)
(define-key global-map "\C-coa" 'org-agenda)
(define-key global-map "\C-cot" 'org-tags-view)
(global-set-key (kbd "C-c o b") 'org-switchb)
(defun archive-done-tasks ()
  (interactive)
  (save-excursion
    (goto-char (point-min))
    (while (re-search-forward
            (concat "\\* " (regexp-opt org-done-keywords) " ") nil t)
      (goto-char (line-beginning-position))
      (org-archive-subtree))))
(defun enable-auto-archive ()
  (add-hook 'after-save-hook 'archive-done-tasks))
;;(add-hook 'org-mode-hook 'enable-auto-archive)
(setq org-todo-repeat-to-state t)
(setq org-mobile-inbox-for-pull "~/Org/task/inbox.org")
(setq org-mobile-files (list "~/Org/task/inbox.org"
			     "~/Org/task/task.org"
			     "~/Org/task/project.org"
			     ))
(defvar org-mobile-directory "~/Documents/webdav/Org")

(setq org-src-fontify-natively t)
(org-indent-mode t)
(setq org-log-done 'time)   ;;显示任务完成时间
(setq org-refile-use-outline-path t)
(defvar org-agenda-include-diary nil)
 ;;setting workflow state
(setq org-todo-keywords '((sequence "TODO(t)"  "|"  "DONE(d)")
             (sequence "WAITING(w)" "|" "CANCELED(c)")
            ))
(setq org-tag-alist '(("@office" . ?o) ("@home" . ?h)))
;;设置关键字颜色
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ;;("NEXT" :foreground "yellow" :weight bold)
	      ;;("DOING" :foreground "orange" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("WAITING" :foreground "orange" :weight bold)
;;	      ("HOLD" :foreground "magenta" :weight bold)
	      ("CANCELLED" :foreground "#F0F0F0" :weight bold)
	      )))
;; (defun org-summary-todo (n-done n-not-done)
 ;;   "Swith entry to DONE when all subentries are done, to TODO otherwise."
;;   (let (org-log-done org-log-states)   ; turn off logging.
;;     (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

;; (setq org-todo-state-tags-triggers
;;       (quote (("CANCELLED" ("CANCELLED" . t))
;;               ("WAITING" ("WAITING" . t))
;;               ("HOLD" ("WAITING") ("HOLD" . t))
;;               ;;(done ("WAITING") ("HOLD"))
;;               ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
;;               ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
;;               ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))
 (defvar org-agenda-exporter-settings
      '(
	(ps-number-of-columns 2)
	(ps-landscape-mode t)
	(org-agenda-add-entry-text-maxlines 5)
	(org-clock-out-remove-zero-time-clocks t)
	(org-agenda-repeating-timestamp-show-all t)
	))

  (setq org-refile-targets (quote (("inbox.org" :maxlevel . 1)
				   ("task.org" :maxlevel . 4)
				   ("project.org" :maxlevel . 4)
                                   ("book.org" :maxlevel . 4)
                                 )))
;;capture
(defvar org-capture-templates
      '(("t" "TODO" entry (file+headline "task/inbox.org" "Inbox")
	 "* TODO %?\n  %i\n")
	("n" "Day Note" entry (file+datetree "~/Org/personal/day.org")
	 "* %?\n Entered on %U\n  %i\n")
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
(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%Y-%m-%d>" . "<%Y-%m-%d %H:%M>"))

;;设置 Org 文件自动换行
(add-hook 'org-mode-hook
	  (lambda ()
	    (setq truncate-lines nil)
	    (org-bullets-mode 1)
	    (local-set-key (kbd "C-c s") 'org-archive-subtree)
	    (local-set-key (kbd "C-c C-x h") 'org-insert-heading)
	    (local-set-key (kbd "C-c C-x s") 'org-insert-subheading)
   ))
;;org export setting
;;(setq org-publish-sitemap-date-format "%Y-%m-%d")
;;(setq org-publish-sitemap-file-entry-format "%Y-%m-%d")
(setq org-publish-sitemap-sort-ignore-case "posts.org")
;;(setq org-publish-use-timestamps-flag nil)

  ;;(setq org-html-use-infojs t)
  (setq org-publish-project-alist
	'(
	  ("note"
	   :base-directory "~/Org/notes/posts"
	   :base-extension "org"
	   :recursive t
	   :publishing-directory "~/Org/publish/posts"
	   :publishing-function  org-html-publish-to-html
	   :language "zh-CN"
	   :auto-preamble nil
	   :auto-postamble nil
	   :html-head "<link rel=\"stylesheet\" href=\"static/css/worg.css\" type=\"text/css\" media=\"screen\" \/><link rel=\"stylesheet\" href=\"static/css/style.css\" type=\"text/css\" media=\"screen\" \/>"
	   :author "Leon He"
	   :email "lhe868@gmail.com"	 
	   :with-title t
	   :with-creator t
	   :with-date t
	   :export-creator-info nil
	   :html-validation-link nil
	   ;;:html-link-home "/"
	   ;;:html-link-up "/posts.html"
	   :html-preamble t
	   :htmlized-source t
	   :makeindex "index.org"
	   :auto-sitemap t
	   :sitemap-filename "posts.org"
	   :sitemap-title "Posts"
	   :sitemap-sort-files anti-chronologically
	   :sitemap-file-entry-format "%d - %t"
           :sitemap-ignore-case "posts.org"
;;	   :sitemap-function org-publish-org-sitemap
	   :html-doctype "html5"
	   :html-html5-fancy t
;;         :html-head ,website-html-head
	   :html-postamble "<p class=\"copyright\">Copyright (c) 2012 - 2019, Leon He; all rights reserved.</p>"
	   )
	  ("financial"
	   :base-directory "~/Org/personal/financial/"
	   :base-extension "org"
	   :publishing-directory "~/Org/publish/financial/"
	   :publishing-function  org-html-publish-to-html
	   :language "zh-CN"
	   :auto-preamble nil
	   :auto-postamble nil
	   :html-head "<link rel=\"stylesheet\" href=\"static/css/worg.css\" type=\"text/css\" media=\"screen\" \/><link rel=\"stylesheet\" href=\"static/css/style.css\" type=\"text/css\" media=\"screen\" \/><link rel=\"stylesheet\" href=\"static/css/bootstrap.min.css\" type=\"text/css\" media=\"screen\" />"
	   :author "Leon He"
	   :email "lhe868@gmail.com"	 
	   :with-title t
	   :with-creator t
	   :with-date t
	   :with-toc t 
	   :export-creator-info nil
	   :html-validation-link nil
	   :html-preamble t
	   :htmlized-source t
	   :auto-sitemap nil
	   :html-doctype "html5"
	   :html-html5-fancy t
	   :html-postamble "<p class=\"copyright\">Copyright (c) 2012 - 2019, Leon He; all rights reserved.</p>"
	   )
("root"
	   :base-directory "~/Org/notes/"
	   :base-extension "org"
	   :publishing-directory "~/Org/publish/"
	   :publishing-function  org-html-publish-to-html
	   :language "zh-CN"
	   :auto-preamble nil
	   :auto-postamble nil
	   :html-head "<link rel=\"stylesheet\" href=\"static/css/worg.css\" type=\"text/css\" media=\"screen\" \/><link rel=\"stylesheet\" href=\"static/css/style.css\" type=\"text/css\" media=\"screen\" \/><link rel=\"stylesheet\" href=\"static/css/bootstrap.min.css\" type=\"text/css\" media=\"screen\" />"
	   :author "Leon He"
	   :email "lhe868@gmail.com"	 
	   :with-title t
	   :with-creator t
	   :with-date t
	   :with-toc nil
	   :export-creator-info nil
	   :html-validation-link nil
	   :html-preamble t
	   :htmlized-source t
	   :auto-sitemap nil
	   :html-doctype "html5"
	   :html-html5-fancy t
	   :html-postamble "<p class=\"copyright\">Copyright (c) 2012 - 2019, Leon He; all rights reserved.</p>"
	   )
	("res"
	 :base-directory  "~/Org/static/"
	 :base-extension "jpg\\|gif\\|png\\|js\\|css\\|svg\\|ttf\\|woff\\|ico\\|pdf\\|"
	 :recursive t
	 :publishing-directory "~/Org/publish/static/"
	 ;;:publishing-directory "/ssh:root@feiio.com:/var/www/html/"
	 :publishing-function org-publish-attachment)
	("MyNote" :components ("note" "root" "res"))
	))

(defun eiio/publish()
  (interactive)
  ;;(org-publish-project "MyNote")
  ;;(easy-hugo-publish)
  (let ((multi-term-program "sh ~/Documents/blog/deploy.sh"))
    (multi-term))
  )

;;(setq org-agenda-include-diary t)
;;org-super agenda
;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)
(setq org-agenda-skip-deadline-prewarning-if-scheduled t)

(setq org-agenda-custom-commands
      '(("d" "Today Action"
         (
          (agenda "" ((org-agenda-span 1)))
          ;;(agenda "" ((org-agenda-span 7))) ;review upcoming deadlines and appointments
          (tags-todo "+PRIORITY=\"A\"")
	  (todo "TODO") ;; exports block to this file with C-c a e
	  )
	  nil                      ;; i.e., no local settings
;;          ("/ssh:root@feiio.com:/var/www/webdav/todo.html")
          ("~/Documents/task/today.html")
          )
        ("w" todo "WAITING")        
        ("t" "TODO Action"
         (
          (agenda "" ((org-agenda-span 1)))
          ;;(agenda "" ((org-agenda-span 7))) ;review upcoming deadlines and appointments
          (stuck "") ; review stuck projects as designated by org-stuck-projects
          (tags-todo "+PxRIORITY=\"A\"")
	  (todo "TODO") ;; exports block to this file with C-c a e
	  )
	  nil                      ;; i.e., no local settings
;;          ("/ssh:root@feiio.com:/var/www/webdav/todo.html")
          ("~/Documents/task/todo.html")
          )
        ("W" "Weekly Review"
         ((agenda "" ((org-agenda-span 7))); review upcoming deadlines and appointments
                                        ; type "l" in the agenda to review logged items
          (todo "TOOD")
          (todo "WAITING")
          
          )
         nil                      ;; i.e., no local settings
         ;;("/ssh:root@feiio.com:/var/www/webdav/w41.html")
         ("~/Documents/task/week.html")
         ) ; review waiting items
         ;; ...other commands here
          
        ))


(provide 'init-org-mode)
;;; init-org-mode.el ends here

;; init-org-mode.el --- org mode configure
;;; Commentary:
;;; Code:
(add-to-list 'load-path "~/.emacs.d/local/org-reveal/")
(add-to-list 'load-path "~/.emacs.d/local/org-wiki/")
(add-to-list 'load-path "~/.emacs.d/local/org-recipes/")
(require 'org-super-agenda)
(require 'org-pomodoro)
(require 'ox-md)
(require 'ox-publish)
(require  'org-mime)
(require 'ox-beamer)
;;(require 'htmlize)
(require 'org-bullets)
(require 'org-super-agenda)
(require 'org-habit)
(require 'org-wiki)
(require 'org-recipes)
;;org-wiki
(setq org-wiki-location-list
      '(
        "~/Org/wiki/"
        ))

;; Initialize first org-wiki-directory or default org-wiki 
(setq org-wiki-location (car org-wiki-location-list))
(setq org-wiki-default-read-only nil)
(setq org-wiki-close-root-switch t)
(setq org-wiki-server-port "8000")
(setq org-wiki-server-host "0.0.0.0")   ;; Listen all hosts (default value)
(setq org-wiki-server-host "127.0.0.1") ;; Listen only localhost
(define-key global-map "\C-cwi" 'org-wiki-insert-new)
(define-key global-map "\C-cws" 'org-wiki-switch-root)
(define-key global-map "\C-cwh" 'org-wiki-index)
(define-key global-map "\C-cwl" 'org-wiki-helm)
;;(define-key global-map "\C-cws" 'org-wiki-switch)


;;w(require 'ox-reveal)

(setq org-agenda-archives-mode t)
(setq org-directory "~/Org/")
(setq org-default-notes-file "~/Org/task/inbox.org")
(setq org-priority-faces '((?A . (:foreground "red" :weight 'bold))
			   (?B . (:foreground "yellow"))
			   (?C . (:foreground "green"))))


;;setting agenda directioy
(setq org-agenda-files
     (file-expand-wildcards "~/Org/task/*.org" "~/Org/task/*.org_archive"))

(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (swift . t)
))

;;bind key
(define-key global-map "\C-coc" 'org-capture)
(define-key global-map "\C-coa" 'org-agenda)
(define-key global-map "\C-cot" 'org-tags-view)
(global-set-key (kbd "C-c o b") 'org-switchb)
(local-set-key (kbd "C-c s") 'org-archive-subtree)

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
(defvar org-mobile-directory "/ssh:root@feiio.com:/var/www/webdav/Org")
(setq org-src-fontify-natively t)
(org-indent-mode t)
(setq org-log-done 'time)   ;;显示任务完成时间
(setq org-refile-use-outline-path t)
(defvar org-agenda-include-diary t)
 ;;setting workflow state
(setq org-todo-keywords '((sequence "TODO(t)"  "|"  "DONE(d)")
             (sequence "WAITING(w)" "|" "CANCELED(c)")
            ))
(setq org-agenda-files
      '("~/Org/task/"))
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
				 ("project.org" :maxlevel . 4))))
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
;; (setq-default org-display-custom-times t)
;; (setq org-time-stamp-custom-formats '("<%Y-%m-%d>" . "<%Y-%m-%d %H:%M>"))

;;设置 Org 文件自动换行
(add-hook 'org-mode-hook
	  (lambda ()
	    (setq truncate-lines nil)
	    (org-bullets-mode 1)
	 
   ))
(setq org-publish-sitemap-date-format "%Y-%m-%d")
(setq org-publish-sitemap-file-entry-format "%Y-%m-%d")
(setq org-publish-sitemap-sort-ignore-case "posts.org")
  ;;(setq org-html-use-infojs t)
  (setq org-publish-project-alist
	'(
	  ("note"
	   :base-directory "~/Org/notes/"
	   :base-extension "org"
	   :recursive t
	   :publishing-directory "/ssh:root@feiio.com:/var/www/html/"
	   :publishing-function org-html-publish-to-html
	   :language "zh-CN"
	   :auto-preamble nil
	   :auto-postamble nil
	   :html-head "<link rel=\"stylesheet\" href=\"https://feiio.com/css/worg.css\" type=\"text/css\" media=\"screen\" \/>"
	   :author "Leon He"
	   :email "leonhe86@gmail.com"	 
	   :with-title t
	   :with-creator t
	   :timestamp nil
	   :export-creator-info nil
	   :html-validation-link nil
	   :html-link-home "/"
	   :html-link-up "/posts.html"
	   :html-preamble t
	   :htmlized-source t
	   :auto-sitemap t
	   :sitemap-function org-publish-sitemap-default
	   :sitemap-sort-folders "last"
           :sitemap-ignore-case "index.org"
	    :sitemap-file-entry-format "%d %t"
            :sitemap-title "posts"
	    :sitemap-filename "./posts.org"
	    :sitemap-style tree
            ;;Px:exclude "posts.org"
	   :sitemap-sort-files anti-chronologically
	   :html-postamble "<p class=\"copyright\">Copyright (c) 2012 - 2018, Leon He; all rights reserved.</p>"
	   )
	  ("task"
	   :base-directory "~/Org/task/"
	   :base-extension "org"
	   :recursive t
	   :publishing-directory "/ssh:root@feiio.com:/var/www/webdav/task/"
	   :publishing-function org-html-publish-to-html
	   :language "zh-CN"
	   :auto-preamble nil
	   :auto-postamble nil
	   :html-head "<link rel=\"stylesheet\" href=\"https://feiio.com/css/worg.css\" type=\"text/css\" media=\"screen\" \/>"
	   :author "Leon He"
	   :email "leonhe86@gmail.com"	 
	   :with-title t
	   :with-creator t
	   :timestamp nil
	   :export-creator-info nil
	   :html-validation-link nil
	   :html-link-home "/"
	   :html-link-up "/sitemap.html"
	   :html-preamble t
	   :htmlized-source t
	   :html-use-infojs ""
	   :html-postamble "<p class=\"copyright\">Copyright (c) 2012 - 2018, Leon He; all rights reserved.</p>"
	   )
	("res"
	 :base-directory  "~/Org/static/"
	 :base-extension "jpg\\|gif\\|png\\|js\\|css\\|svg\\|ttf\\|woff\\|ico\\|pdf\\|"
	 :recursive t
	 :publishing-directory "/ssh:root@feiio.com:/var/www/html/"
	 :publishing-function org-publish-attachment)
	("MyNote" :components ("note" "res"))
	))

(defun eiio/publish()
  (interactive)
  ;;(org-publish-project "MyNote")
  ;;(easy-hugo-publish)
  (let ((multi-term-program "rsync-copy ~/Documents/publics/* root@leonhe.me:/var/www/html/"))
                   (multi-term))
  )

(setq org-agenda-include-diary t)
(global-set-key (kbd "C-c o i") 'eiio/omnifoucs)
;;org-super agenda
;; Do not dim blocked tasks
(setq org-agenda-dim-blocked-tasks nil)
(setq org-agenda-skip-deadline-prewarning-if-scheduled t)
(setq org-agenda-custom-commands
      '(("n" "Next Action"
         (
          (agenda "" ((org-agenda-span 1)))
          ;;(agenda "" ((org-agenda-span 7))) ;review upcoming deadlines and appointments
          (tags-todo "+PRIORITY=\"A\"")
	  (todo "TODO") ;; exports block to this file with C-c a e
	  )
	  nil                      ;; i.e., no local settings
          ;;("/ssh:root@feiio.com:/var/www/webdav/todo.html")
          ("~/Org/public/todo.html")
	  )
        ("w" todo "WAITING")
        ("d" "Day Action"
         (
          (agenda "" ((org-agenda-span 1)))
          ))
        ("W" "Weekly Review"
         ((agenda "" ((org-agenda-span 7))); review upcoming deadlines and appointments
                                        ; type "l" in the agenda to review logged items 
          (todo "TOOD")
          (todo "WAITING")
          (stuck "") ; review stuck projects as designated by org-stuck-projects
          
          )
         nil                      ;; i.e., no local settings
         ;;("/ssh:root@feiio.com:/var/www/webdav/w41.html")
         ("~/Org/public/w.html")
         ) ; review waiting items
         ;; ...other commands here
          
        ))
(provide 'init-org-mode)
;;; init-org-mode.el ends here

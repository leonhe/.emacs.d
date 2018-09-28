;; init-org-mode.el --- org mode configure
;;; Commentary:
;;; Code:
(add-to-list 'load-path "~/.emacs.d/local/org-reveal/")
(require 'org-pomodoro)
(require 'ox-md)
(require 'ox-publish)
(require  'org-mime)
(require 'ox-beamer)
(require 'htmlize)
(require 'org-bullets)
(require 'org-super-agenda)
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
   (swift3 . t)
   (swift . t)
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

(setq org-mobile-inbox-for-pull "~/Org/task/inbox.org")
(setq org-mobile-files (list "~/Org/task/inbox.org"
			     "~/Org/task/task.org"
			     "~/Org/task/project.org"
			     "~/Org/task/book.org"
			     "~/Org/task/house.org"
			     ))
(defvar org-mobile-directory "/ssh:root@feiio.com:/var/www/webdav/Org")
(setq org-src-fontify-natively t)
(org-indent-mode t)
(setq org-log-done 'time)   ;;显示任务完成时间
(setq org-refile-use-outline-path t)
(defvar org-agenda-include-diary t)
 ;;setting workflow state
(setq org-todo-keywords '((sequence "TODO(t)" "|" "NEXT(n)" "|"  "DONE(d)")
             (sequence "HOLD(h)" "|" "WAITING(w)" "|" "CANCELED(c)")
            ))
(setq org-agenda-files
      '("~/Org/task/"))
;;设置关键字颜色
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("NEXT" :foreground "blue" :weight bold)
	      ("DOING" :foreground "orange" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("WAITING" :foreground "orange" :weight bold)
	      ("HOLD" :foreground "magenta" :weight bold)
	      ("CANCELLED" :foreground "#F0F0F0" :weight bold)
	      )))
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
(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%Y-%m-%d>" . "<%Y-%m-%d %H:%M>"))

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
(defun eiio/omnifoucs()
  (interactive)
  (progn
    (setq outData (shell-command-to-string "osascript -l JavaScript ~/Documents/OminfocusTask.scpt"))    
    ;;(message (split-string outData))

  ))

(setq org-agenda-include-diary t)
(global-set-key (kbd "C-c o i") 'eiio/omnifoucs)
(let ((org-super-agenda-groups
       '(;; Each group has an implicit boolean OR operator between its selectors.
         (:name "Today"  ; Optionally specify section name
                :time-grid t  ; Items that appear on the time grid
                :todo "TODAY")  ; Items that have this TODO keyword
         (:name "Next"
                ;; Single arguments given alone
                :todo "NEXT"
                )
         ;; Set order of multiple groups at once
                ;; After the last group, the agenda will display items that didn't
         ;; match any of these groups, with the default order position of 99
         )))
(org-agenda nil "a"))

(setq org-agenda-custom-commands
      '(("n" todo "NEXT")
        ("w" todo "WAITING")
        ))
(provide 'init-org-mode)
;;; init-org-mode.el ends here

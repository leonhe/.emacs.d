;;; init-org-mode.el --- org mode configure
;;; Commentary:
;;; Code:
;;(add-to-list 'org-modules 'org-mac-iCal)
(add-to-list 'auto-mode-alist '("\\.org\\'". org-mode))
(add-to-list 'auto-mode-alist '("\\.og\\'" . org-mode))
;;setting org directory
(defvar org-directory "~/Note/")
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;;org 支持自动换行
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(defvar org-feed-alist
      '(
	("纽约时报国际生活"
	 "http://cn.nytstyle.com/rss.html"
         "~/Documents/org/feed/news.org" "纽约时报国际生活")
	("网易大法好"
	 "http://news.163.com/special/00011K6L/rss_newstop.xml"
         "~/Documents/feed/news.org" "网易大法好")
	("大败毒"
	 "http://news.baidu.com/n?cmd=7&loc=2354&name=%E4%B8%8A%E6%B5%B7&tn=rss"
         "~/Documents/feed/news.org" "大败毒")
	("QQ News"
	 "http://news.qq.com/newsgn/rss_newsgn.xml"
         "~/Documents/feed/news.org" "QQ News")
	  ))


;;显示任务完成时间
(setq org-log-done 'time)
;;(setq org-log-done 'note)
;;在周列表中显示任务
(setq org-agenda-include-diary t)
(setq org-todo-keywords
      '((sequence "TODO(t)" "WAIT(w)" "DONE(d)")
	))



;;ical
(setq org-agenda-include-diary t)
(setq org-agenda-custom-commands
      '(("I" "Import diary from iCal" agenda ""
	 ((org-agenda-mode-hook
	   (lambda ()
	                  (org-mac-iCal)))))))
(defun my-after-load-org ()
  (add-to-list 'org-modules 'org-mac-iCal))
(eval-after-load "org" '(my-after-load-org))

;;capture
(setq org-capture-templates
      '(("t" "TODO" entry (file+headline (concat org-directory "/todo/task.org") "Inbox")
	 "* TODO %?\n  %i\n")
	("n" "Day Note" entry (file+datetree (concat org-directory "\/note\/day.org"))
	 "* %?\n Entered on %U\n  %i\n")
	("b" "Inbox Note" entry (file+datetree (concat org-directory "/note/inbox.org"))
	 "* %?\n Entered on %U\n  %i\n")
	))

;;(setq org-default-notes-file (concat org-directory "/inbox.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-html-doctype "xhtml5")

(require 'ox-publish)
(require 'ox-md)
(setq org-publish-project-alist
           '(("public"
              :base-directory  "~/Note/public"
              :publishing-directory (concat org-directory "/blog/content/")
	      :base-extension "org"
              :section-numbers nil
              :table-of-contents  nil
      	      :publishing-function org-md-publish-to-md
	      :recursive t
	      :auto-preamble nil
	      :html-head-include-default-style nil
	      :html-head-include-scripts nil
	      :date-timestamp "%Y-%m-%d"
	      ;; :auto-sitemap t
	      ;; :sitemap-file-entry-format "%d-%t"
	      ;; :sitemap-filename "sitmap.org"
	      ;; :sitemap-title ""
	      ;; :html-head "<link rel=\"stylesheet\" href=\"http://cdn.bootcss.com/bootstrap/4.0.0-alpha.4/css/bootstrap.css\" type=\"text/css\">"
	      ;; :makeindex t
	      ;; :style-include-default nil
	      :headline-levels 4
	      
	      :body-only t
	      )
	     ("res"
               :base-directory  "~/Note/static"
               :base-extension "jpg\\|gif\\|png\\|js\\|css\\|svg\\|ttf\\|woff"
	       :recursive t
	       :publishing-directory (concat org-directory "/blog/static/")
               :publishing-function org-publish-attachment)
	     ("website" :components ("res" "public"))
	     ))


(require 'org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))
(add-to-list 'org-modules 'org-timer)
(setq org-timer-default-timer 25)
(add-hook 'org-clock-in-hook (lambda ()
      (if (not org-timer-current-timer) 
	  (org-timer-set-timer '(16)))))
(require 'org-pomodoro)
;; (defun eiio-pomodoro()
;;   "promodoro time manager"
;;   (org-pomodoro-start :pomodoro)
;; )
;; (defun eiio-pomodoro-stop()
;;   "pomodoro stop"
;;   (org-pomodoro-kille)
  
;;   )



;; (global-set-key (kbd "C-c p s") 'eiio-pomodoro)
;; (global-set-key (kbd "C-c p k") 'eiio-pomodoro-stop)

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
	     '("hugo" "#+STARTUP: showall \n#+TITLE:  \n#+BEGIN_HTML\n --- \n title:\n draft:true\n date:\n categories:\n tags:\n ---\n#+END_HTML \n"))

(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%Y-%m-%d>" . "<%Y-%m-%d %H:%M>"))
;;org-mode&omnifocus rsync task item
(setq rsync_file_path "/Users/leon/Works/EmacsAndOmnifocus/OminFocus.scpt")
(setq todo-file-path (concat org-directory "todo.org"))
(defun eiio-org-omnifocus-getResult(value)
  "return excute osascript command result json string"
  (let((excute-command-str (format "osascript -l JavaScript %s %s" rsync_file_path value))
       )
    ;;excute command
    (shell-command-to-string excute-command-str))
)

(defun eiio-org-omnifocus ()
  "rsync omnifocus task to org-mode"
  (interactive)
  
  (with-temp-buffer
    (let (
	  (script-source (eiio-org-omnifocus-getResult "getFolder"))
	  )
      (message script-source)
      (setq inboxTasks (json-read-from-string script-source))
      (setq len (length inboxTasks))
     
      (setq result "#+STARTUP:showall \n #+TITLE:todo")
      (while (< 0 len)
	;;(message "%S" len)
	(let (
	      (item (elt inboxTasks (- len 1)))
	      )
	  (setq result (concat result (format "\n*%S" (cdr (assoc 'name item)))))
	  ;;(message "\n* %S" )
	  )
	(setq len (- len 1))
	)
      (org-list-bullet-string)
      ;;write task org file
      (write-region result nil todo-file-path t)
      (message "%S" todo-file-path)
      
      )
    ))
(defun eiio-init-orgmode()
  "initilze org-mode"
  (message "init org-mode")
  (add-hook 'org-after-todo-state-change-hook (lambda ()
						(message "state change")
						)))


(add-hook 'org-mode-hook 'eiio-init-orgmode)

(global-set-key (kbd "C-c o r") 'eiio-org-omnifocus)


(provide 'init-org-mode)
;;; init-org-mode.el ends here

;;org-mode initilze
;;(add-to-list 'org-modules 'org-mac-iCal)
(add-to-list 'auto-mode-alist '("\\.org\\'". org-mode))
(add-to-list 'auto-mode-alist '("\\.og\\'" . org-mode))
;;setting org directory
(setq org-directory "~/Project/org/")
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
;;org 支持自动换行
(add-hook 'org-mode-hook (lambda () (setq truncate-lines nil)))
(setq org-feed-alist
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
;;mobile org
;;(setq org-mobile-directory "~/Dropbox/MobileOrg")
;;blog-admin
(require-package 'blog-admin)
(require 'blog-admin)
(setq blog-admin-backend-path "~/Documents/myblog/")
(setq blog-admin-backend-type 'hexo)
(setq blog-admin-backend-new-post-in-drafts t) ;; create new post in drafts by default
(setq blog-admin-backend-new-post-with-same-name-dir t) ;; create same-name directory with new post
(setq blog-admin-backend-hexo-config-file "_config.yml") ;; default assumes _config.yml

;;capture
(setq org-capture-templates
      '(("t" "TODO" entry (file+headline (concat org-directory "/todo/task.org") "Inbox")
	 "* TODO %?\n  %i\n")
	("n" "Day Note" entry (file+datetree (concat org-directory "/note/day.org"))
	 "* %?\n Entered on %U\n  %i\n")
	("b" "Inbox Note" entry (file+datetree (concat org-directory "/note/inbox.org"))
	 "* %?\n Entered on %U\n  %i\n")
	))
'(org-agenda-files
   (quote
    ("~/Project/org/list.org_archive" "~/Project/org/book/list.org" "~/Project/org/todo/task.org")))
;;(setq org-default-notes-file (concat org-directory "/inbox.org"))
(define-key global-map "\C-cc" 'org-capture)
(require 'ox-publish)
(setq org-publish-project-alist
           '(("html"
              :base-directory "~/Project/org/"
              :publishing-directory "~/Project/public_html/"
	      ;;:publishing-directory "/ssh:root@vmbox.com:/usr/share/nginx/html/wiki/"
	      :base-extension "org"
              :section-numbers nil
              :table-of-contents nil
	      :publishing-function org-html-publish-to-html
	      :recursive t
	      :auto-preamble t
	      :html-head-include-default-style nil
	      :html-head-include-scripts nil
	      :auto-sitemap t
	      :sitemap-file-entry-format "%t"
	      :sitemap-filename "index.org"
	      :sitemap-title "Index"
	      :html-head "<link rel=\"stylesheet\" href=\"res/css/bootstrap.min.css\" type=\"text/css\">"
	      :makeindex t
	      )
	     ("res"
               :base-directory "~/Project/bootcss/"
               :base-extension "jpg\\|gif\\|png\\|js\\|css\\|svg\\|ttf\\|woff"
	       :recursive t
	       :publishing-directory "~/Project/public_html/res/"
	        ;;:publishing-directory "/ssh:root@vmbox.com:/usr/share/nginx/html/wiki/res/"
               :publishing-function org-publish-attachment)
	     ("website" :components ("res" "html"))
	     ))
(provide 'init-org-mode)
;;; init-org-mode.el ends here

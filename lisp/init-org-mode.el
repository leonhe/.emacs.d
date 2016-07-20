;;org-mode initilze
(require-package 'org)
;;(add-to-list 'org-modules 'org-mac-iCal)
(add-to-list 'auto-mode-alist '("\\.org\\'". org-mode))
(add-to-list 'auto-mode-alist '("\\.og\\'" . org-mode))
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
;;blog setting
(setq org-publish-project-alist
      '(("blog-source"
	 :base-directory "~/Documents/org/blog/"
	 :base-extension: "org"
	 :publishing-directory  "~/Documents/org/public_html/"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :auto-preamble t
	 :section-number nil
	 :with-toc nil
	 :html-head "<link rel=\"stylesheet\" href=\"css/bootstrap.min.css\" type=\"text/css\">"
	 )
	("blog-static"
	 :base-directory "~/Documents/org/blog/"
	 :base-extension "eot\\|svg\\|woff\\|woff2\\|css\\|js\\|png\\|jpg\\|gif\\|swf\\|jpge"
	 :publishing-directory "~/Documents/org/public_html/"
	 :recursive t
	 :publishing-function org-publish-attachment
	 )
	("blog" :components ("blog-source","blog-static"))
	))

(provide 'init-org-mode)

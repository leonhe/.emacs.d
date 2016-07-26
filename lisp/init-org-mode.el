;;org-mode initilze
(require-package 'org)
;;(add-to-list 'org-modules 'org-mac-iCal)
(add-to-list 'auto-mode-alist '("\\.org\\'". org-mode))
(add-to-list 'auto-mode-alist '("\\.og\\'" . org-mode))
;;setting org directory
(setq org-directory "~/Documents/org/")
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
      '(("blog-post"
	 :base-directory (concat org-directory "/blog/post")
	 :base-extension: "org"
	 :publishing-directory  "~/Documents/org/public_html/"
	 :recursive t
	 :publishing-function org-html-publish-to-html
	 :section-numbers nil
	 :with-toc nil
	 :with-author nil
	 :with-creator nil
	 :auto-preamble t
	 :with-tags nil
	 :with-title nil
n	 :html-link-up "post.html"
	 :html-link-home "index.html"
	 :html-head "<link rel=\"stylesheet\" href=\"css/bootstrap.min.css\" type=\"text/css\">"
	 :makeindex nil
	 :html-head-include-default-style nil
	 :html-head-include-scripts nil
	 :auto-sitemap t
	 :sitemap-filename "post.org"
	 :sitemap-title ""
	 :sitemap-file-entry-format "%d-%t"
	 )
	("blog-site"
	 :base-directory "~/Documents/org/blog/"
	 :base-extension: "org"
	 :publishing-directory  "~/Documents/org/public_html/"
	 :publishing-function org-html-publish-to-html
	 :section-numbers nil
	 :html-head-include-default-style nil
	 :html-head-include-scripts nil
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
	("blog" :components ("blog-post","blog-static","blog-site"))
	))
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
;;org-page
(require-package 'org-page)
(require 'org-page)
(setq op/repository-directory "~/Documents/org-page")
(setq op/site-domain "http://note.feiio.com/")
;;(op/do-publication)
(op/do-publication nil "HEAD^1" "~/Documents/public_html" nil)
(setq op/repository-org-branch "source")
(setq op/repository-html-branch "master")
(setq op/site-main-title "阿拉伯的鞋匠")
(setq op/site-sub-title "生活、技术、阅读、思考")
(setq op/personal-github-link "https://github.com/leonhe")
(setq op/personal-disqus-shortname "heyuanfei")
;;capture
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline (concat org-directory "/todo/inbox.org") "Tasks")
	 "* TODO %?\n  %i\n")
	("n" "Note" entry (file+datetree (concat org-directory "/note/inbox.org"))
	              "* %?\n Entered on %U\n  %i\n")
	))
;;(setq org-default-notes-file (concat org-directory "/inbox.org"))
(define-key global-map "\C-cc" 'org-capture)
(provide 'init-org-mode)

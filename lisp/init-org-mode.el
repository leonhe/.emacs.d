;;org-mode initilze

(add-to-list 'load-path "~/.emacs.d/mode/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/mode/org-mode/contrib/lisp" t)
;;(add-to-list 'org-modules 'org-mac-iCal)
(add-to-list 'auto-mode-alist '("\\.org\\'". org-mode))
(add-to-list 'auto-mode-alist '("\\.og\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
1(put 'upcase-region 'disabled nil)
;;FIX:测试并发布BLOG文章

(setq org-publish-project-alist
     '(("org"
;	 :components ("client_task" "client_task")
	 :base-directory "~/Documents/org/sources/"
	 :publishing-directory "~/Documents/org/public_html/"
	 :publishing-function org-html-publish-to-html
	 :section-numbers nil
	 :html-head "<link rel=\"stylesheet\" href=\"http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css\" />
<link rel=\"stylesheet\" href=\"http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css\"/>"
	 :html-head-include-scripts "<script src=\"http://cdn.bootcss.com/jquery/1.11.3/jquery.min.js\"/>
<script src=\"http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js\"/>"
	 :table-of-contents t
	 :style-include-default nil
	 :org-html-table-default-attributes nil
	 :language "zh"
	 :org-html-container-element nil
;;	 ("client_task"
;;	  :base-directory "~/Documents/org/sources/task/"
;;	  :publishing-directory "/Volumes/Public/public_html/"
;;	  :recursive t
;;	  :publishing-function org-publish-attachment
;;	  )
;;	 :org-html-table-caption-above nil
;;	 :org-html-table-default-attributes nil
;;	 :html-table-attributes nil
	 ;;:html-head-default-style nil
	 ;;:html-table-row-tags ""
	 
	 )))

;;这里是发布到公司的服务器上
(setq org-publish-project-alist
    '(("client_task"
	 :base-directory "~/Documents/org/sources/"
	 :publishing-directory "/Volumes/Public/public_html/"
	 :publishing-function org-html-publish-to-html
	 :section-numbers nil
	 :html-head "<link rel=\"stylesheet\" href=\"http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap.min.css\" />
<link rel=\"stylesheet\" href=\"http://cdn.bootcss.com/bootstrap/3.3.5/css/bootstrap-theme.min.css\"/>"
	 :html-head-include-scripts "<script src=\"http://cdn.bootcss.com/jquery/1.11.3/jquery.min.js\"/>
<script src=\"http://cdn.bootcss.com/bootstrap/3.3.5/js/bootstrap.min.js\"/>"
	 :table-of-contents t
	 :style-include-default nil
	 :org-html-table-default-attributes nil
	 :language "zh"
;;	 :org-html-table-caption-above nil
;;	 :org-html-table-default-attributes nil
;;	 :html-table-attributes nil
;;	 :html-head-default-style nil
;;	 :html-table-row-tags ""
	 )))
;;显示任务完成时间
(setq org-log-done 'time)
;;(setq org-log-done 'note)
;;在周列表中显示任务
(setq org-agenda-include-diary t)
;;设置任务文件列表
;;(setq org-agenda-files (quote ("~/Task/Inbox"
;;			       "~/Task/NextAction"
;;			       "~/Task/Project"
;;			       )))
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
(provide 'init-org-mode)

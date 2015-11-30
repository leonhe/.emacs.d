;;org-mode initilze

(add-to-list 'load-path "~/.emacs.d/mode/org-mode/lisp")
(add-to-list 'load-path "~/.emacs.d/mode/org-mode/contrib/lisp" t)
(add-to-list 'auto-mode-alist '("\\.org\\'". org-mode))
(add-to-list 'auto-mode-alist '("\\.og\\'" . org-mode))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(put 'upcase-region 'disabled nil)
;;FIX:测试并发布BLOG文章
;;(setq org-publish-project-alist
;;     '(("orgfiles"
;;	 :base-directory "~/Documents/blog/public/"
;;	 :publishing-directory "~/Documents/public_html"
;;	 :publishing-function org-html-publish-to-html
;;	 :section-numbers nil
;;	 :with-toc nil
;;	 :html-head ""
;;	 )))
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
(provide 'init-org-mode)

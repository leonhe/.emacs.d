;; init-org-mode.el --- org mode configure
;;; Commentary:
;;; Code:

(require 'org-pomodoro)
(require 'ox-md)
(require 'ox-publish)
(require  'org-mime)
(require 'ox-beamer)
(require 'htmlize)
(require 'org-bullets)

(setq org-agenda-archives-mode t)
(setq org-directory "~/Note/")
(setq org-default-notes-file "~/Note/task/inbox.org")
(setq org-priority-faces '((?A . (:foreground "red" :weight 'bold))
			   (?B . (:foreground "yellow"))
			   (?C . (:foreground "green"))))
;;setting agenda directioy
(setq org-agenda-files
      '("~/Note/task/")
      )
;;bind key
(define-key global-map "\C-coc" 'org-capture)
(define-key global-map "\C-coa" 'org-agenda)
(define-key global-map "\C-cob" 'org-iswitchb)
(define-key global-map "\C-cot" 'org-tags-view)

(setq org-mobile-inbox-for-pull "~/Note/task/inbox.org")
(setq org-mobile-files (list "~/Note/task/inbox.org"
			     "~/Note/task/task.org"
			     "~/Note/task/project.org"
			     "~/Note/task/book.org"
			     "~/Note/task/house.org"
			     ))
(defvar org-mobile-directory "/ssh:root@leonhe.me:/var/www/webdav/Org/")
(setq org-src-fontify-natively t)
(org-indent-mode t)
(setq org-log-done 'time)   ;;显示任务完成时间
(setq org-refile-use-outline-path t)
(defvar org-agenda-include-diary t)
 ;;setting workflow state
  (setq org-todo-keywords
           '((sequence "TODO(t)" "|" "NEXT(n)" "|"  "DONE(d)")
             (sequence "HOLD(h)" "|" "WAITING(w)" "|" "CANCELED(c)")
            ))

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
(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))
(defvar org-agenda-exporter-settings
      '(
	(ps-number-of-columns 2)
	(ps-landscape-mode t)
	(org-agenda-add-entry-text-maxlines 5)
	(org-clock-out-remove-zero-time-clocks t)
	(org-agenda-repeating-timestamp-show-all t)
	))

  (setq org-refile-targets (quote (("inbox.org" :maxlevel . 1)
				 ("task.org" :maxlevel . 2)
				 ("project.org" :maxlevel . 2))))
  ;;capture
(defvar org-capture-templates
      '(("t" "TODO" entry (file+headline "task/inbox.org" "Inbox")
	 "* TODO %?\n  %i\n")
	("n" "Day Note" entry (file+datetree "~/Note/wiki/personal/day.org")
	 "* %?\n Entered on %U\n  %i\n")
	("b" "Inbox Note" entry (file+datetree "task/inbox.org")
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
  ;;(setq org-html-use-infojs t)
  (setq org-publish-project-alist
	'(
	  ("posts"
	   :base-directory "~/Documents/org/Posts/"
	   :base-extension "org"
	   :recursive t
	   ;;:publishing-directory "~/Note/blog/static/notes/"
	   :publishing-directory "~/Documents/publics/"
	   ;;:publishing-directory "/ssh:root@leonhe.me:/var/www/html/notes/"
	   :publishing-function org-html-publish-to-html
	   :language "zh-CN"
	   :auto-preamble t
	   :auto-postamble t	   
	   :html-head "\<link rel=\"stylesheet\" href=\"../static/css\/notebook.css\">"
	   :author "Leon He"
	   :email "leonhe86@gmail.com"	 
	   :with-title t
	   :with-creator t
	   :timestamp nil
	   :export-creator-info nil
	   :html-validation-link nil
	   :html-link-home "../index.html"
	   :html-link-up "../posts.html"
	   :section-numbers nil
	   :html-preamble t
	   :htmlized-source t
	   :auto-sitemap t
	   ;;:sitemap-function org-publish-sitemap-default
	   ;;:sitemap-sort-folders last
	   ;; :sitemap-date-format "%Y-%m-%d"
	   ;; :sitemap-file-entry-format "%d %t"
	   :sitemap-title "Posts"
	   :sitemap-filename "../posts.org"
	   :sitemap-style tree
	   ;;:sitemap-sort-files anti-chronologically
	   :html-postamble "<div id=\"disqus_thread\"></div>

<script>

/**
*  RECOMMENDED CONFIGURATION VARIABLES: EDIT AND UNCOMMENT THE SECTION BELOW TO INSERT DYNAMIC VALUES FROM YOUR PLATFORM OR CMS.
*  LEARN WHY DEFINING THESE VARIABLES IS IMPORTANT: https://disqus.com/admin/universalcode/#configuration-variables*/
/*
var disqus_config = function () {
this.page.url = PAGE_URL;  // Replace PAGE_URL with your page's canonical URL variable
this.page.identifier = PAGE_IDENTIFIER; // Replace PAGE_IDENTIFIER with your page's unique identifier variable
};
*/
(function() { // DON'T EDIT BELOW THIS LINE
var d = document, s = d.createElement('script');
s.src = 'https://iyuanfei.disqus.com/embed.js';
s.setAttribute('data-timestamp', +new Date());
(d.head || d.body).appendChild(s);
})();
</script>
<noscript>Please enable JavaScript to view the <a href=\"https://disqus.com/?ref_noscript\">comments powered by Disqus.</a></noscript>
 <p class=\"author\">Author: %a (%e)</p>
<p class=\"date\">Last Updated %d . Created by %c</p><p class=\"copyright\">Copyright (c) 2012 - 2018, Leon He; all rights reserved.</p>"
	   )
	("note"
	 :base-directory "~/Documents/org/"
	 :base-extension "org"
	 :publishing-directory "~/Documents/publics/"
	 ;;:publishing-directory "/ssh:root@leonhe.me:/var/www/html/notes/"
	 :publishing-function org-html-publish-to-html
	 :language "zh-CN"
	 :auto-preamble t
	 :auto-postamble t
	 :html-head "\<link rel=\"stylesheet\" href=\"static/css\/notebook.css\">"
	 :html-postamble "<p class=\"copyright\">Copyright (c) 2012 - 2018, Leon He; all rights reserved.</p>"
	 :author "Leon He"
	 :email "leonhe86@gmail.com"
	 :with-title t
	 :html-validation-link nil
	 :html-link-home "index.html"
	 :html-link-up "index.html"
	 )

	("res"
	 :base-directory  "~/Documents/org/static/"
	 :base-extension "jpg\\|gif\\|png\\|js\\|css\\|svg\\|ttf\\|woff\\|ico\\|pdf\\|"
	 :recursive t
	 ;;:publishing-directory "/ssh:root@leonhe.me:/var/www/html/notes/static/"
	 ;;:publishing-directory "/ssh:pi@192.168.1.12#1383:/var/www/html/"
	 ;;:publishing-directory "~/Note/blog/static/notes/static/"
	 :publishing-directory "~/Documents/publics/static/"
	 :publishing-function org-publish-attachment)
	("MyNote" :components ("posts" "note" "res"))
	))
(defun eiio/publish()
  (interactive)
  ;;(org-publish-project "MyNote")
  ;;(easy-hugo-publish)
  (let ((multi-term-program "rsync-copy ~/Documents/publics/* root@leonhe.me:/var/www/html/"))
                   (multi-term))
  )




(provide 'init-org-mode)
;;; init-org-mode.el ends here

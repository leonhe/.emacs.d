;;; init-org-mode.el --- org mode configure
;;; Commentary:
;;; Code:
;;(add-to-list 'org-modules 'org-mac-iCal)
(add-to-list 'auto-mode-alist '("\\.org\\'". org-mode))
(add-to-list 'auto-mode-alist '("\\.og\\'" . org-mode))
(setq org-directory "~/Note/")
(require 'org-bullets)
(require 'ox-publish)
(require 'ox-md)
(require 'pomidor)
(require 'org-pomodoro)

;;setting org directory
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(defun eiio-init-orgmode()
  "initilze org-mode"
  ;;(message "init org-mode")
  (setq truncate-lines nil);;org 支持自动换行
  (org-bullets-mode 1)
  (org-indent-mode t)
  (setq org-log-done nil)   ;;显示任务完成时间

  ;;ical
  (setq org-agenda-include-diary t)
  ;;(setq org-agenda-custom-commands
	;; '(("I" "Import diary from iCal" agenda ""
	;;    ((org-agenda-mode-hook
	;;      (lambda ()
	;;        (org-mac-iCal)))))))
 ;;setting workflow state
  (setq org-todo-keywords
           '((sequence "TODO(t)" "|" "NEXT(n)" "|"  "DONE(d)")
             (sequence "HOLD(h)" "|" "WAITING(w)")
             (sequence "|" "CANCELED (c)")))
  )
(setq org-refile-targets (quote (("inbox.org" :maxlevel . 1)
				 ("task.org" :maxlevel . 2)
				 ("project.org" :maxlevel . 3)
				 )))
(setq org-refile-use-outline-path t)
;;设置关键字颜色
(setq org-todo-keyword-faces
      (quote (("TODO" :foreground "red" :weight bold)
	      ("NEXT" :foreground "blue" :weight bold)
	      ("DONE" :foreground "forest green" :weight bold)
	      ("WAITING" :foreground "orange" :weight bold)
	      ("HOLD" :foreground "magenta" :weight bold)
	      ("CANCELLED" :foreground "gray" :weight bold)
	      )))

(setq org-todo-state-tags-triggers
      (quote (("CANCELLED" ("CANCELLED" . t))
              ("WAITING" ("WAITING" . t))
              ("HOLD" ("WAITING") ("HOLD" . t))
              (done ("WAITING") ("HOLD"))
              ("TODO" ("WAITING") ("CANCELLED") ("HOLD"))
              ("NEXT" ("WAITING") ("CANCELLED") ("HOLD"))
              ("DONE" ("WAITING") ("CANCELLED") ("HOLD")))))


(add-hook 'org-mode-hook 'eiio-init-orgmode)

  (setq org-agenda-include-diary t)
  (setq org-agenda-compact-blocks t)
(setq org-clock-persist 'history)
     (org-clock-persistence-insinuate)
  (setq org-agenda-custom-commands
	'(
	  ("I" "Import diary from iCal" agenda ""
	   ((org-agenda-mode-hook
	     (lambda ()
	       (org-mac-iCal)))))))



(setq org-refile-targets (quote (("inbox.org" :maxlevel . 1)
				 ("somemaybe.org" :maxlevel . 2)
				 ("task.org" :maxlevel . 2))))

(defun my-after-load-org ()
  (add-to-list 'org-modules 'org-mac-iCal))
(eval-after-load "org" '(my-after-load-org))
(setq org-clock-out-remove-zero-time-clocks t)

;;capture
(setq org-capture-templates
      '(("t" "TODO" entry (file+headline "todo/inbox.org" "Inbox")
	 "* TODO %?\n  %i\n")
	("n" "Day Note" entry (file+datetree "note/day.org")
	 "* %?\n Entered on %U\n  %i\n")
	("b" "Inbox Note" entry (file+datetree "note/inbox.org")
	 "* %?\n Entered on %U\n  %i\n")
	))


;;(setq org-default-notes-file (concat org-directory "/inbox.org"))
(define-key global-map "\C-cc" 'org-capture)
(setq org-html-doctype "xhtml5")


(setq org-publish-project-alist
           '(("public"
              :base-directory  "~/Note/public"
              :publishing-directory  "blog/content/"
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


(add-to-list 'org-modules 'org-timer)
(setq org-timer-default-timer 25)
(add-hook 'org-clock-in-hook (lambda ()
      (if (not org-timer-current-timer) 
	  (org-timer-set-timer '(16)))))

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
	     '("hugo" "#+STARTUP: showall \n#+TITLE:  \n#+OPTIONS: toc:nil\n#+BEGIN_HTML\n --- \n title:\n draft:true\n date:\n categories:\n tags:\n ---\n#+END_HTML \n"))

(setq-default org-display-custom-times t)
(setq org-time-stamp-custom-formats '("<%Y-%m-%d>" . "<%Y-%m-%d %H:%M>"))
;;org-mode&omnifocus rsync task item
(setq rsync_file_path "/Users/yuanfei/Documents/Ominfoucs.scpt")
(setq todo-file-path (concat org-directory "todo.org"))
(defun eiio-org-omnifocus-getResult(value)
  "return excute osascript command result json string"
  (interactive)
  (let((excute-command-str (format "osascript %s" rsync_file_path))
       )
    ;;excute command
    (shell-command-to-string excute-command-str))
)

(provide 'init-org-mode)
;;; init-org-mode.el ends here

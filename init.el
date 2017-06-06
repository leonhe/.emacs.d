;;; init-package.el --- init file
;;; Commentary:
;; This is init file
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
;;; Code:

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.

;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.


;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)
(add-to-list 'load-path "~/.emacs.d/lisp")
(add-to-list 'load-path "~/.emacs.d/local")

(defun eiio/init()
  (require 'init-package) ;;插件包处理
  (require 'init-base);;设置基础的配置
  (require 'init-keyboard);;初始化键盘快捷键o配置
  (require 'init-theme);;主题
  (require 'init-lua);;加载lua mode
  (require 'init-markdown);;初始化markdown mode
  (require 'init-org-mode);;org-mode
  (require 'init-company-mode);;初始化代码自动提示插件
  (require 'init-helm)
  (require 'init-magit)
  (require 'init-markdown)
  (require 'init-flycheck)
  (require 'init-ggtags)
  (require 'go-mode-load)
  (require 'init-php)
  (require 'init-emms)
  (require 'lua-gud)
  )
(eiio/init)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("ed317c0a3387be628a48c4bbdb316b4fa645a414838149069210b66dd521733f" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "a632c5ce9bd5bcdbb7e22bf278d802711074413fd5f681f39f21d340064ff292" "ace9f12e0c00f983068910d9025eefeb5ea7a711e774ee8bb2af5f7376018ad2" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "f78de13274781fbb6b01afd43327a4535438ebaeec91d93ebdbba1e3fba34d3c" "1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" "938d8c186c4cb9ec4a8d8bc159285e0d0f07bad46edf20aa469a89d0d2a586ea" default)))
 '(hugo-sites-dir (expand-file-name "~/Note/blog/"))
 '(org-agenda-files
   (quote
    ("~/Note/todo/project.org" "~/Note/todo/task.org" "~/Note/todo/inbox.org")))

 '(package-selected-packages
   (quote
    (helm-projectile magit-gitflow evil-multiedit ctags ht org-remember dashboard emacs-cl smart-mode-line-powerline-theme monokai-theme ample-zen-theme ample-theme seti-theme hugo org-pomodoro org-bullets edbi-minor-mode emms neotree php-mode helm-mt multi-term go-mode flycheck-color-mode-line flycheck-tip xml-rpc undo-tree sudo-edit powerline org-page moe-theme markdown-mode magit helm-gtags goto-chg ggtags flymake-lua flycheck company-lua blog-admin ace-window)))
 '(send-mail-function (quote smtpmail-send-it))
 '(smtpmail-smtp-server "smtp.exmail.qq.com")
 '(smtpmail-smtp-service 25))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-color-mode-line-error-face ((t (:inherit flycheck-fringe-error :foreground "red" :weight normal)))))


(provide 'init)
;;; init ends here

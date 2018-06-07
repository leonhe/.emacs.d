;;; init-package.el --- init file
;;; Commentary:
;; This is init file
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these expla
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
(add-to-list 'load-path "~/.emacs.d/org/lisp")
(add-to-list 'load-path "~/.emacs.d/org/contrib/lisp" t)

(defun eiio/init()
  (require 'init-package) ;;插件包处理
  (require 'init-base);;设置基础的配置
  (require 'init-keyboard);;初始化键盘快捷键o配置
  (require 'init-theme);;主题
;;  (require 'init-evil)
  (require 'init-lua);;加载lua mode
  (require 'init-js);;load javascript
  (require 'init-markdown);;初始化markdown mode
  (require 'init-org-mode);;org-mode
  (require 'init-company-mode);;初始化代码自动提示插件
  (require 'init-helm)
  (require 'init-magit)
  (require 'init-blog)
  (require 'init-markdown)
  (require 'init-flycheck)
  (require 'init-ggtags)
  (require 'go-mode-load)
  (require 'init-php)
  (require 'init-emms)
  (require 'lua-gud)
  (require 'init-cocos)
  )
(eiio/init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("7bc22d06a880362ab13cb3518b2f824cc6ed9bcbbb7647d71655b84b2d5e794d" "523ee08ddb15517ae79633fd73976cb213ffff13055186d510a6ded83ec280df" "41c926d688a69c7d3c7d2eeb54b2ea3c32c49c058004483f646c1d7d1f7bf6ac" "d4518dd752257941436e648c63123d7859875772dccc1bfbb65755822f8d1586" "0a4d0f951ce441b593a8ebeb63b2f36c93db6051a993a9b8f4774feacb620b2e" "6de7c03d614033c0403657409313d5f01202361e35490a3404e33e46663c2596" "787de1a1dfc88b90555f14e500627fe2c0c8abf39169a0ee360cd236f44189b0" "ed317c0a3387be628a48c4bbdb316b4fa645a414838149069210b66dd521733f" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "a632c5ce9bd5bcdbb7e22bf278d802711074413fd5f681f39f21d340064ff292" "ace9f12e0c00f983068910d9025eefeb5ea7a711e774ee8bb2af5f7376018ad2" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "f78de13274781fbb6b01afd43327a4535438ebaeec91d93ebdbba1e3fba34d3c" "1db337246ebc9c083be0d728f8d20913a0f46edc0a00277746ba411c149d7fe5" "938d8c186c4cb9ec4a8d8bc159285e0d0f07bad46edf20aa469a89d0d2a586ea" default)))
 '(helm-gtags-auto-update t)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-path-style (quote relative))
 '(hugo-sites-dir (expand-file-name "~/Note/blog/"))
 '(org-agenda-files (quote ("~/Org/task/inbox.org" "~/Org/task/project.org")))
 '(org-publish-sitemap-sort-folders (quote first))
 '(package-selected-packages
   (quote
    (ag js2-refactor org-redmine web-mode typescript tide magit-svn ac-js2-mode ac-js2diminish diminish-undo company-tern tide org ox-reveal psvn expand-region typescript-mode typescript magit-svn htmlize indium js2-mode js2 douban-fm web dummy-h-mode objc-font-lock dumb-jump helm-company osx-dictionary google-translate gtags auto-complete-clang-async auto-complete-clang auto-complete-c-headers auto-complete realgud function-args semantic-ia flycheck-irony irony use-package yasnippet pyim zerodark-theme org-mime evil-mu4e evil easy-hugo which-key mobdebug-mode helm-ag helm-projectile magit-gitflow evil-multiedit ctags ht org-remember dashboard emacs-cl smart-mode-line-powerline-theme monokai-theme ample-zen-theme ample-theme seti-theme hugo org-pomodoro org-bullets edbi-minor-mode emms neotree php-mode helm-mt multi-term go-mode flycheck-color-mode-line flycheck-tip xml-rpc undo-tree sudo-edit powerline org-page moe-theme markdown-mode magit helm-gtags goto-chg ggtags flymake-lua flycheck company-lua blog-admin ace-window))))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flycheck-color-mode-line-error-face ((t (:inherit flycheck-fringe-error :foreground "red" :weight normal)))))


(provide 'init)
;;; init ends here

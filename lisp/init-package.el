;;; init-package.el --- init package manager
;; Author: Leon He<leonhe86@gmail.com>
;; Version: 0.1

;;; Commentary:
;; This is package tool init

;;; Code:
(require 'package) ;; You might already have this line
(setq package-archives '(
			 ("melpa" . "http://elpa.emacs-china.org/melpa/")
			 ("marmalade" . "http://marmalade-repo.org/packages/")
			 ("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;; 定义require-package函数
(defun require-package (package &optional min-version no-refresh)
    "Install given PACKAGE, optionally requiring MIN-VERSION.
If NO-REFRESH is non-nil, the available package lists will not be
re-downloaded in order to locate PACKAGE."
    (if (package-installed-p package min-version)
	t
      (if (or (assoc package package-archive-contents) no-refresh)
	  (package-install package)
	(progn
	  (package-refresh-contents)
	          (require-package package min-version t)))))

;;neotree
(require-package 'neotree)
(require-package 'go-mode)
(require-package 'sudo-edit);;sudo编辑
(require-package 'multi-term)
(require-package 'company)
(require-package 'flycheck)
(require-package 'flycheck-tip)
(require-package 'flycheck-color-mode-line)
(require-package 'ggtags)
(require-package 'projectile)
(require-package 'helm)
(require-package 'helm-gtags)
(require-package 'helm-mt)
(require-package 'helm-ag)
(require-package 'helm-projectile)
;;lua
(require-package 'lua-mode)
(require-package 'flymake-lua)
(require-package 'company-lua)
(require-package 'mobdebug-mode)
(require-package 'magit)
(require-package 'markdown-mode)
(require-package 'org)
(require-package 'php-mode)
(require-package 'ht)
;;music
(require-package 'emms)
(require-package 'org-bullets)
(require-package 'org-pomodoro)
(require-package 'org-mime)
;;(require-package 'pomidor)
(require-package 'dashboard)
(require-package 'powerline)
(require-package 'ctags)
(require-package 'realgud)
(require-package 'which-key)
(require-package 'easy-hugo)
(require-package 'avy)
(require-package 'ample-zen-theme)
(require-package 'zerodark-theme)
(require-package 'pyim)
(require-package 'yasnippet)
(require-package 'use-package)
;;(require-package 'evil)
(provide 'init-package)
;;; init-package ends here

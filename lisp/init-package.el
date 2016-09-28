;;; init-package.el --- init package manager
;; Author: Leon He<leonhe86@gmail.com>
;; Version: 0.1

;;; Commentary:
;; This is package tool init

;;; Code:
(require 'package) ;; You might already have this line
(when (< emacs-major-version 24)
   ;; For important compatibility libraries like cl-lib
  (require 'package)
  (add-to-list 'package-archives
	       '(("gnu" . "http://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
		 ("gnu" . "http://elpa.gnu.org/packages/")
		 ("melpa" . "http://melpa.org/packages/")
		 ("org" . "http://orgmode.org/elpa/")))
  )
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

(global-set-key [f8] 'neotree-toggle)
(provide 'init-package)
;;; init-package ends here

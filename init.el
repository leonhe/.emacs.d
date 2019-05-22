;;; Code:
(require 'package) ;; You might already have this line
(setq package-archives '(
			 ("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                        ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;;			 ("melpa" . "http://elpa.emacs-china.org/melpa/")
			 ;; ("marmalade" . "http://marmalade-repo.org/packages/")
;;			  ("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ;; ("melpa" . "https://melpa.org/packages/")
			 ))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)

;;打开配置文件
(global-set-key (kbd "<f2>") (lambda () (interactive) (open-init-file "~/.emacs.d/init.el")))

;;add init file reload
(defun eiio/load_init_file()
  (interactive)
  (load-file "~/.emacs.d/init.el")
)
(global-set-key (kbd "<f1>") 'eiio/load_init_file)



;; init.el
;; emacs初始化文件

(add-to-list 'load-path "~/.emacs.d/lisp")
(set-keyboard-coding-system 'utf-8)

(require 'init-base);;设置基础的配置
(require 'init-keyboard);;初始化键盘快捷键o配置
(require 'init-lua);;加载lua mode
(require 'init-markdown);;初始化markdown mode
(require 'init-org-mode);;org-mode
;;(require 'init-company-mode);;初始化代码自动提示插件
(require 'go-mode-load);;Go语言
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "http://melpa.milkbox.net/packages/") t)

;;(add-hook 'c-mode-common-hook
;;	  (lambda ()
;;	    (when (derived-mode-p 'c-mode 'c++-mode 'java-mode 'asm-mode)
;;	      (ggtags-mode 1))))


;;(add-hook 'dired-mode-hook 'ggtags-mode)
(provide 'init)

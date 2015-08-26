;; init.el
;; emacs初始化文件

(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'init-base);;设置基础的配置
(require 'init-keyboard);;初始化键盘快捷键o配置
(require 'init-lua);;加载lua mode
(require 'init-markdown);;初始化markdown mode
(require 'init-org-mode);;org-mode
(require 'init-company-mode);;初始化代码自动提示插件

(provide 'init)

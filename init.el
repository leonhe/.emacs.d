;; init.el
;; emacs初始化文件

(add-to-list 'load-path "~/.emacs.d/lisp")

(require 'init-lua);;加载lua mode
(require 'init-markdown);;初始化markdown mode
(provide 'init)

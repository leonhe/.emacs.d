;;ggtag setting file
;;c++编辑器
(require-package 'ggtags)
(require 'ggtags)
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode  'lua-mode)
	      (ggtags-mode 1))))
(provide 'init-ggtags)

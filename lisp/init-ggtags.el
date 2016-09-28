;;ggtag setting file
;;c++编辑器
(require 'ggtags)
(add-hook 'c-mode-common-hook
	  (lambda ()
	    (when (derived-mode-p 'c-mode 'c++-mode  'lua-mode)
	      (ggtags-mode 1)
	      )))

;;keybinad
(global-set-key (kbd "C-c M-x") 'ggtags-kill-window)
(provide 'init-ggtags)

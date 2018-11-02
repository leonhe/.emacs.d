;;; init-cocos.el --- cocos2d-x c++ develop configurations
;;; Commentary:
;;; Code:
;;(global-ede-mode t)

(add-hook 'c++-mode-hook (lambda()
			   (semantic-mode t)
			   (setq flycheck-clang-language-standard "c++11" )
			   (ivy-mode t)
			   (function-args-mode t)
			   ))


(provide 'init-cocos)
;;; init-cocos.el ends here

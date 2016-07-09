;; init.el
(add-to-list 'load-path "~/.emacs.d/lisp")
;;(add-hook 'after-init-hook #'(lambda) () (load "")))
(require 'init-package);;插件包处理
(require 'init-base);;设置基础的配置
(require 'init-keyboard);;初始化键盘快捷键o配置
(require 'init-lua);;加载lua mode
(require 'init-markdown);;初始化markdown mode
(require 'init-org-mode);;org-mode
(require 'init-company-mode);;初始化代码自动提示插件
(require 'init-helm)
(require 'init-magit)
(require 'init-markdown)
(require 'init-evil)
(require 'init-flycheck)
(provide 'init)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-enabled-themes (quote (manoj-dark))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; init.el
;; emacs初始化文件
(add-to-list 'load-path "~/.emacs.d/lisp")
(set-keyboard-coding-system 'utf-8)
;; Use C-tab to autocomplete the files and directories
;; based on the two commands `comint-dynamic-complete-filename`
;; and `comint-dynamic-list-filename-completions`
(defun atfd ()
  (interactive)
  (comint-dynamic-list-filename-completions)
  (comint-dynamic-complete-as-filename))
(global-set-key ( kbd "\C-c k" ) 'atfd)

(require 'init-base);;设置基础的配置
(require 'init-keyboard);;初始化键盘快捷键o配置
(require 'init-lua);;加载lua mode
(require 'init-markdown);;初始化markdown mode
(require 'init-org-mode);;org-mode
(require 'init-company-mode);;初始化代码自动提示插件
(require 'init-helm)
;;pakage
(require 'package) ;; You might already have this line
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize) ;; You might already have this line
;;(global-commpany-mode)
;;(add-hook 'after-init-hook 'global-commpany-mode)
(provide 'init)
;;(put 'downcase-region 'disabled nil)

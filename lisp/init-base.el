;;; init-base.el --- base file
;;; Commentary:
;; 基础设置
;;; Code:
(tool-bar-mode 0)  
(menu-bar-mode 0)  
;;(scroll-bar-mode 0)  
(tool-bar-mode nil);;关闭顶部菜单栏
(display-time-mode 1);;开启时间显示
;;时间使用24小时制
(setq display-time-24hr-format t)
;;时间显示包括日期和具体时间
(setq display-time-day-and-date t)
;;时间栏旁边启用邮件设置
(setq display-time-use-mail-icon t)
;;时间的变化频率
(setq display-time-interval 1)
(setq enable-recursive-minibuffers t)
;;显示时间的格式
(setq display-time-format "%Y/%m/%d %H:%M:%S %A")
(set-language-environment "UTF-8")
(set-keyboard-coding-system 'utf-8);;系统编码为UTF-8
(global-linum-mode) ;;开启全局文件行数显示
(global-font-lock-mode 1);;开启语法高亮
(setq column-number-mode 1);;开启编辑模式行数和列数显示
(setq fill-column 80);;显示行的最多字数
(setq make-backup-files nil);;关闭自动备份文件
(setq scroll-bar-columns 1)
;;打开最近文档列表
(require 'recentf)
(recentf-mode t)
(require 'project)
;; Use C-tab to autocomplete the files and directories
;; based on the two commands `comint-dynamic-complete-filename`
;; and `comint-dynamic-list-filename-completions`
(defun atfd ()
  (interactive)
  (comint-dynamic-list-filename-completions)
  (comint-dynamic-complete-as-filename))
(global-set-key ( kbd "\C-c k" ) 'atfd)
(setq auto-save-default nil) ;;关闭自动保存文件
(global-auto-revert-mode 1);;加载外部修改过的文件
(menu-bar-mode -99);;hide window top menu
(setq-default c-basic-offset 4);;indentation
(prefer-coding-system 'chinese-gbk)
(prefer-coding-system 'utf-8)
;;窗口管理
(require-package 'ace-window)
(require 'ace-window)
;;(ace-window-display-mode t)
(setq aw-dispatch-always  t)
(global-set-key (kbd "M-p") 'ace-window)
(setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
(defvar aw-dispatch-alist
  '((?x aw-delete-window " Ace - Delete Window")
    (?m aw-swap-window " Ace - Swap Window")
    (?n aw-flip-window)
    (?v aw-split-window-vert " Ace - Split Vert Window")
    (?b aw-split-window-horz " Ace - Split Horz Window")
    (?i delete-other-windows " Ace - Maximize Window")
    (?o delete-other-windows))
  "List of actions for `aw-dispatch-default'.")
;;(global-set-key (kbd "C-c C-w") 'aw-window-list)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
;;终端
(require 'multi-term)
(setq multi-term-program "/bin/zsh")
(setenv "PATH" (concat (getenv "PATH") ":/bin/zsh"))
(setq exec-path (append exec-path '("/bin/zsh")))
;;tramp
(require 'tramp)
(setq tramp-default-user "root")
(setq tramp-default-method "ssh")

;;program
(which-function-mode t)
(setenv "GPATH" "/usr/local/bin/")
(provide 'init-base)
;;; init-base.el ends here

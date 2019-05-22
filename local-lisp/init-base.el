;;; init-base.el --- s                               -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Yuanfei He

;; Author: Yuanfei He;;; init-base.el --- base file <hi@leonhe.me>
;; Keywords: Basemode ;;;
;;; Commentary:
;; 基础设置
;;; Code:

(setq mac-pass-command-to-system nil)
(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)
(global-font-lock-mode t)
(tool-bar-mode 0)
(menu-bar-mode 0)
(global-hl-line-mode t)
(electric-indent-mode t)
;;系统本身内置的智能自动补全括号
(electric-pair-mode t)
(when (display-graphic-p)
  (scroll-bar-mode -1)
  )
(tool-bar-mode nil);;关闭顶部菜单栏
(display-time-mode nil);;开启时间显示
;;时间使用24小时制
(defvar display-time-24hr-format t)
;;时间显示包括日期和具体时间
(defvar display-time-day-and-date t)
;;时间栏旁边启用邮件设置
(defvar qdisplay-time-use-mail-icon t)
;;时间的变化频率
(defvar display-time-interval 1)
(setq enable-recursive-minibuffers t)
;;显示时间的格式
(defvar display-time-format "%Y/%m/%d %H:%M:%S %A")
(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8);;系统编码为UTF-8
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8-unix)
(set-file-name-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8-unix)
(set-next-selection-coding-system 'utf-8-unix)
(set-selection-coding-system 'utf-8-unix)
(set-terminal-coding-system 'utf-8-unix)
(setq locale-coding-system 'utf-8)
(prefer-coding-system 'utf-8)

(global-linum-mode) ;;开启全局文件行数显示
(global-font-lock-mode 1);;开启语法高亮
(global-auto-revert-mode 1);;auto revert buff
(setq column-number-mode 1);;开启编辑模式行数和列数显示
(setq fill-column 80);;显示行的最多字数
(setq make-backup-files nil);;关闭自动备份文件
(defvar scroll-bar-columns 1)

;;打开最近文档列表
(require 'recentf)
(recentf-mode t)

(require 'project)
;; Use C-tab to autocomplete the files and directories
;; based on the two commands `comint-dynamic-complete-filename`
;; and `comint-dynamic-list-filename-completions`
(defun atfd ()
  ";; ."
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
(setq url-gateway-method 'socks)
(defvar socks-server '("Default server" "127.0.0.1" 1086 5))


;;窗口;; 管理
;; (require-package 'ace-window)
;; (require 'ace-window)
;; (ace-window-display-mode t)
;; (setq aw-dispatch-always  t)
;; (global-set-key (kbd "C-x w") 'ace-window)
;; (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
;; (defvar aw-dispatch-alist
;;   '((?x aw-delete-window " Ace - Delete Window")
;;     (?m aw-swap-window " Ace - Swap Window")
;;     (?n aw-flip-window)
;;     (?v aw-split-window-vert " Ace - Split Vert Window")
;;     (?b aw-split-window-horz " Ace - Split Horz Window")
;;     (?i delete-other-windows " Ace - Maximize Window"))
;;   "List of actions for `aw-dispatch-default'.")
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)

;;终端
(setq shell-file-name "/bin/zsh")
;; (require 'multi-term)
;; (setq multi-term-program "/bin/zsh")
(setenv "PATH" (concat (getenv "PATH") ":/bin/zsh:/usr/local/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))
(add-hook 'term-mode-hook (lambda ()
			    (setq show-trailing-whitespace nil)
			    (linum-mode -1)
			    (define-key term-raw-map (kbd "C-y") 'term-paste)
			    ))
;;tramp
(require 'tramp)
(setq tramp-default-user "root")
(setq tramp-default-method "ssh")


;;program
(which-function-mode t)
(setenv "GPATH" "/usr/local/bin/")
;;project manage plugin
;; (projectile-mode t)
;; (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
;; (projectile-register-project-type 'npm '("package.json")
;;                   :compile "npm install"
;;                   :test "npm test"
;;                   :run "npm start"
;;                   :test-suffix ".spec")
;; (projectile-register-project-type 'tide '("package.json")
;;                   :compile "npm install"
;;                   :test "npm test"
;;                   :run "npm start"
;;                   :test-suffix ".spec")

(require 'ansi-color)
(defun colorize-compilation-buffer ()
  (toggle-read-only)
  (ansi-color-apply-on-region compilation-filter-start (point))
  (toggle-read-only))
(add-hook 'compilation-filter-hook 'colorize-compilation-buffer)


(defun eiio/win()
  ";;initilze windows."
  (interactive)
  (fullscreen)
  (split-window-right)
  (split-window-below)
  )

(setenv "MAILHOST" "pop.exmail.qq.com")
;; (defvar rmail-primary-inbox-list '("po:leon@hii8.com")
;;       rmail-pop-password-required t)
(setq mail-user-agent 'message-user-agent)
(load-library "smtpmail")
(setq user-mail-address "leon@hii8.com"
      user-full-name "Yuanfei He"
      )
(defvar smtpmail-smtp-server "smtp.exmail.qq.com")
(defvar smtpmail-smtp-user "leon@hii8.com")
(defvar smtpmail-smtp-service 465)
(defvar smtpmail-stream-type 'ssl)
(setq send-mail-function    'smtpmail-send-it)
(defvar smtpmail-debug-info t)
(defvar message-default-mail-headers "Cc: \n")

(auto-fill-mode t)
(setq auto-fill-function t)
(toggle-truncate-lines t)



(add-hook 'after-init-hook 'global-company-mode)

(defun timestamp ()
   (interactive)
   (insert (format-time-string "%Y-%m-%d %H:%M:%S")))

;; Show the current function name in the header line                                
(setq which-func-unknown "n/a")
(which-function-mode 1)                                     
(setq-default header-line-format                                                    
              '((which-func-mode ("" which-func-format " "))))                      
(setq mode-line-misc-info                                                           
      ;; We remove Which Function Mode from the mode line, because it's mostly
      ;; invisible here anyway.                                               
      (assq-delete-all 'which-func-mode mode-line-misc-info))      

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(defun eiio/getFunctionName() 
  "Getting current function name."
  (interactive)
  (setq fun_name (which-function))
  (replace-regexp-in-string "[\s]method" "" fun_name)
  
)

(defun eiio/getClassName ()
  "Getting current class name."
  (interactive)
  (file-name-nondirectory (file-name-sans-extension (buffer-file-name)))
)
(defun fullscreen ()
      (interactive)
      (tool-bar-mode -1)
      (menu-bar-mode -1)
      (set-frame-parameter nil 'fullscreen
                           (if (frame-parameter nil 'fullscreen) nil 'fullboth)))

(provide 'init-base)
;;; init-base.el ends here
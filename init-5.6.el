(require 'package) ;; You might already have this line
(setq package-archives '(("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                         ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")))
    (when (< emacs-major-version 24)
 ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)
;;(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "~/.emacs.d/local-lisp/use-package/")
  (add-to-list 'load-path "~/.emacs.d/local-lisp")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
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
  (setq auto-save-default nil) ;;关闭自动保存文件
  (global-auto-revert-mode 1);;加载外部修改过的文件
  (menu-bar-mode -99);;hide window top menu
  (setq-default c-basic-offset 4);;indentation
  (prefer-coding-system 'chinese-gbk)
  (prefer-coding-system 'utf-8)
  (setq url-gateway-method 'socks)
;;  (defvar socks-server '("Default server" "127.0.0.1" 1086 5))

  (which-function-mode t)
  
  ;;fonts
 (set-frame-font "Source Code Pro Medium-14")
   (set-fontset-font t 'han (font-spec :family "PingFang SC" :size 12))
    (setq face-font-rescale-alist '(("PingFang SC" . 1.2) ("Yuanti SC" . 1.2) ("Monaco" . 1.4)))

  (show-paren-mode t)
  (defvar show-paren-style 'expression)
  (require 'recentf)
  (recentf-mode t)
  (require 'project)
;;  (require 'init-org-mode)
  (require 'use-package)
  (require 'func)

 ;; )

(use-package company
  :ensure t
  :config
  (company-mode 1)
  :hook
  (after-init . global-company-mode)
  )
(use-package which-key
    :ensure t
    :config
    (which-key-mode)
    :init
    (setq which-key-side-window-location 'bottom)
    (setq which-key-frame-max-width 60)
    (setq which-key-frame-max-height 20)
    (which-key-setup-side-window-bottom)
    )
    (use-package evil
    :ensure t
    :init
    (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
    (setq evil-want-keybinding nil)
    :config
    (evil-mode 1)
    )
    (use-package evil-collection
    :ensure t
    :after evil
    :custom (evil-collection-setup-minibuffer t)
    :config
    (evil-collection-init)
    )
    (use-package multi-term
    :ensure t
    :init
    (setq multi-term-program "/bin/zsh")
    (setenv "PATH" (concat (getenv "PATH") ":/bin/zsh:/usr/local/bin"))
    (setq exec-path (append exec-path '("/usr/local/bin")))
    (setq show-trailing-whitespace nil)
    )

    ;;windows manage mode
    (use-package ace-window
    :ensure t
    :init
    (ace-window-display-mode t)
    (setq aw-dispatch-always  t)
    (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
    (defvar aw-dispatch-alist
	'((?x aw-delete-window " Ace - Delete Window")
	(?m aw-swap-window " Ace - Swap Window")
	(?n aw-flip-window)
	(?v aw-split-window-vert " Ace - Split Vert Window")
	(?b aw-split-window-horz " Ace - Split Horz Window")
	(?i delete-other-windows " Ace - Maximize Window"))
	"List of actions for `aw-dispatch-default'.")
    :bind
    (
    ("C-x w" . ace-window)
    ))

    ;;helm-mode
    (use-package helm
    :ensure t
    :config
    (setq helm-mode 1)
    :bind(
	    ("C-x c h" . helm-register)
	    ("C-x c g d" . helm-do-grep-ag)
	    ("C-x c g p" . helm-do-ag-project-root)
	    ("C-x c g f" . helm-do-ag-this-file)
	    ("C-x c g b" . helm-do-ag-buffers)
	    ("C-x c g g" . helm-do-ag)
	    ("M-." . helm-source-etags-select)
	    ("M-x". helm-M-x)
	    ("C-x C-f" . helm-find-files)
	    ("C-h x" . helm-apropos)
	    ("C-x b" . helm-buffers-list)
	    ;;bookmark
	    ("C-x r l" . helm-bookmarks)
	    ("C-x r s" . bookmark-set)
	    ("C-x r d" . bookmark-delete)
	    )
    )
    (use-package helm-projectile
    :ensure t
    :after (helm)
    :init
    (helm-projectile-on)
    )
    ;;project manager
    (use-package projectile
    :ensure t
    :init
    (projectile-mode t)
    :bind-keymap
    ("C-c p" . projectile-command-map)
    )
    (use-package avy
    :ensure t
    :config
    (avy-setup-default)
    :bind
    ("M-g f" . avy-goto-line)
    ("C-'" . avy-goto-char-2)
    ("C-:" . avy-goto-char)
    ("C-c C-t" . avy-move-line)
    ("C-c C-n l" . avy-copy-line)
    )


    ;;theme
    (use-package all-the-icons
    :ensure t
    :init
    (setq inhibit-compacting-font-caches t)
    )
    (use-package dashboard
    :ensure t
    :config
    (dashboard-setup-startup-hook)
    (add-to-list 'dashboard-items '(agenda) t)
    (setq dashboard-banners-directory "~/.emacs.d/assets/")
    (setq dashboard-banner-logo-title "~~Happy Codeing,Happy Life~~")
    (setq dashboard-startup-banner "~/.emacs.d/assets/logo.png")
    (setq dashboard-items '((agenda . 5)
			    (projects . 5)
			    (recents  . 5)
			    ))
    )

(use-package powerline
  :ensure t
  :init
  (powerline-center-theme)
  )
(use-package dracula-theme
    :ensure t
    :init
    (load-theme 'dracula t)
    )
 (use-package major-mode-icons
  :ensure t
  :config
  (major-mode-icons-mode 1))
(use-package magit
  :ensure t
  :init
  )
;;typescript
(use-package tide
;;  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
         (typescript-mode . tide-hl-identifier-mode)
         (before-save . tide-format-before-save)))
(use-package typescript-mode
  :ensure t
  :mode "\\.ts\\'"
  :interpreter "typescript"
  )
;;undo tree
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
  )
;;goto last change
(use-package goto-chg
  :ensure t
  :bind
  ("C-c b ," . goto-last-change)
  ("C-c b ." . goto-last-change-reverse)
  )

;;mac os dictionary
(use-package osx-dictionary
  :ensure t
  :bind
  ("C-c t" . osx-dictionary-search-word-at-point)
  ("C-c i" . osx-dictionary-search-input)
  )

(use-package swiper
  :ensure t
  :bind
  ("C-s" . swiper)
  )
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(evil-collection-setup-minibuffer t)
 '(package-selected-packages
   (quote
    (t:w xpm tide typescript typescript-mode company magit ob-swift ob-typescript org-bullets htmlize org-mime org-pomodoro which-key helm-ag evil-collection evil dashboard multi-term major-mode-icons helm-projectile dracula-theme ace-window))))
    
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

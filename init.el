;;; Code:
(require 'package) ;; You might already have this line
(setq package-archives '(
			 ("gnu"   . "https://mirrors.tuna.tsinghua.edu.cn/elpa/gnu/")
                        ("melpa" . "https://mirrors.tuna.tsinghua.edu.cn/elpa/melpa/")
;;			 ("melpa" . "http://elpa.emacs-china.org/melpa/")
			 ;; ("marmalade" . "http://marmalade-repo.org/packages/")
;;			  ("gnu"   . "http://elpa.emacs-china.org/gnu/")
			 ;; ("melpa" . "https://melpa.org/packages/")
			 ))
(when (< emacs-major-version 24)
  ;; For important compatibility libraries like cl-lib
  (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))
(package-initialize)



(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "~/.emacs.d/local-package/use-package/")
  (add-to-list 'load-path "~/.emacs.d/local-lisp")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes/dracula-theme")
  (load-theme 'dracula t)
  ;;打开配置文件
  (global-set-key (kbd "<f2>") (lambda () (interactive) (open-init-file "~/.emacs.d/init.el")))
  ;;add init file reload
  (defun eiio/load_init_file()
    (interactive)
    (load-file "~/.emacs.d/init.el")
    )
  (global-set-key (kbd "<f1>") 'eiio/load_init_file)
  ;;load package
  (require 'use-package)
  )
  ;;setting font style
(set-frame-font "Source Code Pro Medium-14")
(set-fontset-font t 'han (font-spec :family "PingFang SC" :size 12))
(setq face-font-rescale-alist '(("PingFang SC" . 1.2) ("Yuanti SC" . 1.2) ("Monaco" . 1.2)))



(require 'init-base)
(require 'init-org-mode)
(require 'init-js)
(require 'init-blog)

;; replace word mode
(use-package anzu
  :ensure t
  :defer t
  :init
  (global-anzu-mode +1)
  :bind(
	("C-c C-r" . anzu-query-replace-regexp)
	)
  
  )


(use-package company
  :ensure t
  :defer t
  :config
  (company-mode 1)
  :init
  (setq company-tooltip-align-annotations t)
  (global-company-mode)
  :bind
  ("M-/" . company-complete)
  )

;;theme
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (add-to-list 'dashboard-items '(agenda) t)
  (setq dashboard-banners-directory "~/.emacs.d/assets/")
  (setq dashboard-banner-logo-title "~~Happy Coding,Happy Life~~")
  (setq dashboard-startup-banner "~/.emacs.d/assets/logo.png")
  (setq dashboard-items '(
			  (agenda . 5)
 			  (projects . 5)
 			  (recents  . 5)
 			  ))
  )

(use-package spaceline
  :ensure t
  :init
  (require 'spaceline-config)
  (spaceline-all-the-icons-theme)
  ;; (spaceline-spacemacs-theme)
  (spaceline-helm-mode)
  (spaceline-info-mode)
  
  )

(use-package all-the-icons
  :ensure t
  :after (neotree)
  :init
  (setq inhibit-compacting-font-caches t)
  (setq neo-theme 'icons)
  :defer t
  )

(use-package all-the-icons-dired
  :ensure  t
  :after (all-the-icons)
  :defer t
  :hook
  (dired-mode . all-the-icons-dired-mode)
  )


(use-package neotree
  :ensure t
  :bind(
	("C-c h" . neotree-toggle)
	)
)

(use-package which-key
  :ensure t
  :defer t
  :config
  (which-key-mode)
  :init
  (setq which-key-popup-type 'minibuffer)
  (setq which-key-side-window-location 'bottom)
  (setq which-key-idle-delay 0.5)
  (which-key-add-key-based-replacements
  "C-c ^" "smerge")
(which-key-add-key-based-replacements
  "C-c w" "windows")
(which-key-add-key-based-replacements
  "C-c !" "flycheck")
(which-key-add-key-based-replacements
  "C-c e" "emms")
(which-key-add-key-based-replacements
    "C-c C-g" "grep & find")
  )
(use-package flycheck-status-emoji
  :ensure t
  :after (flycheck)
  :init
  (setq flycheck-status-emoji-mode t)
  :defer t
  )
(use-package projectile
  :ensure t
  :defer t
  :config
  (projectile-mode t)
  :bind
  ("C-c p" . projectile-command-map)
  )
(use-package helm-projectile
  :ensure t
  :after (helm projectile)
  :defer t
  )
(use-package helm-ag
  :ensure t
  :after (helm)
  :defer t
  )
(use-package magit-svn
  :ensure t
  :after (magit)
  :defer t
  )
(use-package magit
  :ensure t
  :config
  (global-git-commit-mode)
  (global-magit-file-mode 1)
  (smerge-mode t)
  :defer t
  
)
(use-package helm
  :ensure t
  :config
  (helm-mode 1)
  ;;(helm-gtags-mode 1)
  (helm-autoresize-mode 1)
  (helm-projectile-on)
  :bind(
	("M-x" . helm-M-x)
	("C-c l" . helm-imenu)
	("C-x C-f" . helm-find-files)
	("C-h x" . helm-apropos)
	("C-x b" . helm-buffers-list)
	("C-x c h" . helm-register)
	("C-x r l" . helm-bookmarks)
	("C-x r s" . bookmark-set)
	("C-x r d" . bookmark-delete)
	("C-x c g d" . helm-do-grep-ag)
	("C-x c g p" . helm-do-ag-project-root)
	("C-x c g f" . helm-do-ag-this-file)
	("C-x c g b" . helm-do-ag-buffers)
	("C-x c g g" . helm-do-ag)
	("M-." . helm-source-etags-select)
	  
	))
(use-package ace-window
  :ensure t
  :init
  (ace-window-display-mode t)
  (setq aw-dispatch-always  t)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind
  ("C-x w" . ace-window)
  )

(use-package windmove
  :ensure t
  :init
  (windmove-default-keybindings 'meta)
  )
;;undo tree
(use-package undo-tree
  :ensure t
  :config
  (global-undo-tree-mode)
    :defer t
  )
;;goto last change
(use-package goto-chg
  :ensure t
  :defer t
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
  :defer t
  )

;;avy-mode
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
    :defer t
  )

;;web get
(use-package web
  :ensure t
    :defer t
  )

;;company-mode;; yasnippet
(use-package yasnippet
  :ensure t
    :defer t
	     :init
	     (yas-global-mode 1)
	     (yas-reload-all)
	     :config
	     (add-to-list 'yas-snippet-dirs (locate-user-emacs-file "snippets")))

(use-package semantic
  :ensure t
  :defer t
  :config
  (global-semanticdb-minor-mode t)
  (global-semantic-idle-completions-mode t)
  (global-semantic-idle-scheduler-mode t)

  :bind (("C-c , f" . semantic-ia-fast-jump)
	 )
  )

(use-package function-args
  :ensure t
  :init
  :config
  (set-default 'semantic-case-fold t)
  :defer t
  )

(use-package posframe
  :ensure t
  )

(use-package pyim
  :ensure t
  :demand t
  :after (posframe)
  :config
  ;; 激活 basedict 拼音词库，五笔用户请继续阅读 README
  (use-package pyim-basedict
    :ensure t
    :config (pyim-basedict-enable))

  (setq default-input-method "pyim")
  ;; 我使用全拼
  (setq pyim-default-scheme 'quanpin)
  ;; 设置 pyim 探针设置，这是 pyim 高级功能设置，可以实现 *无痛* 中英文切换 :-)
  ;; 我自己使用的中英文动态切换规则是：
  ;; 1. 光标只有在注释里面时，才可以输入中文。
  ;; 2. 光标前是汉字字符时，才能输入中文。
  ;; 3. 使用 M-j 快捷键，强制将光标前的拼音字符串转换为中文。
  (setq-default pyim-english-input-switch-functions
                '(pyim-probe-dynamic-english
                  pyim-probe-isearch-mode
                  pyim-probe-program-mode
                  pyim-probe-org-structure-template))

  (setq-default pyim-punctuation-half-width-functions
                '(pyim-probe-punctuation-line-beginning
                  pyim-probe-punctuation-after-punctuation))

  ;; 开启拼音搜索功能
  (pyim-isearch-mode 1)
  ;; 使用 pupup-el 来绘制选词框, 如果用 emacs26, 建议设置
  ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
  ;; 手动安装 posframe 包。
  (setq pyim-page-tooltip 'popup)
  ;; 选词框显示5个候选词
  (setq pyim-page-length 5)

  :bind
  (("M-j" . pyim-convert-string-at-point) ;与 pyim-probe-dynamic-english 配合
   ("C-;" . pyim-delete-word-from-personal-buffer)))

(use-package csharp-mode
  :ensure t
  )
(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e" default)))
 '(package-selected-packages
   (quote
    (winum anzu  spaceline-all-the-icons all-the-icons-dired neotree posframe pyim easy-hugo lsp-javascript-typescript helm-ag ob-typescript org-recipes org-wiki org-bullets org-super-agenda htmlize org-mime helm-projectile company magit-svn ace-window helm-config which-key all-the-icons powerline projectile function-args yasnippet web avy osx-dictionary goto-chg undo-tree helm flycheck-status-emoji)))
 '(projectile-mode t nil (projectile)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((t (:background "#44475a" :box (:line-width 1 :color "#44475a") :height 140))))
 '(spaceline-all-the-icons-info-face ((t (:foreground "#63B2FF" :height 1.0))))
 '(spaceline-all-the-icons-sunrise-face ((t (:inherit powerline-active2 :foreground "#f6c175" :height 1.2))))
 '(spaceline-all-the-icons-sunset-face ((t (:inherit powerline-active2 :foreground "#fe7714")))))

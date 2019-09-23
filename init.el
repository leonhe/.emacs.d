 ;; -*-byte-compile-dynamic: t;-*-
;;; Code:
(setq gc-cons-threshold 100000000)
;;(set-default-font "SourceCodeVariable-Italic-14")
(set-default-font "Hack-16")
;;(set-frame-font "Source Code Pro Medium-14")
;;setting windows maximized
(add-to-list 'default-frame-alist '(fullscreen . maximized))
(scroll-bar-mode -1)
(set-fontset-font t 'han (font-spec :family "PingFang SC" :size 14))
(setq face-font-rescale-alist '(("PingFang SC" . 1.2) ("Yuanti SC" . 1.2) ))
 

(add-to-list 'load-path "~/.emacs.d/local-lisp/")
(add-to-list 'load-path (expand-file-name "~/.emacs.d/local/snails/"))
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

(setq package-enable-at-startup nil)
(package-initialize)

(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (add-to-list 'load-path "~/.emacs.d/local-package/use-package/")
  
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
  (setq use-package-verbose t)
  (require 'use-package-ensure)
  (setq use-package-always-ensure t)
  ;;auto update package
  (use-package auto-package-update
    :config
    (setq auto-package-update-delete-old-versions t)
    (setq auto-package-update-hide-results t)
    (auto-package-update-maybe))
  )
(setq shell-file-name "/bin/zsh")
(setenv "PATH" (concat (getenv "PATH") ":/bin/zsh:/usr/local/bin:$HOME/GoWorks/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))
;; (use-package snails
;;   :load-path "~/.emacs.d/local/snails/"
;;   :after (ex)
;;   :config
;;   (require 'snails)
;;   (defun open-snails()
;;     (interactive)
;;     (snails '(snails-backend-imenu snails-backend-buffer snails-backend-recentf snails-backend-mdfind snails-backend-bookmark snails-backend-current-buffer))
;;     )

;;   )
;;(snails '(snails-backend-buffer snails-backend-recentf snails-backend-imenu snails-backend-current-buffer snails-backend-projectile snails-backend-mdfind) t)
;setting theme
(use-package doom-themes
 :ensure t
 :config
 ;; Global settings (defaults)
 (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
       doom-themes-enable-italic t) ; if nil, italics is universally disabled

 ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
 ;; may have their own settings.
 (load-theme 'doom-dracula t)

 ;; Enable flashing mode-line on errors
 (doom-themes-visual-bell-config)

 ;; Enable custom neotree theme (all-the-icons must be installed!)
 (doom-themes-neotree-config)
 ;; or for treemacs users
 (setq doom-themes-treemacs-theme "doom-colors") ; use the colorful treemacs theme
 (doom-themes-treemacs-config)

 ;; Corrects (and improves) org-mode's native fontification.
 (doom-themes-org-config)
 )
(use-package doom-modeline
      :ensure t
      :after doom-themes
      :config
      ;; Whether display icons in mode-line or not.
      (setq doom-modeline-icon t)

      ;; Whether display the icon for major mode. It respects `doom-modeline-icon'.
      (setq doom-modeline-major-mode-icon t)

      ;; Whether display color icons for `major-mode'. It respects
      ;; `doom-modeline-icon' and `all-the-icons-color-icons'.
      (setq doom-modeline-major-mode-color-icon t)

      ;; Whether display icons for buffer states. It respects `doom-modeline-icon'.
      (setq doom-modeline-buffer-state-icon t)
;; Whether display `lsp' state or not. Non-nil to display in mode-line.
      (setq doom-modeline-lsp t)
      :hook (after-init . doom-modeline-mode))
(require 'init-base)
(require 'init-org-mode)
(require 'init-js)
(require 'init-blog)

(add-hook 'after-init-hook (lambda ()
			     (defvar fill-column 80)
			     (defvar c-tab-always-indent nil)
			     (defvar mac-pass-command-to-system nil)
			     (defvar mac-option-modifier 'meta)
			     (defvar mac-command-modifier 'super)

			     (tool-bar-mode -1)
			     (menu-bar-mode -1)
			     (global-flycheck-mode)
			     (global-font-lock-mode t)
			     (global-visual-line-mode)

			     (electric-indent-mode t)
			     (show-paren-mode t)
			     ;;系统本身内置的智能自动补全括号
			     (electric-pair-mode t)

			     (global-hl-line-mode t)
			     (setq-default major-mode 'text-mode)
			     ))

;; 切换buffer后，立即刷新
(defadvice switch-to-buffer (after revert-buffer-now activate)
  (if (eq major-mode 'dired-mode)
      (revert-buffer)))
;; 执行shell-command后，立即刷新
(defadvice shell-command (after revert-buffer-now activate)
  (if (eq major-mode 'dired-mode)
      (revert-buffer)))

;; 在Bookmark中进入dired buffer时自动刷新
(setq dired-auto-revert-buffer t)

;;macos path
(use-package exec-path-from-shell
  :ensure t
  :config
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))
  )

;;company mode
(use-package company-tabnine
  :ensure t
  :after (company)
  :defer t
  :config
  (add-to-list 'company-backends #'company-tabnine)
  )

(use-package company
  :ensure t
  :defer t
  :config
  (setq company-tooltip-align-annotations t)
  (setq-default company-auto-complete t)
   ;; Trigger completion immediately.
   (setq company-idle-delay 1)
  ;; ;; Number the candidates (use M-1, M-2 etc to select completions).
   (setq company-show-numbers t)
  ;; Use the tab-and-go frontend.
  ;; Allows TAB to select and complete at the same time.
  (company-tng-configure-default)
  (setq company-frontends
 	'(company-tng-frontend
         company-pseudo-tooltip-frontend
         company-echo-metadata-frontend))
  :init
  (company-mode 1)
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

(use-package helm-projectile
  :ensure t
  :config
    (helm-projectile-on)
  )
(use-package helm
  :ensure t
  :init
  (helm-mode 1)
  (helm-autoresize-mode 1)
  :bind(
	("M-x" . helm-M-x)
	("C-x C-f" . helm-find-files)
	("C-x b" . helm-buffers-list)
  ))
(use-package ace-jump-helm-line
  :ensure t
  :after helm
  :init
  (setq ace-jump-helm-line-keys (number-sequence ?a ?z))
  (setq ace-jump-helm-line-style 'at)
  (setq ace-jump-helm-line-default-action 'select)
  (setq ace-jump-helm-line-background t)
  (setq ace-jump-helm-line-autoshow-use-linum t)
  :bind (:map helm-map
	      ("C-'" . ace-jump-helm-line))
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
;;ace-mode
(use-package ace-window
  :ensure t
  :config
    (defvar aw-dispatch-alist
  '((?x aw-delete-window "Delete Window")
	(?m aw-swap-window "Swap Windows")
	(?M aw-move-window "Move Window")
	(?c aw-copy-window "Copy Window")
	(?j aw-switch-buffer-in-window "Select Buffer")
	(?n aw-flip-window)
	(?u aw-switch-buffer-other-window "Switch Buffer Other Window")
	(?c aw-split-window-fair "Split Fair Window")
	(?v aw-split-window-vert "Split Vert Window")
	(?b aw-split-window-horz "Split Horz Window")
	(?o delete-other-windows "Delete Other Windows")
	(?? aw-show-dispatch-help))
  "List of actions for `aw-dispatch-default'.")
  :init
  (ace-window-display-mode t)
  (setq aw-dispatch-always  t)
  (setq aw-keys '(?a ?s ?d ?f ?g ?h ?j ?k ?l))
  :bind
  ("C-x w" . ace-window)
  )

;undo tree
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
  :config
  (setq posframe-arghandler #'my-posframe-arghandler)
  (defun my-posframe-arghandler (buffer-or-name arg-name value)
    (let ((info '(:internal-border-width 8 :background-color "gray7")))
      (or (plist-get info arg-name) value)))
  )
 (use-package pyim
   :ensure t
   :demand t
   :after posframe
   :config
  ;; 激活 basedict 拼音词库，五笔用户请继续阅读 README
  (use-package pyim-basedict
    :config (pyim-basedict-enable))

  (setq default-input-method "pyim")
  ;;   ;; 我使用全拼
 
  (setq pyim-default-scheme 'quanpin)
  ;; 开启拼音搜索功能
  (pyim-isearch-mode 1)
  ;; 使用 pupup-el 来绘制选词框, 如果用 emacs26, 建议设置
  ;;   ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
  ;;   ;; 手动安装 posframe 包。
  (setq pyim-page-tooltip 'posframe)
  (setq pyim-page-style 'one-line)
  ;;   ;; 选词框显示5个候选词
  (setq pyim-page-length 5)
  ;;开启拼音联想
  (setq pyim-enable-words-predict '(pinyin-similar pinyin-shouzimu))
  ;;设置模糊搜索

  (setq pyim-fuzzy-pinyin-alist '(("en" "eng") ("in" "ing") ("an" "ang") ("z" "zh") ("c" "ch") ("s" "sh") ("uan" "uang")))
  (setq pyim-punctuation-translate-p '(auto yes no))   ;中文使用全角标点，英文使用半角标点。
  )

(use-package csharp-mode
  :ensure t
  :after (company)
  :config
  (use-package omnisharp
    :init
    (omnisharp-mode)
    :ensure t
    )
(eval-after-load
  'company
  '(add-to-list 'company-backends #'company-omnisharp))
(add-hook 'csharp-mode-hook #'flycheck-mode)
(add-hook 'csharp-mode-hook #'company-mode)
(add-hook 'csharp-mode-hook #'omnisharp-mode)
)

(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  )
(use-package multi-term
  :ensure t
  :config
  (setq multi-term-program "/bin/zsh")
  
)

(use-package comment-tags
  :ensure t
  :config
  (add-hook 'prog-mode-hook 'comment-tags-mode)
  (setq comment-tags-keymap-prefix (kbd "C-c #"))
  (setq comment-tags-keyword-faces
        `(("TODO" . ,(list :weight 'bold :foreground "#28ABE3"))
          ("FIXME" . ,(list :weight 'bold :foreground "#DB3340"))
          ("BUG" . ,(list :weight 'bold :foreground "#DB3340"))
          ("HACK" . ,(list :weight 'bold :foreground "#E8B71A"))
          ("KLUDGE" . ,(list :weight 'bold :foreground "#E8B71A"))
          ("XXX" . ,(list :weight 'bold :foreground "#F7EAC8"))
          ("INFO" . ,(list :weight 'bold :foreground "#F7EAC8"))
          ("DONE" . ,(list :weight 'bold :foreground "#1FDA9A"))))
  (setq comment-tags-comment-start-only t
        comment-tags-require-colon t
        comment-tags-case-sensitive t
        comment-tags-show-faces t
        comment-tags-lighter nil)
 )

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  :bind (:map evil-normal-state-map
	      ("SPC f" . open-snails)
	      ("SPC l" . helm-imenu)
	      ("SPC e" . helm-find-files)
	      ("SPC b" . switch-to-buffer)
	      ("SPC k" . kill-buffer)
	      ("SPC p" . projectile-switch-project)
	      ("SPC v" . projectile-vc)
	      ("SPC w" . ace-window)
	      ("SPC q" . fullscreen)
	      ("SPC c l" . avy-copy-line)
	      ("SPC c r" . avy-copy-region)
	      ("t" . pyim-punctuation-toggle)
	      ("g c" . avy-goto-char)
	      ("SPC s" . multi-term)))
(use-package mark-multiple
  :ensure t)
(use-package evil-org
  :ensure t
  :after org
  :config
  (add-hook 'org-mode-hook 'evil-org-mode)
  (add-hook 'evil-org-mode-hook
            (lambda ()
              (evil-org-set-key-theme)))
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))
(use-package evil-magit
  :ensure t
  :after magit
  :config
  (setq evil-magit-state 'normal)
  )

(use-package evil-collection
  :ensure t
  :after evil
  :custom (evil-collection-setup-minibuffer t)
  :init (evil-collection-init)
				
  )
(use-package ag
  :ensure t)

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config
  (setq dumb-jump-selector 'helm)
  (setq dumb-jump-force-searcher 'ag)
  :ensure t)

(use-package leetcode
  :ensure t
  :config
  (setq leetcode-prefer-language "c++")
  (setq request-message-level 'debug)
  (setq request-log-level 'debug)
  (setq leetcode-prefer-sql "mysql")
  )
;;go lang develop env
(use-package go-autocomplete
  :ensure t
  :after go-mode
 ) 


(use-package go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  :hook ((before-save . gofmt-before-save))
  :config
  (add-to-list 'auto-mode-alist '("\\.go$" . hs-minor-mode))
  (setq gofmt-command "goimports")

  (use-package company-go
    :ensure t
    :after(go-autocomplete)
    :config
    (add-hook 'go-mode-hook (lambda()
                              (add-to-list (make-local-variable 'company-backends)
                                           '(company-go company-files company-yasnippet company-capf))))
    )
  (use-package go-dlv
    :ensure t)
  (use-package go-eldoc
    :ensure t
    :hook (go-mode . go-eldoc-setup)
    )
  (use-package go-guru
    :ensure t
    :hook (go-mode . go-guru-hl-identifier-mode)
    )
  (use-package go-rename
    :ensure t)
 )

(use-package sudo-edit
  :ensure t
  )

(use-package dap-mode
  :ensure t
  :after (:any typescript go-mode)
  :init 
  (require 'dap-chrome)
  (dap-mode 1)
  (dap-ui-mode 1)
  :config
 (dap-register-debug-template "Chrome Browse URL"
  (list :type "chrome"
        :cwd nil
        :mode "url"
        :request "launch"
        :webRoot nil
        :url "http://192.168.191.51:3000/index.html" 
        :name "Egret Browse URL"))
  :bind  (:map dap-mode-map
   	       ("C-c r s" . dap-debug)
	       ("C-c r b" . dap-breakpoint-toggle)
	       ("C-c r l" . dap-ui-locals)
	       ("C-c r v" . dap-ui-sessions)
	       ("C-c r c" . dap-continue)
	       ("C-c r n" . dap-next)
 	       ))

(use-package emojify
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-emojify-mode)
  )

(defun eiio/omnifoucs()
  (interactive)
  
    ;; (let ((multi-term-program "osascript -l JavaScript ~/Documents/AppScript/OmnifocusTask.scpt"))
    ;; 	)
    ;;(shell-command-to-string "/bin/echo hello")
    ;; (setq my_shell_output (substring (shell-command-to-string "osascript -l JavaScript ~/Documents/AppScript/OmnifocusTask.scpt") 0 -1))
    ;;(message my_shell_output)
  )


(global-set-key (kbd "C-c o i") 'eiio/omnifoucs)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(comment-auto-fill-only-comments t)
 '(comment-multi-line t)
 '(comment-style (quote multi-line))
 '(custom-safe-themes
   (quote
    ("cb477d192ee6456dc2eb5ca5a0b7bd16bdb26514be8f8512b937291317c7b166" "427fa665823299f8258d8e27c80a1481edbb8f5463a6fb2665261e9076626710" "e3c87e869f94af65d358aa279945a3daf46f8185f1a5756ca1c90759024593dd" "4e132458143b6bab453e812f03208075189deca7ad5954a4abb27d5afce10a9a" "155a5de9192c2f6d53efcc9c554892a0d87d87f99ad8cc14b330f4f4be204445" "b0fd04a1b4b614840073a82a53e88fe2abc3d731462d6fde4e541807825af342" "ace9f12e0c00f983068910d9025eefeb5ea7a711e774ee8bb2af5f7376018ad2" "e9df267a1c808451735f2958730a30892d9a2ad6879fb2ae0b939a29ebf31b63" "274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e" default)))
 '(dumb-jump-mode t)
 '(evil-collection-setup-minibuffer t)
 '(iswitchb-mode t)
 '(org-wiki-template
   "#+TITLE: %n
#+DESCRIPTION:
#+KEYWORDS:
#+STARTUP:  content
#+INCLUDE: theme/style.org

- [[wiki:index][{Back to Wiki's index}]]

- Related: 
* %n
")
 '(package-selected-packages
   (quote
    (org-projectile-helm pyim snails exec-path-from-shell emojify o-blog ace-jump-helm-line all-the-icons-gnus helm-company go-autocomplete ace-jump-mode counsel-org-clock doom-modeline doom-themes sudo-edit go-dlv go-rename go-guru go-eldoc company-go go-mode leetcode evil-collection evil-leader evil company-tabnine counsel-projectile counsel swiper eglot comment-tags multi-term ox-hugo spaceline-all-the-icons-theme winum anzu spaceline-all-the-icons all-the-icons-dired neotree posframe easy-hugo lsp-javascript-typescript helm-ag ob-typescript org-recipes org-wiki org-bullets org-super-agenda htmlize org-mime helm-projectile company magit-svn ace-window helm-config which-key all-the-icons powerline projectile function-args yasnippet web avy osx-dictionary goto-chg undo-tree helm flycheck-status-emoji)))
 '(projectile-mode t nil (projectile))
 '(pyim-dicts
   (quote
    ((:name "pyim-bigdict" :file "/Users/heyuanfei/.emacs.d/pyim-bigdict.pyim")))))
   
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(minibuffer-prompt ((t (:foreground "#ff79c6" :weight bold))))
 '(mode-line ((t (:background "#44475a" :box (:line-width 1 :color "#44475a") :height 140))))
 '(mode-line-buffer-id ((t (:weight bold :height 1.0))))
 '(mode-line-emphasis ((t (:weight bold :height 1.0))))
 '(mode-line-highlight ((t (:box (:line-width 2 :color "grey40" :style released-button)))))
 '(mode-line-inactive ((t (:background "#373844" :foreground "#f8f8f2" :box (:line-width 1 :color "#373844")))))
 '(spaceline-all-the-icons-info-face ((t (:foreground "#63B2FF" :height 1.0))))
 '(spaceline-all-the-icons-sunrise-face ((t (:inherit powerline-active2 :foreground "#f6c175" :height 1.2))))
 '(spaceline-all-the-icons-sunset-face ((t (:inherit powerline-active2 :foreground "#fe7714")))))

;; -*-byte-compile-dynamic: t;-*-
;;; Code:
(add-to-list 'load-path "~/.emacs.d/local-lisp/")
(require 'package) ;; You might already have this line
(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  (when no-ssl (warn "\
Your version of Emacs does not support SSL connections,
which is unsafe because it allows man-in-the-middle attacks.
There are two things you can do about this warning:
1. Install an Emacs version that does support SSL and be safe.
2. Remove this warning from your init file so you won't see it again."))
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
  ;; and `package-pinned-packages`. Most users will not need or want to do this.
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  )
(setq package-archives '(
			 ("gnu" . "https://mirrors.cloud.tencent.com/elpa/gnu/")
			 ("melpa" . "https://mirrors.cloud.tencent.com/elpa/melpa/")
			 ))
;; (setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
;;                          ("melpa" . "https://melpa.org/packages/")))
;; (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t) ; Org-mode's repository
;; (when (< emacs-major-version 24)
;;   ;; For important compatibility libraries like cl-lib
;;   (add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/")))

(setq package-enable-at-startup nil)
(package-initialize)

(eval-when-compile
  ;; Following line is not needed if use-package.el is in ~/.emacs.d
  (when (not (display-graphic-p))
    (setq frame-background-mode 'dark))
  (add-to-list 'load-path "~/.emacs.d/local-package/use-package/")
  
  ;;打开配置文件
  (global-set-key (kbd "<f2>") (lambda () (interactive) (open-init-file "~/.emacs.d/init.el")))
  ;;add init file reload

  (defun eiio/load_init_file()
    (interactive)
    (load-file "~/.emacs.d/init.el")
    )
  ;; (global-set-key (kbd "<f1>") 'eiio/load_init_file)
  ;;load package

  (require 'use-package)
  (setq use-package-verbose t)
  (require 'use-package-ensure)
  (setq use-package-always-ensure t)
  (setq use-package-compute-statistics t)
  ;;auto update package
  (use-package auto-package-update
    :config
    (setq auto-package-update-delete-old-versions t)
    (setq auto-package-update-hide-results t)
    (auto-package-update-maybe))
  )
(require 'init-base)
(require 'init-evil)
(require 'init-org-mode)
(require 'init-js)
(require 'init-lua)
(require 'init-py)
(require 'init-blog)
(require 'gitmoji-commit)
(require 'init-ivy)
(require 'comment-mode)
(scroll-bar-mode -1)
(set-frame-font "Source Code Pro Medium-16")
;; (set-fontset-font t 'han (font-spec :family "Source Code Pro Medium" :size 16))
(set-face-attribute 'default nil :family "Source Code Pro Medium" :height 160 )
;; (set-fontset-font t 'han (font-spec :family "PingFang SC" :size 16))
;; (add-hook 'after-make-frame-functions (lambda ()
;; 					(set-frame-font "Source Code Pro Medium-16")
;; 					))
(setq shell-file-name "/bin/zsh")
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin:/usr/local/bin:$HOME/GoWorks/bin"))
(setq exec-path (append exec-path '("/usr/local/bin")))

(use-package smart-mode-line)
;; ;;macos path
(use-package exec-path-from-shell
  :ensure t
  :config
  (when (memq window-system '(mac ns x))
    (exec-path-from-shell-initialize))
  )
;; ;; setting theme
(use-package doom-themes
  :ensure t
  :init
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
	doom-themes-enable-italic t) ; if nil, italics is universally disabled

  ;; Load the theme (doom-one, doom-molokai, etc); keep in mind that each theme
  ;; may have their own settings.
  (load-theme 'doom-dracula t)
  ;; (load-theme 'doom-snazzy t)
  ;; (load-theme 'doom-acario-dark t)
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
;; (use-package telephone-line
;;   :ensure t
;;   :init
;;   (telephone-line-mode 1)
;;   :config
;;   (setq telephone-line-lhs
;;       '((evil   . (telephone-line-evil-tag-segment))
;;         (accent . (telephone-line-vc-segment
;;                    telephone-line-erc-modified-channels-segment
;;                    telephone-line-process-segment))
;;         (nil    . (telephone-line-minor-mode-segment
;;                    telephone-line-buffer-segment))))
;; (setq telephone-line-rhs
;;       '((nil    . (telephone-line-misc-info-segment))
;;         (accent . (telephone-line-major-mode-segment))
;;         (evil   . (telephone-line-airline-position-segment))))

;;  )

(use-package doom-modeline
  :ensure t
  :after doom-themes
  :init
  ;; How tall the mode-line should be. It's only respected in GUI.
  ;; If the actual char height is larger, it respects the actual height.
  (setq doom-modeline-height 25)

  ;; How wide the mode-line bar should be. It's only respected in GUI.
  (setq doom-modeline-bar-width 3)

  ;; The limit of the window width.
  ;; If `window-width' is smaller than the limit, some information won't be displayed.
  (setq doom-modeline-window-width-limit fill-column)

  ;; Whether display icons in mode-line or not.
  (setq doom-modeline-icon t)
  (setq doom-modeline-project-detection 'project)
  ;; Whether display the icon for major mode. It respects `doom-modeline-icon'.
  (setq doom-modeline-major-mode-icon t)
  ;; Whether display icons in the mode-line. Respects `all-the-icons-color-icons'.
  ;; While using the server mode in GUI, should set the value explicitly.
  (setq doom-modeline-icon (display-graphic-p))
  ;; Whether display the icon for `major-mode'. Respects `doom-modeline-icon'.
  (setq doom-modeline-major-mode-icon t)

  ;; Whether display color icons for `major-mode'. It respects
  ;; `doom-modeline-icon' and `all-the-icons-color-icons'.
  (setq doom-modeline-major-mode-color-icon t)
  ;; Whether display icons for buffer states. It respects `doom-modeline-icon'/i：“w”.
  (setq doom-modeline-buffer-state-icon t)
  ;; Whether display `lsp' state or not. Non-nil to display in mode-line.
  (setq doom-modeline-lsp t)
  (setq doom-modeline-buffer-file-name-style 'auto)
  :hook (after-init . doom-modeline-mode))

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

;;company mode
(use-package company-tabnine
  :ensure t
  :after (company)
  :defer t
  :config
  (add-to-list 'company-backends #'company-tabnine)
  )

(use-package symbol-overlay
  :ensure t
  )

(use-package company
  :ensure t
  :defer t
  :config
  ;; (setq company-tooltip-align-annotations t)
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
(use-package company-posframe
  :ensure t
  :after (company )
  :init (company-posframe-mode 1)
  :config
  (require 'desktop) ;this line is needed.
  (push '(company-posframe-mode . nil)
	desktop-minor-mode-table)
  )

(use-package semantic
  :init
  (setq semantic-default-submodes
	'(;; Perform semantic actions during idle time
	  global-semantic-idle-scheduler-mode
	  ;; Use a database of parsed tags
	  global-semanticdb-minor-mode
	  ;; Decorate buffers with additional semantic information
	  global-semantic-decoration-mode
	  ;; Highlight the name of the function you're currently in
	  global-semantic-highlight-func-mode
	  ;; show the name of the function at the top in a sticky
	  global-semantic-stickyfunc-mode
	  ;; Generate a summary of the current tag when idle
	  global-semantic-idle-summary-mode
	  ;; Show a breadcrumb of location during idle time
	  global-semantic-idle-breadcrumbs-mode
	  ;; Switch to recently changed tags with `semantic-mrub-switch-tags',
	  ;; or `C-x B'
	  global-semantic-mru-bookmark-mode))
  )


;;theme
(use-package dashboard
  :ensure t
  :config
  (dashboard-setup-startup-hook)
  (add-to-list 'dashboard-items '(agenda) t)
  (setq dashboard-banners-directory "~/.emacs.d/assets/")
  (setq dashboard-banner-logo-title "~~Happy Coding,Happy Life~~")
  ;; (setq dashboard-startup-banner "~/.emacs.d/assets/1.txt")
  (setq dashboard-startup-banner "~/.emacs.d/assets/fish.txt")
  (setq dashboard-items '(
			  (agenda . 5)
 			  (projects . 5)
 			  (recents  . 5)
 			  ))
  )

;; (use-package helm-projectile
;;   :ensure t
;;   :after (helm)
;;   :config
;;     (helm-projectile-on)
;;   )
;; (use-package helm-git
;;   :ensure t
;;   :after (helm))

;; (use-package helm-ag
;;   :ensure t
;;   :after helm)

;; (use-package ace-jump-helm-line
;;   :ensure t
;;   :after helm
;;   :init
;;   (setq ace-jump-helm-line-keys (number-sequence ?a ?z))
;;   (setq ace-jump-helm-line-style 'at)
;;   (setq ace-jump-helm-line-default-action 'select)
;;   (setq ace-jump-helm-line-background t)
;;   (setq ace-jump-helm-line-autoshow-use-linum t)
;;   )
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

(use-package which-key
  :ensure t
  :defer t
  :config
  (which-key-mode)
  :init
  (setq which-key-separator "   " )
  (setq which-key-unicode-correction 3)
  (setq which-key-show-early-on-C-h t)
  (setq which-key-popup-type 'minibuffer)
  ;;(setq which-key-popup-type 'side-window)
  (setq which-key-side-window-location 'bottom)
  (setq which-key-idle-delay 0.15)
  ;; (setq which-key-idle-delay 10000)
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
  (setq which-key-sort-order 'which-key-key-order)
  :init
  (setq which-key-separator "   " )
  (setq which-key-unicode-correction 3)
  (setq which-key-show-early-on-C-h t)
  (setq which-key-popup-type 'minibuffer)
  ;;(setq which-key-popup-type 'side-window)
  (setq which-key-side-window-location 'bottom)
  (setq which-key-idle-delay 0.15)
  ;; (setq which-key-idle-delay 10000)
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
  (setq which-key-sort-order 'which-key-key-order)
  :init
  (setq which-key-separator "   " )
  (setq which-key-unicode-correction 3)
  (setq which-key-show-early-on-C-h t)
  (setq which-key-popup-type 'minibuffer)
  ;;(setq which-key-popup-type 'side-window)
  (setq which-key-side-window-location 'bottom)
  ;; (setq which-key-idle-delay 10000)
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
  (setq which-key-sort-order 'which-key-key-order)
  :init
  (setq which-key-separator "   " )
  (setq which-key-unicode-correction 3)
  (setq which-key-show-early-on-C-h t)
  (setq which-key-popup-type 'minibuffer)
  ;;(setq which-key-popup-type 'side-window)
  (setq which-key-side-window-location 'bottom)
  (setq which-key-idle-delay 0.15)
  ;; (setq which-key-idle-delay 10000)
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
  (setq which-key-sort-order 'which-key-key-order)
  ;; (define-key projectile-command-map "p" '("s" . projectile-switch-project))
  )
(use-package flycheck-status-emoji
  :ensure t
  :after (flycheck)
  :init
  (setq flycheck-status-emoji-mode t)
  :defer t
  )
(use-package flycheck-posframe
  :ensure t
  :after flycheck
  :config
  (add-hook 'flycheck-mode-hook #'flycheck-posframe-mode)
  (setq flycheck-posframe-position 'point-bottom-right-corner)
  )
(use-package projectile
  :ensure t
  :defer t
  :config
  (projectile-mode t)
  ;; :init
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
  (add-hook 'magit-mode-hook 'gitmoji-commit-mode)
  :init
  (setq magit-gpg-secret-key-hist nil)
  (setq magit-read-gpg-secret-key "prompt")
  :defer t
  )
(use-package magit-popup
  :ensure t
  :after (magit))
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
    (let ((info '(:internal-border-width 8 :background-color "black")))
      (or (plist-get info arg-name) value)))
  )
(use-package which-key-posframe
  :ensure t
  :init
  (which-key-posframe-enable)
  :config
  (which-key-posframe-mode)
  (setq which-key-posframe-poshandler 'posframe-poshandler-frame-top-center)
  )

(use-package csharp-mode
  :ensure t
  :after (company)
  :mode ("\\.cs" . csharp-mode)
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

;; (use-package auto-complete
;;   :ensure t
;;   :config
;;   (ac-config-default)
;;   )

(use-package multi-term
  :ensure t
  :config
  (setq multi-term-program "/bin/zsh")
  
  )

;; (use-package magit-todos
;;   :ensure t
;;   )
(use-package hl-todo
  :ensure t
  :config
  (setq hl-todo-keyword-faces
	'(("TODO"   . "#FF0000")
	  ("FIX"  . "#FF0000")
	  ("FEATURE"  . "#A020F0")
	  ))
  (define-key hl-todo-mode-map (kbd "C-c p") 'hl-todo-previous)
  (define-key hl-todo-mode-map (kbd "C-c n") 'hl-todo-next)
  (define-key hl-todo-mode-map (kbd "C-c o") 'hl-todo-occur)
  (define-key hl-todo-mode-map (kbd "C-c i") 'hl-todo-insert)
  )

;; (use-package comment-tags
;;   :ensure t
;;   :config
;;   (add-hook 'prog-mode-hook 'comment-tags-mode)
;;   (setq comment-tags-keymap-prefix (kbd "C-c #"))
;;   (setq comment-tags-keyword-faces
;;         `(("TODO" . ,(list :weight 'bold :foreground "#28ABE3"))
;;           ("FIXME" . ,(list :weight 'bold :foreground "#DB3340"))
;;           ("BUG" . ,(list :weight 'bold :foreground "#DB3340"))
;;           ("HACK" . ,(list :weight 'bold :foreground "#E8B71A"))
;;           ("KLUDGE" . ,(list :weight 'bold :foreground "#E8B71A"))
;;           ("XXX" . ,(list :weight 'bold :foreground "#F7EAC8"))
;;           ("INFO" . ,(list :weight 'bold :foreground "#F7EAC8"))
;;           ("DONE" . ,(list :weight 'bold :foreground "#1FDA9A"))))
;;   (setq comment-tags-comment-start-only t
;;         comment-tags-require-colon t
;;         comment-tags-case-sensitive t
;;         comment-tags-show-faces t
;;         comment-tags-lighter nil)
;;   )
(defun chunyang-switch-input-source ()
  "在「简体拼音」和「美国」之间切换."
  (interactive)
  (let ((US "com.apple.keylayout.US")
        (CN "com.apple.inputmethod.SCIM.ITABC"))
    (pcase (mac-input-source)
      ((pred (string= US)) (mac-select-input-source CN))
      ((pred (string= CN)) (mac-select-input-source US)))))

;; (defun maple/mac-switch-input-source ()
;;   (interactive)
;;     (shell-command
;;      "osascript -e 'tell application \"System Events\" to tell process \"SystemUIServer\"
;;       set currentLayout to get the value of the first menu bar item of menu bar 1 whose description is \"text input\"
;;       if currentLayout is not \"ABC\" then
;;         tell (1st menu bar item of menu bar 1 whose description is \"text input\") to {click, click (menu 1'\"'\"'s menu item \"ABC\")}
;;       end if
;;     end tell' &>/dev/null"))
;;   (add-hook 'focus-in-hook 'maple/mac-switch-input-source)


(use-package mark-multiple
  :ensure t)
(use-package annalist
  :ensure t)			

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config
  (setq dumb-jump-force-searcher 'ag)
  ;; (setq dumb-jump-selector 'helm)
  :ensure t)

;; (use-package leetcode
;;   :ensure t
;;   :config
;;   (setq leetcode-prefer-language "c++")
;;   (setq request-message-level 'debug)
;;   (setq request-log-level 'debug)
;;   (setq leetcode-prefer-sql "mysql")
;;   )
;;go lang develop env
(use-package go-autocomplete
  :ensure t
  :after go-mode
  ) 
(use-package smart-jump
  :ensure t
  :config
  (smart-jump-setup-default-registers))

(use-package smart-comment
  :ensure t
  :config
  (setq comment-multi-line "*")
  :bind ("M-;" . smart-comment)
  )

(use-package go-mode
  :ensure t
  :mode (("\\.go\\'" . go-mode))
  ;; :hook ((before-save . gofmt-before-save))
  :config
  (add-to-list 'auto-mode-alist '("\\.go$" . hs-minor-mode))
  (setq gofmt-command "goimports")

  (use-package company-go
    :ensure t
    :after(go-autocomplete go-mode)
    :config
    (add-hook 'go-mode-hook (lambda()
			      (add-to-list (make-local-variable 'company-backends)
					   '(company-go company-files company-yasnippet company-capf))))
    )
  (use-package go-dlv
    :ensure t
    :after (go-mode)
    )
  (use-package go-eldoc
    :ensure t
    :hook (go-mode . go-eldoc-setup)
    )
  (use-package go-guru
    :ensure t
    :after (go-mode)
    :hook (go-mode . go-guru-hl-identifier-mode)
    )
  (use-package go-rename
    :after (go-mode)
    :ensure t)
  )

(use-package sudo-edit
  :ensure t
  )

(use-package emojify
  :ensure t
  :config
  (add-hook 'after-init-hook #'global-emojify-mode)
  )

(defun eiio/input_switch()
  (interactive)
  ;; (multi-term-program "osascript ~/Documents/AppleMacOSScript.scpt")
  ;;(shell-command-to-string "/bin/echo hello")
  (setq multi-term-program "/usr/bin/osascript ~/Documents/AppleMacOSScript.scpt")
  ;; (setq my_shell_output (substring (shell-command-to-string "osascript  ~/Documents/AppleMacOSScript.scpt")))
  ;; (message my_shell_output)
  )
(global-set-key (kbd "M-\\")  'eiio/input_switch)

(use-package markdown-mode
  :ensure t
  :mode (("README\\.md\\'" . gfm-mode)
         ("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode))
  :init (setq markdown-command "multimarkdown"))
;; (global-set-key (kbd "C-c o i") 'eiio/omnifoucs)
(use-package yaml-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.yml\\'" . yaml-mode))
  (add-hook 'yaml-mode-hook
	    '(lambda ()
	       (define-key yaml-mode-map "\C-m" 'newline-and-indent)))
  )

(use-package indent-guide
  :ensure t
  :init
  (indent-guide-global-mode)
  :config
  (setq indent-guide-recursive nil);; (set-face-background 'indent-guide-face "dimgray")
  ;; (setq indent-guide-delay 0.5)
  )
(use-package aggressive-indent
  :ensure t
  :config
  (global-aggressive-indent-mode 1)
  (add-to-list 'aggressive-indent-excluded-modes 'typescript-mode)
  )

(use-package dired-imenu
  :ensure t
  )
(use-package imenu-anywhere
  :ensure t
  )
(use-package goto-line-preview
  :ensure t
  :config
  (global-set-key [remap goto-line] 'goto-line-preview)
  )
(use-package centaur-tabs
  :demand
  :config
  (centaur-tabs-mode t)
  (setq uniquify-separator "/")
  (setq uniquify-buffer-name-style 'forward)
  (defun centaur-tabs-buffer-groups ()
    "`centaur-tabs-buffer-groups' control buffers' group rules.

 Group centaur-tabs with mode if buffer is derived from `eshell-mode' `emacs-lisp-mode' `dired-mode' `org-mode' `magit-mode'.
 All buffer name start with * will group to \"Emacs\".
 Other buffer group by `centaur-tabs-get-group-name' with project name."
    (list
     (cond
      ;; ((not (eq (file-remote-p (buffer-file-name)) nil))
      ;; "Remote")
      ((or (string-equal "*" (substring (buffer-name) 0 1))
	   (memq major-mode '(magit-process-mode
			      magit-status-mode
			      magit-diff-mode
			      magit-log-mode
			      magit-file-mode
			      magit-blob-mode
			      magit-blame-mode
			      )))
       "Emacs")
      ((derived-mode-p 'prog-mode)
       "Editing")
      ((derived-mode-p 'dired-mode)
       "Dired")
      ((memq major-mode '(helpful-mode
			  help-mode))
       "Help")
      ((memq major-mode '(org-mode
			  org-agenda-clockreport-mode
			  org-src-mode
			  org-agenda-mode
			  org-beamer-mode
			  org-indent-mode
			  org-bullets-mode
			  org-cdlatex-mode
			  org-agenda-log-mode
			  diary-mode))
       "OrgMode")
      (t
       (centaur-tabs-get-group-name (current-buffer))))))
  (centaur-tabs-headline-match)
  :init
  ;; (setq centaur-tabs--buffer-show-groups t)
  (setq centaur-tabs-cycle-scope 'tabs)
  (setq centaur-tabs-plain-icons t)
  (setq centaur-tabs-set-icons t)
  (setq centaur-tabs-height 32)
  (setq centaur-tabs-style "bar")
  (setq centaur-tabs-set-bar 'left)
  (setq centaur-tabs-gray-out-icons 'buffer)
  (setq centaur-tabs-set-modified-marker t)
  (setq centaur-tabs-modified-marker "")
  (setq x-underline-at-descent-line t)
  :bind
  (:map evil-normal-state-map
	("g t" . centaur-tabs-forward)
	("g T" . centaur-tabs-backward)
	)
  :hook
  (dired-mode . centaur-tabs-local-mode)
  (term-mode . centaur-tabs-local-mode)
  (dashboard-mode . centaur-tabs-local-mode)
  (org-agenda-mode . centaur-tabs-local-mode)
  (helpful-mode . centaur-tabs-local-mode)
  )


(use-package pyim
  :ensure t
  :demand t
  :config
  ;; 激活 basedict 拼音词库，五笔用户请继续阅读 README
  (use-package pyim-basedict
    :ensure t
    :config (pyim-basedict-enable))

  (setq default-input-method "pyim")
  (setq pyim-page-style 'one-line)
  (define-key pyim-mode-map "." 'pyim-page-next-page)
  (define-key pyim-mode-map "," 'pyim-page-previous-page)
  ;; 我使用全拼
  (global-set-key (kbd "C-\\") 'toggle-input-method)
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

  ;; ;; 开启拼音搜索功能
  (pyim-isearch-mode 1)

  ;; 使用 popup-el 来绘制选词框, 如果用 emacs26, 建议设置
  ;; 为 'posframe, 速度很快并且菜单不会变形，不过需要用户
  ;; 手动安装 posframe 包。
  (setq pyim-page-tooltip 'posframe)
  ;; 选词框显示5个候选词
  (setq pyim-page-length 9)

  :bind
  (:map evil-insert-state-map
	("C-;" . pyim-convert-string-at-point) ;与 pyim-probe-dynamic-english 配合
	)
  )

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-names-vector
   ["#282a36" "#ff5555" "#50fa7b" "#f1fa8c" "#61bfff" "#ff79c6" "#8be9fd" "#f8f8f2"])
 '(beacon-color "#7abcf8")
 '(comment-auto-fill-only-comments t)
 '(comment-multi-line t)
 '(comment-style (quote multi-line))
 '(custom-safe-themes
   (quote
    ("6a0d7f41968908e25b2f56fa7b4d188e3fc9a158c39ef680b349dccffc42d1c8" "76bfa9318742342233d8b0b42e824130b3a50dcc732866ff8e47366aed69de11" "92d8a13d08e16c4d2c027990f4d69f0ce0833c844dcaad3c8226ae278181d5f3" "cb477d192ee6456dc2eb5ca5a0b7bd16bdb26514be8f8512b937291317c7b166" "427fa665823299f8258d8e27c80a1481edbb8f5463a6fb2665261e9076626710" "e3c87e869f94af65d358aa279945a3daf46f8185f1a5756ca1c90759024593dd" "4e132458143b6bab453e812f03208075189deca7ad5954a4abb27d5afce10a9a" "155a5de9192c2f6d53efcc9c554892a0d87d87f99ad8cc14b330f4f4be204445" "b0fd04a1b4b614840073a82a53e88fe2abc3d731462d6fde4e541807825af342" "ace9f12e0c00f983068910d9025eefeb5ea7a711e774ee8bb2af5f7376018ad2" "e9df267a1c808451735f2958730a30892d9a2ad6879fb2ae0b939a29ebf31b63" "274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e" default)))
 '(dumb-jump-mode t)
 '(evil-collection-company-use-tng t)
 '(evil-collection-ivy-setup t t)
 '(evil-collection-outline-setup t t)
 '(evil-collection-setup-minibuffer t)
 '(evil-collection-term-sync-state-and-mode-p t)
 '(fci-rule-color "#6272a4")
 '(global-highlight-changes-mode nil)
 '(iswitchb-mode t)
 '(jdee-db-active-breakpoint-face-colors (cons "#1E2029" "#bd93f9"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#1E2029" "#50fa7b"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#1E2029" "#565761"))
 '(mini-frame-mode nil)
 '(mini-frame-show-parameters
   (quote
    ((top . 0)
     (width . 0.5)
     (left . 0.5)
     (height . 15))))
 '(objed-cursor-color "#ff5555")
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
    (company-lua flymake-lua pyim history centaur-tabs linum-relative goto-line-preview ivy-imenu-anywhere smart-mode-line ace-popup-menu ac-helm helm-migemo mini-frame popup-switcher helm-frame imenu-anywhere imenus popup-imenu helm-swoop ace-jump-helm-line helm-ag helm-projectile helm-posframe helm lua-mode ivy-explorer ivy-avy magit-todos hl-todo mu4e-jump-to-list dired-imenu flycheck-posframe kaolin-themes beacon focus aggressive-indent indent-guide evil-vimish-fold yaml-imenu telephone-line sml-mode super-save real-auto-save exec-path-from-shell smart-comment transient-draw transient-dwim magit-popup pinentry paredit magit company-posframe diminish smart-jump dumb-jump ag evil-magit evil-org mark-multiple omnisharp csharp-mode dashboard auto-complete auto-package-update evil-matchit edit-indirect evil-markdown fcitx org-clock-convenience markdown-mode json-mode indium hydra-posframe which-key-posframe col-highlight symbol-overlay evil-commentary annalist hydra-ivy ivy-hydra 0blayout yaml-mode snails emojify o-blog all-the-icons-gnus go-autocomplete ace-jump-mode doom-modeline doom-themes sudo-edit go-dlv go-rename go-guru go-eldoc company-go go-mode leetcode evil-collection evil company-tabnine counsel-projectile counsel swiper eglot comment-tags multi-term ox-hugo spaceline-all-the-icons-theme winum anzu spaceline-all-the-icons all-the-icons-dired neotree posframe easy-hugo lsp-javascript-typescript ob-typescript org-recipes org-wiki org-bullets org-super-agenda htmlize org-mime company magit-svn ace-window which-key all-the-icons powerline projectile function-args yasnippet web avy osx-dictionary goto-chg undo-tree flycheck-status-emoji)))
 '(pdf-view-midnight-colors (cons "#f8f8f2" "#282a36"))
 '(projectile-mode t nil (projectile))
 '(rustic-ansi-faces
   ["#282a36" "#ff5555" "#50fa7b" "#f1fa8c" "#61bfff" "#ff79c6" "#8be9fd" "#f8f8f2"])
 '(smtpmail-smtp-server "smtp.exmail.qq.com")
 '(smtpmail-smtp-service 25)
 '(super-save-mode t)
 '(vc-annotate-background "#282a36")
 '(vc-annotate-color-map
   (list
    (cons 20 "#50fa7b")
    (cons 40 "#85fa80")
    (cons 60 "#bbf986")
    (cons 80 "#f1fa8c")
    (cons 100 "#f5e381")
    (cons 120 "#face76")
    (cons 140 "#ffb86c")
    (cons 160 "#ffa38a")
    (cons 180 "#ff8ea8")
    (cons 200 "#ff79c6")
    (cons 220 "#ff6da0")
    (cons 240 "#ff617a")
    (cons 260 "#ff5555")
    (cons 280 "#d45558")
    (cons 300 "#aa565a")
    (cons 320 "#80565d")
    (cons 340 "#6272a4")
    (cons 360 "#6272a4")))
 '(vc-annotate-very-old-color nil)
 '(vimish-fold-global-mode t)
 '(vimish-fold-include-last-empty-line t)
 '(vimish-fold-persist-on-saving t)
 '(vimish-fold-show-lines t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-battery-normal ((t (:inherit mode-line :weight bold :height 1.2 :width normal))))
 '(minibuffer-prompt ((t (:foreground "#ff79c6" :weight bold))))
 '(mode-line ((t (:family "Source Code Pro Medium" :background "#44475a" :box (:line-width 1 :color "#44475a") :height 160))))
 '(mode-line-buffer-id ((t (:weight bold :height 1.0))))
 '(mode-line-emphasis ((t (:weight bold :height 1.0))))
 '(mode-line-highlight ((t (:box (:line-width 2 :color "grey40" :style released-button)))))
 '(mode-line-inactive ((t (:background "#373844" :foreground "#6583a0" :box (:line-width 1 :color "#373844") :height 160 :family "Source Code Pro Medium"))))
 '(spaceline-all-the-icons-info-face ((t (:foreground "#63B2FF" :height 1.0))))
 '(spaceline-all-the-icons-sunrise-face ((t (:inherit powerline-active2 :foreground "#f6c175" :height 1.2))))
 '(spaceline-all-the-icons-sunset-face ((t (:inherit powerline-active2 :foreground "#fe7714"))))
 '(vimish-fold-fringe ((t (:foreground "#ff79c6" :family "Source Code Pro Medium"))))
 '(vimish-fold-overlay ((t (:inherit font-lock-comment-face :background "#1E2029" :weight light :family "Source Code Pro Medium")))))

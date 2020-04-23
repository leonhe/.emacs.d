
;; -*-byte-compile-dynamic: t;-*-
;;; Code:
(setq gc-cons-threshold 100000000)
(add-to-list 'load-path "~/.emacs.d/local-lisp/")
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
(require 'init-org-mode)
(require 'init-js)
(require 'init-blog)
(require 'gitmoji-commit)
;;(require 'init-ivy)
(scroll-bar-mode -1)

(set-frame-font "Source Code Pro Medium-16")
;; (set-fontset-font t 'han (font-spec :family "Source Code Pro Medium" :size 16))
(set-face-attribute 'default nil :family "Source Code Pro Medium" :height 160 )
;; (set-fontset-font t 'han (font-spec :family "PingFang SC" :size 16))
 ;; (add-hook 'after-make-frame-functions (lambda ()
;; 					(set-frame-font "Source Code Pro Medium-16")
;; 					))
;; (setq shell-file-name "/usr/local/bin")
 ;; (setenv "PATH" (concat (getenv "PATH") ":/usr/local/bin:/usr/local/bin:$HOME/GoWorks/bin"))
 ;; (setq exec-path (append exec-path '("/usr/local/bin")))

 (add-to-list 'load-path (expand-file-name "~/.emacs.d/local/snails/"))

(require 'snails)
  (defun open-snails()
    (interactive)
    (snails '(snails-backend-buffer snails-backend-recentf snails-backend-imenu snails-backend-current-buffer snails-backend-projectile snails-backend-mdfind) t)
    )
;; ;; setting theme
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

      ;; Whether display icons for buffer states. It respects `doom-modeline-icon'/i：“w”.
      (setq doom-modeline-buffer-state-icon t)
;; Whether display `lsp' state or not. Non-nil to display in mode-line.
      (setq doom-modeline-lsp t)
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

(use-package auto-complete
  :ensure t
  :init
  (ac-config-default)
  (global-auto-complete-mode)
  )
;; (use-package helm-posframe
;;   :ensure t
;;   :after ( helm)
;;   :init 
;;   (helm-posframe-enable)
;;   :config
;;   (setq helm-posframe-parameters
;;       '((left-fringe . 10)
;; 	(right-fringe . 10)))
;;   (setq helm-posframe-poshandler 'posframe-poshandler-frame-bottom-center)
;;   )

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

(use-package helm-projectile
  :ensure t
  :after (helm)
  :config
    (helm-projectile-on)
  )
;; (use-package helm-git
;;   :ensure t
;;   :after (helm))

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

(use-package helm-ag
  :ensure t
  :after helm)

(use-package ace-jump-helm-line
  :ensure t
  :after helm
  :init
  (setq ace-jump-helm-line-keys (number-sequence ?a ?z))
  (setq ace-jump-helm-line-style 'at)
  (setq ace-jump-helm-line-default-action 'select)
  (setq ace-jump-helm-line-background t)
  (setq ace-jump-helm-line-autoshow-use-linum t)
  )
(use-package helm-swoop
  :ensure t
  :after helm
  :config
  ;; Change the keybinds to whatever you like :)
  (global-set-key (kbd "M-i") 'helm-swoop)
  (global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
  (global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
  (global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)

  ;; When doing isearch, hand the word over to helm-swoop
  (define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
  ;; From helm-swoop to helm-multi-swoop-all
  (define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
  ;; When doing evil-search, hand the word over to helm-swoop
  ;; (define-key evil-motion-state-map (kbd "M-i") 'helm-swoop-from-evil-search)

  ;; Instead of helm-multi-swoop-all, you can also use helm-multi-swoop-current-mode
  (define-key helm-swoop-map (kbd "M-m") 'helm-multi-swoop-current-mode-from-helm-swoop)

  ;; Move up and down like isearch
  (define-key helm-swoop-map (kbd "C-r") 'helm-previous-line)
  (define-key helm-swoop-map (kbd "C-s") 'helm-next-line)
  (define-key helm-multi-swoop-map (kbd "C-r") 'helm-previous-line)
  (define-key helm-multi-swoop-map (kbd "C-s") 'helm-next-line)

  ;; Save buffer when helm-multi-swoop-edit complete
  (setq helm-multi-swoop-edit-save t)

  ;; If this value is t, split window inside the current window
  (setq helm-swoop-split-with-multiple-windows nil)

  ;; Split direcion. 'split-window-vertically or 'split-window-horizontally
  (setq helm-swoop-split-direction 'split-window-vertically)

  ;; If nil, you can slightly boost invoke speed in exchange for text color
  (setq helm-swoop-speed-or-color nil)

  ;; ;; Go to the opposite side of line from the end or beginning of line
  (setq helm-swoop-move-to-line-cycle t)

  ;; Optional face for line numbers
  ;; Face name is `helm-swoop-line-number-face`
  (setq helm-swoop-use-line-number-face t)

  ;; If you prefer fuzzy matching
  (setq helm-swoop-use-fuzzy-match t)

  ;; If you would like to use migemo, enable helm's migemo feature
  ;; (helm-migemo-mode 1)
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
;; (use-package hydra
;;   :ensure t
;;   :config
;;   (defhydra hydra-zoom (global-map "<f2>")
;;   "zoom"
;;   ("g" text-scale-increase "in")
;;   ("l" text-scale-decrease "out"))

;;   (defhydra hydra-window(:color pink
;; 			 :hint nil)
;;   "
;; -----------------------------------------------------------------                        
;; _j_: scroll down   _k_: scroll up          
;; -----------------------------------------------------------------                        
;; "
;;     ("j"  scroll-other-window-down)
;;     ("k"  scroll-other-window)
;;     ("q" nil "quit")      
;;     )
;;   ;;base key
;;   (defhydra hydra-base(:color red
;; 			      :hint nil
;; 			      )
;;     "
;; ^Char^             ^Move^           ^Windows^          ^Search
;; ^^^^^^^^-----------------------------------------------------------------
;; _g_: goto char          _u_: move up        _j_: other window down       ^ ^ 
;; _s_: shell          _d_: move down     _k_: other windows up          ^ ^ 
;; "
;;     ("j"  scroll-other-window-down)
;;     ("k"  scroll-other-window)
;;     ("d" move-text-down)
;;     ("u" move-text-up)
;;     ("g" avy-goto-char)
;;     ("s" multi-term)
;;     ("q" nil "quit")      
;;     )
;;   )

;; (use-package hydra-posframe
;;   :load-path "~/.emacs.d/local-package/hydra-posframe/"
;;   :hook (after-init . hydra-posframe-enable)
  
;; n  )

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
;; (define-key projectile-command-map "p" '("s" . projectile-switch-project))
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
  (setq magit-gpg-secret-key-hist nil)

  :defer t
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
    (let ((info '(:internal-border-width 8 :background-color "black")))
      (or (plist-get info arg-name) value)))
  )
(use-package which-key-posframe
  :ensure t
  :init
  (which-key-posframe-enable)
  :config
  (which-key-posframe-mode)
  (setq which-key-posframe-poshandler 'posframe-poshandler-frame-bottom-center)
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

(use-package auto-complete
  :ensure t
  :config
  (ac-config-default)
  )

(use-package multi-term
  :ensure t
  :config
  (setq multi-term-program "/usr/local/fish")
  
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
(defun chunyang-switch-input-source ()
  "在「简体拼音」和「美国」之间切换."
  (interactive)
  (let ((US "com.apple.keylayout.US")
        (CN "com.apple.inputmethod.SCIM.ITABC"))
    (pcase (mac-input-source)
      ((pred (string= US)) (mac-select-input-source CN))
      ((pred (string= CN)) (mac-select-input-source US)))))

(defun maple/mac-switch-input-source ()
  (interactive)
    (shell-command
     "osascript -e 'tell application \"System Events\" to tell process \"SystemUIServer\"
      set currentLayout to get the value of the first menu bar item of menu bar 1 whose description is \"text input\"
      if currentLayout is not \"ABC\" then
        tell (1st menu bar item of menu bar 1 whose description is \"text input\") to {click, click (menu 1'\"'\"'s menu item \"ABC\")}
      end if
    end tell' &>/dev/null"))
  (add-hook 'focus-in-hook 'maple/mac-switch-input-source)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  :bind (:map evil-normal-state-map
	      ("SPC e" . hydra-base/body)
	      ("SPC u" . undo-tree-visualize)
	      ("SPC m" . helm-global-mark-ring)
	      ("SPC x" . helm-M-x)
	      ("SPC f" . open-snails)
	      ("SPC b" . switch-to-buffer)
	      ("SPC k" . kill-buffer)
	      ("SPC p" . projectile-command-map)
	      ("SPC q" . fullscreen)
	      ("SPC l" . helm-imenu)
	      ("SPC c l" . avy-copy-line)
	      ("SPC c r" . avy-copy-region)
	      ("SPC c m" . avy-move-line)
	      ("SPC c a" . avy-move-region)
	      ("SPC i" . toggle-input-method)
	      ("g c" . avy-goto-char)
	      ("gll" . avy-goto-line)
	      ("glu" . avy-goto-line-above)
	      ("gld" . avy-goto-line-below)
	      ("SPC d" . eiio/load_init_file)
	      ("SPC s" . multi-term)
	      ("SPC g a" . helm-do-grep-ag)
	      ;; excute action
	      ("SPC t l" . transpose-lines)
	       ("SPC t c" . transpose-chars)
	      ))

(use-package mark-multiple
  :ensure t)
(use-package evil-markdown
  :load-path "~/.emacs.d/local-package/evil-markdown/"
  :after (evil markdown)
 ) 

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
(use-package annalist
  :ensure t)			
(use-package evil-collection
  :after evil
  :ensure t
  :load-path "~/.emacs.d/local-package/evil-collection"
  :custom (
	   (evil-collection-setup-minibuffer t)
	   (evil-collection-outline-setup t)
	   )
  :config
  (evil-collection-define-key 'normal 'tide-mode-map
    "go" 'tide-fix
    "grs" 'tide-rename-symbol
    "grf" 'tide-rename-file
    "grd" 'tide-rename-symbol-at-location
    )
  (evil-collection-init)
  )
(use-package evil-matchit
  :ensure t
  :init
  (global-evil-matchit-mode 1))
 (use-package ag
  :ensure t)

(use-package dumb-jump
  :bind (("M-g o" . dumb-jump-go-other-window)
         ("M-g j" . dumb-jump-go)
         ("M-g i" . dumb-jump-go-prompt)
         ("M-g x" . dumb-jump-go-prefer-external)
         ("M-g z" . dumb-jump-go-prefer-external-other-window))
  :config
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
(use-package smart-jump
  :ensure t
  :config
  (smart-jump-setup-default-registers))

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
    ("92d8a13d08e16c4d2c027990f4d69f0ce0833c844dcaad3c8226ae278181d5f3" "cb477d192ee6456dc2eb5ca5a0b7bd16bdb26514be8f8512b937291317c7b166" "427fa665823299f8258d8e27c80a1481edbb8f5463a6fb2665261e9076626710" "e3c87e869f94af65d358aa279945a3daf46f8185f1a5756ca1c90759024593dd" "4e132458143b6bab453e812f03208075189deca7ad5954a4abb27d5afce10a9a" "155a5de9192c2f6d53efcc9c554892a0d87d87f99ad8cc14b330f4f4be204445" "b0fd04a1b4b614840073a82a53e88fe2abc3d731462d6fde4e541807825af342" "ace9f12e0c00f983068910d9025eefeb5ea7a711e774ee8bb2af5f7376018ad2" "e9df267a1c808451735f2958730a30892d9a2ad6879fb2ae0b939a29ebf31b63" "274fa62b00d732d093fc3f120aca1b31a6bb484492f31081c1814a858e25c72e" default)))
 '(dumb-jump-mode t)
 '(evil-collection-outline-setup t t)
 '(evil-collection-setup-minibuffer t)
 '(global-highlight-changes-mode nil)
 '(helm-completion-style (quote emacs))
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
    (paredit magit helm company-posframe diminish smart-jump dumb-jump ag evil-magit evil-org mark-multiple omnisharp csharp-mode ace-jump-helm-line helm-ag helm-projectile dashboard auto-complete auto-package-update evil-matchit edit-indirect evil-markdown fcitx helm-rg helm-swoop org-clock-convenience markdown-mode json-mode indium hydra-posframe which-key-posframe helm-posframe col-highlight symbol-overlay evil-commentary annalist hydra-ivy ivy-hydra 0blayout yaml-mode snails exec-path-from-shell emojify o-blog all-the-icons-gnus go-autocomplete ace-jump-mode doom-modeline doom-themes sudo-edit go-dlv go-rename go-guru go-eldoc company-go go-mode leetcode evil-collection evil company-tabnine counsel-projectile counsel swiper eglot comment-tags multi-term ox-hugo spaceline-all-the-icons-theme winum anzu spaceline-all-the-icons all-the-icons-dired neotree posframe easy-hugo lsp-javascript-typescript ob-typescript org-recipes org-wiki org-bullets org-super-agenda htmlize org-mime company magit-svn ace-window which-key all-the-icons powerline projectile function-args yasnippet web avy osx-dictionary goto-chg undo-tree flycheck-status-emoji)))
 '(projectile-mode t nil (projectile)))
   
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(doom-modeline-battery-normal ((t (:inherit mode-line :weight bold :height 1.2 :width normal))))
 '(minibuffer-prompt ((t (:foreground "#ff79c6" :weight bold))))
 '(mode-line ((t (:background "#44475a" :box (:line-width 1 :color "#44475a") :height 140))))
 '(mode-line-buffer-id ((t (:weight bold :height 1.0))))
 '(mode-line-emphasis ((t (:weight bold :height 1.0))))
 '(mode-line-highlight ((t (:box (:line-width 2 :color "grey40" :style released-button)))))
 '(mode-line-inactive ((t (:background "#373844" :foreground "#f8f8f2" :box (:line-width 1 :color "#373844")))))
 '(spaceline-all-the-icons-info-face ((t (:foreground "#63B2FF" :height 1.0))))
 '(spaceline-all-the-icons-sunrise-face ((t (:inherit powerline-active2 :foreground "#f6c175" :height 1.2))))
 '(spaceline-all-the-icons-sunset-face ((t (:inherit powerline-active2 :foreground "#fe7714")))))

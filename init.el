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
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")

  (require 'use-package)
  (require 'init-base)
  )

;;打开配置文件
(global-set-key (kbd "<f2>") (lambda () (interactive) (open-init-file "~/.emacs.d/init.el")))

;;add init file reload
(defun eiio/load_init_file()
  (interactive)
  (load-file "~/.emacs.d/init.el")
)
(global-set-key (kbd "<f1>") 'eiio/load_init_file)

;;theme
(use-package 'dracula-theme
  :ensure t
  :init
  (load-theme 'dracula t)
  )


(use-package flycheck-status-emoji
  :ensure t
  :init
  (setq flycheck-status-emoji-mode t)
  )
(use-package projectile
  :ensure t
  :init
  (projectile-mode t)
  )
(use-package helm
  :ensure t
  :after projectile
  :init
  (helm-mode 1)
  ;;(helm-gtags-mode 1)
  ;;(helm-projectile-on)
  (helm-autoresize-mode 1)
  :bind(
	("M-x" . 'helm-M-x)
	  ("C-x c h" . helm-register)
	  ("C-x c g d" . helm-do-grep-ag)
	  ("C-x c g p" . helm-do-ag-project-root)
	  ("C-x c g f" . helm-do-ag-this-file)
	  ("C-x c g b" . helm-do-ag-buffers)
	  ("C-x c g g" . helm-do-ag)
	  ("M-." . helm-source-etags-select)
  ))
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
  )

;;web get
(use-package web
  :ensure t
  )

;;company-mode;; yasnippet
(use-package yasnippet
	     :ensure t
	     :init
	     (yas-global-mode 1)
	     (yas-reload-all)
	     :config
	     (add-to-list 'yas-snippet-dirs (locate-user-emacs-file "snippets")))

(use-package semantic
  :ensure t
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
    (dracula-theme projectile function-args yasnippet web avy osx-dictionary goto-chg undo-tree helm flycheck-status-emoji))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

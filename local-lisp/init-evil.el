;; evil-mode config
(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
  :bind (:map evil-normal-state-map
	      ("SPC u" . undo-tree-visualize)
	      ("SPC m" . helm-global-mark-ring)
	      ("SPC x" . counsel-M-x)
	      ("SPC f" . open-snails)
	      ("SPC b" . switch-to-buffer)
	      ("SPC k" . kill-buffer)
	      ("SPC p" . projectile-command-map)
	      ("SPC q" . fullscreen)
	      ("SPC l" . counsel-imenu)
	      ("SPC c l" . avy-copy-line)
	      ("SPC c r" . avy-copy-region)
	      ("SPC c m" . avy-move-line)
	      ("SPC c a" . avy-move-region)
	      ("SPC i" . toggle-input-method)
	      ("glc" . avy-goto-char)
	      ("gcl" . avy-copy-line)
	      ("gcr" . avy-copy-region)
	      ("gll" . avy-goto-line)
	      ("SPC d" . eiio/load_init_file)
	      ("SPC s" . multi-term)
	      ("SPC g a" . helm-do-grep-ag)
	      ;; excute action
	      ("SPC t c" . transpose-chars)
	      ("SPC t l" . ivy-magit-todos)
	      ("SPC e c" . eiio/comment-down-new-line)
	      ))

(use-package evil-commentary
  :ensure t
  :init (evil-commentary-mode)
  )
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
(use-package vimish-fold
  :ensure t
  :after evil
  :init
  (vimish-fold-global-mode 1)
  )

(use-package evil-vimish-fold
  :ensure t
  :init
  (setq evil-vimish-fold-mode-lighter "|")
  (setq evil-vimish-fold-target-modes '(typescript-mode prog-mode conf-mode text-mode))
  :config
  (global-evil-vimish-fold-mode))
(provide 'init-evil)

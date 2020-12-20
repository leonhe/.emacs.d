;; set prefix for lsp-command-keymap (few alternatives - "C-l", "C-c l")
(setq lsp-keymap-prefix "s-l")
(use-package lsp-mode
  :hook (;; replace XXX-mode with concrete major-mode(e. g. python-mode)
         (js-mode . lsp)
         ;; if you want which-key integration
         (lsp-mode . lsp-enable-which-key-integration))
  :commands lsp
  :init
  (setq lsp-message-project-root-warning t)
  (setq create-lockfiles nil)
  (setq lsp-enable-eldoc t)
  (setq lsp-auto-guess-root t lsp-prefer-flymake t)
  (setq lsp-response-timeout 20)
  (setq lsp-enable-completion-at-point t)
  (setq lsp-print-io t)
  )
(use-package company-box
  :hook (company-mode . company-box-mode))
;; optionally
;; (use-package lsp-ui :commands lsp-ui-mode)
;; if you are helm user
(use-package helm-lsp :commands helm-lsp-workspace-symbol)
;; if you are ivy user
(use-package lsp-treemacs :commands lsp-treemacs-errors-list)
(use-package company-lsp
  :ensure t
  :commands company-lsp
  :config
  ;; Enable LSP backend.
  (push 'company-lsp company-backends)
  )
(use-package dap-mode
  :ensure t
  :init
  (require 'dap-node)
  )
(provide 'init-lsp)
;;; init-lsp.el ends here

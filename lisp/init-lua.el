;;lua-mode
(autoload 'lua-mode "lua-mode" "Lua editiing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))

(setq mobdebug-lua-path "/Users/yuanfei/bin/mobdebug.sh")
(eval-after-load "lua-mode"
  '(progn
     (require 'mobdebug-mode nil t)
     ;; if you prefer evil mode
     (setq mobdebug-use-evil-binding t)))
  
(add-hook 'lua-mode-hook (lambda ()
			   (hs-minor-mode t)
			   (helm-gtags-mode t)
			   (require 'mobdebug-mode)			   
			   ))

(with-eval-after-load 'lua-mode
  (local-key-binding (kbd "<f8>") 'mobdebug-run)
  )
;; customize
(custom-set-variables
 '(helm-gtags-path-style 'relative)
 '(helm-gtags-ignore-case t)
 '(helm-gtags-auto-update t))

;; key bindings
(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
  (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
  (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
  (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack))
(provide 'init-lua)

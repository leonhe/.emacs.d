;;lua-mode
(autoload 'lua-mode "lua-mode" "Lua editiing mode." t)
(add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
(add-to-list 'interpreter-mode-alist '("lua" . lua-mode))
  
(add-hook 'lua-mode-hook (lambda ()
			   (hs-minor-mode t)
			   ;;(helm-gtags-mode t)
			   ))

;; customize
;; (custom-set-variables
;;  '(helm-gtags-path-style 'relative)
;;  '(helm-gtags-ignore-case t)
;;  '(helm-gtags-auto-update key))

;;  bindings
(with-eval-after-load 'helm-gtags
  (define-key helm-gtags-mode-map (kbd "M-t") 'helm-gtags-find-tag)
  (define-key helm-gtags-mode-map (kbd "M-r") 'helm-gtags-find-rtag)
  (define-key helm-gtags-mode-map (kbd "M-s") 'helm-gtags-find-symbol)
  (define-key helm-gtags-mode-map (kbd "M-g M-p") 'helm-gtags-parse-file)
  (define-key helm-gtags-mode-map (kbd "C-c <") 'helm-gtags-previous-history)
  (define-key helm-gtags-mode-map (kbd "C-c >") 'helm-gtags-next-history)
  (define-key helm-gtags-mode-map (kbd "M-,") 'helm-gtags-pop-stack))

(add-to-list 'load-path (expand-file-name "~/.emacs.d/local/mobdebug-mode/mobdebug-mode"))

(eval-after-load "lua-mode"
  '(progn
     (require 'mobdebug-mode nil t)
     (setq mobdebug-basedir "~/Works/UUGame/Resources/src/")
     ;; if you prefer evil mode
     (setq mobdebug-use-evil-binding t)

     ))

(provide 'init-lua)

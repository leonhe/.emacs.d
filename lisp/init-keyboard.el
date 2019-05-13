;;; init-keyboard.el --- keybaord key binds
;;; Commentary:
;;; Code:
(global-set-key [f8] 'neotree-toggle)
;;设置替换字符快捷键
(global-set-key (kbd "C-c C-r") 'replace-string)
(global-set-key (kbd "C-s") 'swiper)
;;F2键快速打开配置文件
(defun open-init-file(path)
  (interactive)
  (find-file path))
;;打开配置文件
(global-set-key (kbd "<f2>") (lambda () (interactive) (open-init-file "~/.emacs.d/init.el")))
;;打开RSS文件,并更新新闻列表
(global-set-key (kbd "C-c f") (lambda ()
				(interactive)
				(open-init-file "~/Documents/org/feed/news.org")
				(org-feed-update-all)))
;;打开最近编辑文件列表
(global-set-key (kbd "C-c r o") 'recentf-open-files)
;;grep
(global-set-key (kbd "C-c C-g d") 'find-grep-dired)
(global-set-key (kbd "C-c C-g l") 'find-grep)
(global-set-key (kbd "C-c C-g r") 'rgrep)
(global-set-key (kbd "C-c C-g z") 'zrgrep)
;;emms keyboard bind
(global-set-key (kbd "C-c e l") 'emms-play-playlist)
(global-set-key (kbd "C-c e s") 'emms-stop)
(global-set-key (kbd "C-c e p") 'emms-pause)
(global-set-key (kbd "C-c e n") 'emms-next)
(global-set-key (kbd "C-c e r") 'emms-random)
(global-set-key (kbd "C-c e a") 'emms-add-file)
(global-set-key (kbd "C-c e o") 'emms)
(global-set-key (kbd "C-c p r") 'compile)
(add-hook 'org-mode-hook (lambda ()
			   (interactive)
			   (global-set-key (kbd "C-c p s") 'org-pomodoro)
			   (global-set-key (kbd "C-c p t") 'org-pomodoro-count)
			   ))
;;develop keybind
(global-set-key (kbd "C-x C-f") 'counsel-find-file)
(global-set-key (kbd "<f12>") 'pomidor)
(global-set-key (kbd "M-g ,") 'dumb-jump-back)
;;window
(global-set-key (kbd "C-c w l") 'windmove-left)
(global-set-key (kbd "C-c w d") 'windmove-down)
(global-set-key (kbd "C-c w u") 'windmove-up)
(global-set-key (kbd "C-c w r") 'windmove-right)
(global-set-key (kbd "C-c C-w") 'switch-to-buffer-other-window)
;;macro
(global-set-key (kbd "C-x e") 'kmacro-call-macro)
(global-set-key (kbd "C-M-d") 'scroll-other-window-down)
;;move
(global-set-key (kbd "C-c C-x u" ) 'move-line-up)
(global-set-key (kbd "C-c C-x d" ) 'move-line-down)

;;hydra mode
(global-set-key (kbd "C-z")
		(defhydra hydra-vi (:pre (set-cursor-color "#40e0d0")
					 :post (progn
						 (set-cursor-color "#ffffff")
						 (message
						  "Thank you, come again.")))
		  "vi"
		  ("l" forward-char)
		  ("h" backward-char)
		  ("j" next-line)
		  ("k" previous-line)
		  ("w" forward-word)
		  ("b" backward-word)
		  ("D" kill-whole-line)
		  ("s" save-buffer)
		  ("mm" set-mark-command)
		  ("C-w" ace-window)
		  ("mm" set-mark-command)
		  ("u" undo)
		  ("ml" avy-move-line "avy move line")
		  ("mc" avy-goto-char)
		  ("g" avy-goto-line)
		  ("d" delete-char)
		  ("za" hs-toggle-hiding)
		  ("q" nil "quit"))
		
		)



(provide 'init-keyboard)
;;; init-keyboard.el ends here

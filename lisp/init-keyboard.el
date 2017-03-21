;;; init-keyboard.el --- keybaord key binds
;;; Commentary:
;;; Code:
;;设置替换字符快捷键
(global-set-key (kbd "C-c C-r") 'replace-string)
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
;;refrush buff
(global-set-key (kbd "C-c C-b f") 'eval-buffer)
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
;;(global-set-key (kbd "C-c p r") ')
(add-hook 'org-mode-hook (lambda ()
			   (interactive)
			   (global-set-key (kbd "C-c p s") 'org-pomodoro)
			   (global-set-key (kbd "C-c p t") 'org-pomodoro-count)
			   ))
(provide 'init-keyboard)

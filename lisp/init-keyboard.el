;;键盘快捷键配置
;;设置替换字符快捷键
(global-set-key (kbd "C-c C-r") 'replace-string)
;;F2键快速打开配置文件
(defun open-init-file(path)
  (interactive)
  (find-file path))
;;打开配置文件
(global-set-key (kbd "<f2>") (lambda () (interactive) (open-init-file "~/.emacs.d/init.el")))
;;打开ORG索引列表
(global-set-key (kbd "<f3>") (lambda () (interactive) (open-init-file "~/Documents/org/list.org")))
;;打开RSS文件,并更新新闻列表
(global-set-key (kbd "C-c f") (lambda ()
				(interactive)
				(open-init-file "~/Documents/org/feed/news.org")
				(org-feed-update-all)))
;;打开最近编辑文件列表
(global-set-key (kbd "C-c r o") 'recentf-open-files)
;;refrush buff
(global-set-key (kbd "C-c C-b f") 'eval-buffer)
(provide 'init-keyboard)

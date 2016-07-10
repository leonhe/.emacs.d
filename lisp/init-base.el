;;基础设置
(tool-bar-mode -1);;关闭顶部菜单栏
(display-time-mode 1);;开启时间显示
(set-keyboard-coding-system 'utf-8);;系统编码为UTF-8
(global-linum-mode) ;;开启全局文件行数显示
(global-font-lock-mode 1);;开启语法高亮
(setq column-number-mode 1);;开启编辑模式行数和列数显示
(setq make-backup-files nil);;关闭自动备份文件
(setq scroll-bar-columns 1)

;; Use C-tab to autocomplete the files and directories
;; based on the two commands `comint-dynamic-complete-filename`
;; and `comint-dynamic-list-filename-completions`
(defun atfd ()
  (interactive)
  (comint-dynamic-list-filename-completions)
  (comint-dynamic-complete-as-filename))
(global-set-key ( kbd "\C-c k" ) 'atfd)
(setq auto-save-default nil) ;;关闭自动保存文件
(global-auto-revert-mode 1);;加载外部修改过的文件
(require-package 'sudo-edit);;sudo编辑
;;F2键快速打开配置文件
(defun open-init-file()
  (interactive)
  (find-file "~/.emacs.d/init.el"))
(global-set-key (kbd "<f2>") 'open-init-file)
(provide 'init-base)

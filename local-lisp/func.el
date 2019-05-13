;;; func.el --- s                               -*- lexical-binding: t; -*-

;; Copyright (C) 2017  Yuanfei He

;; Author: Yuanfei He;;; init-base.el --- base file <hi@leonhe.me>
;; Keywords: Basemode ;;;
;;; Commentary:
;; 基础设置
;;; Code:
;;;add init file reload
(defun eiio/load_init_file()
  (interactive)
  (load-file (buffer-file-name))
)
; Use C-tab to autocomplete the files and directories

;; based on the two commands `comint-dynamic-complete-filename`
;; and `comint-dynamic-list-filename-completions`
(defun atfd ()
  ";; ."
  (interactive)
  (comint-dynamic-list-filename-completions)
  (comint-dynamic-complete-as-filename))

(defun eiio/win()
  ";;initilze windows."
  (interactive)
  (fullscreen)
  (split-window-right)
  (split-window-below)
  )

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

;add init file reload
(defun eiio/load_init_file()
  (interactive)
  (load-file (buffer-file-name))
)
(defun timestamp ()
   (interactive)
   (insert (format-time-string "%Y-%m-%d %H:%M:%S")))

(defun eiio/getFunctionName() 
  "Getting current function name."
  (interactive)
  (setq fun_name (which-function))
  (replace-regexp-in-string "[\s]method" "" fun_name)
  
)

(defun eiio/getClassName ()
  "Getting current class name."
  (interactive)
  (file-name-nondirectory (file-name-sans-extension (buffer-file-name)))
)

(defun fullscreen ()
      (interactive)
      (tool-bar-mode -1)
      (menu-bar-mode -1)
      (set-frame-parameter nil 'fullscreen
                           (if (frame-parameter nil 'fullscreen) nil 'fullboth)))


(provide 'func)
;;; init-base.el ends here

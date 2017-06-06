g;;; init-markdown.el --- markdown
;;; Commentary:
;;markdown mode initilze
;;; Code:
(autoload 'markdown-mode "markdown-mode" "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
(provide 'init-markdown)
;;; init-markdown.el ends here

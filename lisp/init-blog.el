;;; init-org-mode.el --- org mode configure
;;; Commentary:
;;; Code:
(setq easy-hugo-basedir "~/Note/blog/")
(setq easy-hugo-url "https://leonhe.me")
(setq easy-hugo-sshdomain "leonhe.me")
(setq easy-hugo-root "/var/www/html/")
(setq easy-hugo-previewtime "300")
(setq easy-hugo-default-ext ".org")
(define-key global-map (kbd "C-c C-e") 'easy-hugo)
(provide 'init-blog)
;;; init-blog.el ends here

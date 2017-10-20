;;; init-org-mode.el --- org mode configure
;;; Commentary:
;;; Code:
(setq easy-hugo-blog-number 2)
(setq easy-hugo-image-directory "img")
(setq easy-hugo-basedir "~/Note/blog/")
(setq easy-hugo-url "https://leonhe.me")
(setq easy-hugo-sshdomain "leonhe.me")
(setq easy-hugo-root "/var/www/html/")
(setq easy-hugo-previewtime "300")
(setq easy-hugo-default-ext ".org")
(define-key global-map (kbd "C-c C-e") 'easy-hugo)
(setq easy-hugo-basedir-1 "~/Note/wiki/")
(setq easy-hugo-url-1 "https://fei7.cc")
(setq easy-hugo-root-1 "/var/www/html/")
(setq easy-hugo-sshdomain-1 "fei7.cc#1383")


(provide 'init-blog)
;;; init-blog.el ends here

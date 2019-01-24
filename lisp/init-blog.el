;;; init-org-mode.el --- org mode configure
;;; Commentary:
;;; Code:

(setq easy-hugo-blog-number 2)
(setq easy-hugo-image-directory "img")
(setq easy-hugo-basedir "~/Org/blog/")
(setq easy-hugo-url "https://feiio.com")
(setq easy-hugo-sshdomain "feiio.com")
(setq easy-hugo-root "/var/www/html/")
(setq easy-hugo-previewtime "300")
(setq easy-hugo-default-ext ".org")
(define-key global-map (kbd "C-c C-e") 'easy-hugo)

(provide 'init-blog)
;;; init-blog.el ends here

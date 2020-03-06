;;; init-org-mode.el --- org mode configure
;;; Commentary:
;;; Code:
(use-package easy-hugo
  :ensure t
  :config
  (setq easy-hugo-org-header t)
  (setq easy-hugo-blog-number 2)
  (setq easy-hugo-image-directory "images")
  (setq easy-hugo-basedir "~/blog")
  (setq easy-hugo-url "https://feikl.com")
  (setq easy-hugo-sshdomain "feikl.com")
  (setq easy-hugo-root "/var/www/html/")
  (setq easy-hugo-previewtime "300")
  (setq easy-hugo-default-ext ".org")
  (setq easy-hugo-helm-ag t)
  (define-key global-map (kbd "C-c C-e") 'easy-hugo)
  )

;; (use-package ox-hugo
;;   :ensure t
;;   :after ox
;;   :config
;;   (require 'org-hugo-auto-export-mode)
;; ;;  :hook
;;   ;;(before-save . org-hugo-auto-export-mode)
;;   )

;; Populates only the EXPORT_FILE_NAME property in the inserted headline.
(with-eval-after-load 'org-capture
  (defun org-hugo-new-subtree-post-capture-template ()
    "Returns `org-capture' template string for new Hugo post.
See `org-capture-templates' for more information."
    (let* ((title (read-from-minibuffer "Post Title: ")) ;Prompt to enter the post title
           (fname (org-hugo-slug title)))
      (mapconcat #'identity
                 `(
                   ,(concat "* TODO " title)
                   ":PROPERTIES:"
                   ,(concat ":EXPORT_FILE_NAME: " fname)
                   ":END:"
                   "%?\n")          ;Place the cursor here finally
                 "\n")))

  (add-to-list 'org-capture-templates
               '("h"                ;`org-capture' binding + h
                 "Hugo post"
                 entry
                 ;; It is assumed that below file is present in `org-directory'
                 ;; and that it has a "Blog Ideas" heading. It can even be a
                 ;; symlink pointing to the actual location of all-posts.org!
                 (file+olp "~/Org/task/all-posts.org" "Blog Ideas")
                 (function org-hugo-new-subtree-post-capture-template))))

(provide 'init-blog)
;;; init-blog.el ends here

;;; init-org-mode.el --- org mode configure
;;; Commentary:
;;; Code:
(defun leon/easy-hugo ()
  (interactive)
  (evil-define-key
    (list 'normal 'insert 'visual 'motion)
    easy-hugo-mode-map
    "n" 'easy-hugo-newpost
    "D" 'easy-hugo-article
    "p" 'easy-hugo-preview
    "P" 'easy-hugo-publish
    "o" 'easy-hugo-open
    "d" 'easy-hugo-delete
    "e" 'easy-hugo-open
    "c" 'easy-hugo-open-config
    "f" 'easy-hugo-open
    "N" 'easy-hugo-no-help
    "v" 'easy-hugo-view
    "r" 'easy-hugo-refresh
    "g" 'easy-hugo-refresh
    "s" 'easy-hugo-sort-time
    "S" 'easy-hugo-sort-char
    "G" 'easy-hugo-github-deploy
    "A" 'easy-hugo-amazon-s3-deploy
    "C" 'easy-hugo-google-cloud-storage-deploy
    "q" 'evil-delete-buffer
    (kbd "TAB") 'easy-hugo-open
    (kbd "RET") 'easy-hugo-preview)
)
(use-package easy-hugo
  :ensure t
  :config
  (setq easy-hugo-org-header nil)
  (setq easy-hugo-server-flags "-D")
  (setq easy-hugo-blog-number 2)
  (setq easy-hugo-image-directory "images")
  (setq easy-hugo-basedir "~/Org/blog")
  (setq easy-hugo-url "https://hii8.com")
  (setq easy-hugo-sshdomain "hii8.com")
  (setq easy-hugo-root "/var/www/html/")
  (setq easy-hugo-previewtime "300")
  (setq easy-hugo-default-ext ".org")
  (setq easy-hugo-helm-ag t)
  (add-hook 'easy-hugo-mode-hook 'leon/easy-hugo)
  (global-key-binding  (kbd "C-c C-e") 'easy-hugo)
  )

(use-package ox-hugo
  :ensure t
  :after ox
  :config
  (require 'org-hugo-auto-export-mode)
  ;; :hook
  ;; (before-save . org-hugo-auto-export-mode)
  )

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
		   ":EXPORT_HUGO_CUSTOM_FRONT_MATTER: :header_images "
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
                 (file+olp "~/Org/all-posts.org" "Blog Ideas")
                 (function org-hugo-new-subtree-post-capture-template))))

(provide 'init-blog)
;;; init-blog.el ends here

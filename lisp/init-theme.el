;;; init-theme.el --- theme manager
;;; Commentary:
;;; Code:

(require 'powerline)

(add-hook 'after-init-hook '(lambda ()
			      (load-theme 'ample-zen t)
			      ;;(load-theme 'seti t)
			      ))

(powerline-default-theme)
(show-paren-mode t)
(defvar show-paren-style 'expression)
(set-frame-font "Source Code Pro Medium-18")

 (defface powerline-active1 '((t (:background "blue22" :inherit mode-line)))
   "Powerline face 1."
   :group 'powerline)

(provide 'init-theme)
;;; init-theme.el ends here

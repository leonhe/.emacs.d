;;; init-cplus --- C/C++ editor
;;; Commentary:
;;;(C/C++) program code editor mode config
;;; author: LeonHe <lhe868@gmail.com>
;;; Code:

(use-package company-c-headers
  :ensure t
  :after (company)
  :config
  (add-to-list 'company-backends 'company-c-headers)
  )
(use-package company-ctags
  :ensure t
  :after (company)
  :init
  (company-ctags-auto-setup))

(provide 'init-cplus)
;;; init-cplus.el ends here



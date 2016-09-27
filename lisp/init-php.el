;;; init-php.el --- PHP Mode
;;; Commentary:
;; This is php develop mode
;;; Code:
(require-package 'php-mode)
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))

(provide 'init-php)
;;; init-php ends here
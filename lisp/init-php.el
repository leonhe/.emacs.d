;;; init-php.el --- PHP Mode
;;; Commentary:
;; This is php develop mode
;;; Code:
(autoload 'php-mode "php-mode" "Major mode for editing php code." t)
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.inc$" . php-mode))
(add-hook 'php-mode-hook 'hs-minor-mode)
(provide 'init-php)
;;; init-php ends here

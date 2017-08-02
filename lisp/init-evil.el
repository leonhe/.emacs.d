;;; init-evil.el --- initilze evil-mode
;;; Commentary:
(require 'evil)
;;; Code:
(evil-mode 1)
(defvar my-leader-map (make-sparse-keymap)
  "Keymap for \"leader key\" shortcuts.")
(define-key evil-normal-state-map (kbd "SPC") my-leader-map)
(define-key my-leader-map "b" 'helm-buffers-list)
(define-key my-leader-map "k" 'kill-buffer)
(provide 'init-evil)
;;; init-evil.el ends here

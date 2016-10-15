;;; init-emms.el --- music player
;; Author: Leon He<leonhe86@gmail.com>
;; Version: 0.1

;;; Commentary:

;;; Code:
(require 'emms-setup)
(emms-all)
(emms-default-players)
(setq emms-source-file-default-directory "~/Music/")
(require 'emms-player-simple)
(require 'emms-source-file)
(require 'emms-source-playlist)
(require 'emms-i18n)
(require 'emms-mode-line)
(emms-mode-line 1)
(require 'emms-playing-time)
(emms-playing-time 1)

(define-emms-simple-player afplay '(file)
      (regexp-opt '(".mp3" ".m4a" ".aac"))
      "afplay")
(setq emms-player-list '(emms-player-mpg321
                         emms-player-ogg123
                         emms-player-afplay
			 ))
(setq emms-playlist-buffer-name "*Music Playing List*")

;; ;; format current track,only display title in mode line
;; (defun bigclean-emms-mode-line-playlist-current ()
;;   "Return a description of the current track."
;;   (let* ((track (emms-playlist-current-selected-track))
;;          (type (emms-track-type track))
;;          (title (emms-track-get track 'info-title)))
;;     (format "[ Music %s ]"
;;             (cond ((and title)
;;                    title)))))



;; (setq emms-mode-line-mode-line-function
;;       'bigclean-emms-mode-line-playlist-current)

(provide 'init-emms)
;;; init-emms ends here

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

(define-emms-simple-player afplay '(file)
      (regexp-opt '(".mp3" ".m4a" ".aac"))
      "afplay")
(setq emms-player-list '(emms-player-mpg321
                         emms-player-ogg123
                         emms-player-afplay
			 ))

(setq emms-info-asynchronously nil)
(setq emms-playlist-buffer-name "*Music*")

(provide 'init-emms)
;;; init-emms ends here

;;; -* emacs-lisp *-
;;; init-emms.el --- music player
;; Author: Leon He<leonhe86@gmail.com>
;; Version: 0.1

;;; Commentary:

;;; Code:
(require 'emms-setup)
(require 'emms-player-simple)
(require 'emms-source-file)
(require 'emms-source-playlist)
(require 'emms-player-mplayer)
(emms-all)
(emms-default-players)
(require 'emms-mode-line)
(emms-mode-line 1)
(require 'emms-playing-time)
(emms-playing-time 1)

;;(add-to-list 'auto-mode-alist '("\\.ml\\" . emms-playerlist-mode))
(define-emms-simple-player afplay '(file)
      (regexp-opt '(".mp3" ".m4a" ".aac"))
      "afplay")
(setq emms-player-list '(emms-player-mpg321
                         emms-player-ogg123
                         emms-player-afplay
			 ))

(setq emms-playlist-buffer-name "*Music*")
(setq emms-source-file-default-directory "~/Music/mp3/")
(require 'emms-info)
(require 'emms-info-libtag)
(add-to-list 'emms-track-initialize-functions 'emms-info-initialize-track)
(setq emms-info-functions '(emms-info-libtag))
(setq emms-info-auto-update t)



(setq music_name_regexp "/\\([^/]+\\)/\\([^/]+\\)\\.[^.]+$")

(defun eiio-emms-mode-line-playlist-current ()
  "Return a description of the current track."
  (let* ((track (emms-playlist-current-selected-track))
         (title (emms-track-get track 'info-title))
  	 
    	 )
    (format "[🎵:%s]"   title)
      ))

 
(setq emms-mode-line-mode-line-function
      'eiio-emms-mode-line-playlist-current)

(defun eiio-emms-info-track-des (track)
  "Returen a description to current track"
  (let* ((artist (emms-track-get track 'info-artist))
        (title (emms-track-get track 'info-title))
	(count (emms-track-get track 'play-count))
)

	(format "🎵:  %s | %s |  %d" artist title count)
  ))

(setq emms-track-description-function 'eiio-emms-info-track-des)
(provide 'init-emms)
;;; init-emms ends here

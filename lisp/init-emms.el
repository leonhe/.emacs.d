;;; init-emms.el --- music player
;; Author: Leon He<leonhe86@gmail.com>
;; Version: 0.1

;;; Commentary:

;;; Code:
(require 'emms-setup)
(require 'emms-player-simple)
(require 'emms-source-file)
(require 'emms-source-playlist)
(require 'emms-i18n)
(require 'emms-info)
(require 'emms-player-mplayer)
(emms-all)
(emms-default-players)
(require 'emms-mode-line)
(emms-mode-line 1)
(require 'emms-playing-time)
(emms-playing-time 1)

(add-to-list 'auto-mode-alist '("\\.ml\\" . emms-playerlist-mode))
(define-emms-simple-player afplay '(file)
      (regexp-opt '(".mp3" ".m4a" ".aac"))
      "afplay")
(setq emms-player-list '(emms-player-mpg321
                         emms-player-ogg123
                         emms-player-afplay
			 emms-player-mplayer
			 ))
(setq emms-playlist-buffer-name "*Music*")
(setq emms-source-file-default-directory "~/Music/")


;; (defun filter-name (name)
;;   "return filter music name by regexp"
;;   ;;(let ()
;;     ;; (if (string-match regexp name)
;;     ;; 	    (progn
;;     ;; 	      (format "%s" )))
;;     ;; )
;;   (format "%s" name)
;;  )

;; ;;format current track,only display title in mode line
(defun eiio-emms-mode-line-playlist-current ()
  "Return a description of the current track."
  (let* ((regexp "/\\([^/]+\\)/\\([^/]+\\)\\.[^.]+$")
         (title (emms-track-get track 'name)))
    (if (string-match regexp title)
     	(progn
	  (format " [ %s ] " (match-string 2 title)))
      )))
 


(setq emms-mode-line-mode-line-function
      'eiio-emms-mode-line-playlist-current)

;; (defun eiio-emms-info-track-des (track)
;;   "Returen a description to current track"
;;   (let ((artist (emms-track-get track 'info-artist))
;;         (title (emms-track-get track 'name)))
;;     (format "%-10s +| %s"
;;             (or artist
;;                 "")
;;             title)))
;;     (setq emms-track-description-function 'eiio-emms-info-track-des);
(provide 'init-emms)
;;; init-emms ends here

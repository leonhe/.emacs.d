;;; lua-gud.el --- Grand Unified Debugger mode for running lua mobdebug

;; Anthor: LeonHe <leonhe@gmail.com>
;; Version: 0.1 (2017-06-03)
;;; Commentary:
;;This package provides Emacs(GUD)
;;;  Code:

;; this is code

(require 'gud)
;;This lua gud

;;; History of arguments lists
(defvar gud-lua-debug-history nil)

(defun lua-debug-message-args(file args)
)

(defun lua-debug-marker-filter()

  )

(defun lua-debug-find-file()

  )

(defun cdb-simple-send (proc string)
  (comint-send-string proc (concat string "\n")) ;; this first: error writing to buf otherwise
  (if (string-match "^[ \t]*[Qq][ \t]*" string)
      (kill-buffer gud-comint-buffer)
    ))

(defun lua-debug(command-line)
  "Run lua debug *gud-FILE*.This directory"
  (interactive (list (gud-query-cmdline 'ldb)))
  (gud-common-init command-line 'lua-debug-message-args
  		   nil nil)

  ;; (set (make-local-variable 'gud-minor-mode) 'ldb)
  ;; (setq comint-prompt-regexp "^[0-9a-f]:[0-9a-f][0-9a-f][0-9a-f]> ")
  ;; (setq comint-input-sender 'cdb-simple-send)
  ;; (setq paragraph-start comint-prompt-regexp)
  ;; (run-hooks 'lua-debug-mode-hook)
  ;;(gud-def gud-break "bu `%d %f:%l`" "C-b" "Set breakpoint at current line.")
)


;; (defvar cassandra-cli-file-path "/usr/local/bin/lua5.1"
;;   "Path to the program used by `run-cassandra'")

;; (defvar cassandra-cli-arguments '()
;;   "Commandline arguments to pass to `cassandra-cli'")

;; (defvar cassandra-mode-map
;;   (let ((map (nconc (make-sparse-keymap) comint-mode-map)))
;;     ;; example definition
;;     (define-key map "\t" 'completion-at-point)
;;     map)
;;   "Basic mode map for `run-cassandra'")

;; (defvar cassandra-prompt-regexp "^\\(?:\\[[^@]+@[^@]+\\]\\)"
;;   "Prompt for `run-cassandra'.")

(defvar lua-debug-arguments '()
  "Commandline arguments to pass to `lua'"
  )
(defun run-lua-debug ()
  "Run an inferior instance of `cassandra-cli' inside Emacs."
  (interactive)
  (setq ldb-buffer "*Lua-Debug*")
  (let* ((lua-program "/usr/local/bin/lua")
	 (buffer (comint-check-proc "Lua-Debug")))

    (pop-to-buffer-same-window
     (if (or buffer (not (derived-mode-p 'luae-mode))
             (comint-check-proc (current-buffer)))
         (get-buffer-create (or buffer "*Lua-Debug*"))
       (current-buffer)))
    
  (unless buffer
    (apply 'make-comint-in-buffer "*Lua-Debug*" buffer
	   lua-program lua-debug-arguments)
    (lua-mode))))
   

(defun test_hello()
  (interactive)
  (comint-send-string "*Lua-Debug*" "print \"hello\" \n")
  )


;;(global-key-binding (kbd "C-c r r") 'run-lua-debug)
(provide 'lua-gud)

;;; lua-gud ends here

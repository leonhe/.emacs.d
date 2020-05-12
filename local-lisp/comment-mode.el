;;; comment-mode.el --- Comment minor mode code for Emacs

;; Copyright (C) 1999 Keir Fraser

;; Author: Keir Fraser Keir.Fraser@cl.cam.ac.uk
;; Maintainer: Keir Fraser Keir.Fraser@cl.cam.ac.uk
;; Created: 12 October 1999
;; Version: 1.0
;; Keywords: C comment

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 1, or (at your option)
;; any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; A copy of the GNU General Public License can be obtained from this
;; program's author (send electronic mail to Paul.Barham@cl.cam.ac.uk)
;; or from the Free Software Foundation, Inc., 675 Mass Ave,
;; Cambridge, MA 02139, USA.

;;; Commentary:

;; A smart commenting mode for C code.  
;;
;; To toggle this minor mode, call function <comment-mode>.
;;
;; The mode can be customised as follows:
;;
;;  Set <comment-right-margin> to the very last column you wish to use. The
;;  default is column 79 (many people have Emacs set to width 80, which 
;;  actually gives just 79 characters per line).
;;
;;  Redefine the key bindings. The defaults are clearly displayed below, but
;;  they can be modified from e.g., within a c-mode-hook function.

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Variables:

(defvar comment-mode nil)
(make-variable-buffer-local 'comment-mode)
(defvar comment-mode-map nil)
(make-variable-buffer-local 'comment-mode-map)
(defvar comment-right-margin 79)
(make-variable-buffer-local 'comment-right-margin)
(set-default 'comment-right-margin 79)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Macros:
(defsubst call-original-binding (x)     
  (if (local-key-binding x t) (funcall (local-key-binding x t))
    (if (global-key-binding x t) (funcall (global-key-binding x t) 1)
      (self-insert-command 1))))
(defsubst limited-search-forward (x)
  (search-forward x (save-excursion (end-of-line) (point)) t))
(defsubst limited-re-search-forward (x)
  (re-search-forward x (save-excursion (end-of-line) (point)) t))
(defsubst limited-search-backward (x)
  (search-backward x (save-excursion (beginning-of-line) (point)) t))
(defsubst limited-re-search-backward (x)
  (re-search-backward x (save-excursion (beginning-of-line) (point)) t))
(defmacro unless (cond &rest body)
  (cons 'if (cons cond (cons nil body))))
(defmacro when (cond &rest body)
  (list 'if cond (cons 'progn body)))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Keymap:

(unless (default-value 'comment-mode-map)
  (setq comment-mode-map (make-sparse-keymap))

  ;; These are useful shortcuts that should probably be kept.
  (define-key comment-mode-map "\C-cc"    'mini-comment)
  (define-key comment-mode-map "\C-cb"    'block-comment)
  (define-key comment-mode-map "\M-\C-\\" 'comment-reformat-region)

  ;; These bindings do "sensible" things with some keys when in a comment,
  ;; but some people may think this is very annoying.
  (define-key comment-mode-map "\r"       'comment-newline-binding)
  (define-key comment-mode-map "\t"       'comment-retabulate)

  ;; this one converts a // pair into a /* */ comment - neat!
  (define-key comment-mode-map " "        'comment-space-char)


  (set-default 'comment-mode-map comment-mode-map)
)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Globally-accessible Functions:

;;; Install ourselves in the minor mode lists, if we're not there already.
(unless (assq 'comment-mode minor-mode-alist)
    (setq minor-mode-alist 
          (cons '(comment-mode " Comment") 
                minor-mode-alist))
    (setq minor-mode-map-alist 
          (cons (cons 'comment-mode comment-mode-map)
                minor-mode-map-alist)))


;;; COMMENT-MODE
;;; This is the recommended basic initialisation function.
;;; If the optional argument is `nil', we toggle the mode.
;;; Otherwise, if <arg> is <= 0 we turn off comment mode, > 0 we turn it on.
(defun comment-mode (&optional arg)
  "Minor mode to do sane commenting (for C only, atm)."
  (interactive)
  (unless (boundp 'cs-region)
    (make-local-variable 'cs-region)
    (setq cs-region (make-marker))
    (make-local-variable 'ce-region)
    (setq ce-region (make-marker)))
  (setq comment-mode (if (null arg) (not comment-mode)
                       (> (prefix-numeric-value arg) 0)))
)

;;; STANDARD BLOCK COMMENT
;;; Style: /*************************************
;;;         * ^                                   (^ = final cursor position)
;;;         */
(defun block-comment ()
  "Create a comment box, left margin at the current cursor position."
  (interactive)
  (let (temp (start-col (current-column)))
    ; Now draw first line of a comment box
    (comment-solid-line start-col nil)
    ; Now draw second line of comment box
    (insert-char ?\n 1)
    (insert-char 32 start-col)
    (insert " * ")
    (setq temp (point))
    ; Final line!
    (insert-char ?\n 1)
    (insert-char 32 start-col)
    (insert " */")
    ; Now go to the comment start point
    (goto-char temp))
)

;;; MINI COMMENT
;;; Style: /*
;;;         * ^           (^ = final cursor position)
;;;         */
(defun mini-comment ()
  "Create a mini comment, left margin at the current cursor position."
  (interactive)
  (let (temp (start-col (current-column)))
    (insert "/*\n")
    (insert-char 32 start-col)
    (insert " * ")
    (setq temp (point))
    (insert-char ?\n 1)
    (insert-char 32 start-col)
    (insert " */")
    (goto-char temp))
)


;;; ADD COMMENT LINE
;;; When positioned on any line of a comment's body, extends the comment by
;;; adding a new line of the correct type after the current line. 
(defun comment-add-line (&optional type)
  "Extend comment on current line by adding line of correct type on next line."
  (interactive)
  (unless type (setq type (comment-type)))
  (let ((start-col (comment-start-col)))
    (when type
      (if (eq type 'single)
          (progn
            (limited-search-forward "*/")
            (delete-char -2)
            (insert-char ?\n 1)
            (insert-char 32 start-col)
            (insert " * ")
            (let ((tmp (point)))
              (insert " */")
              (goto-char tmp)))
        (end-of-line)
        (if (limited-re-search-backward "*/")
            (progn
              (delete-char 2)
              (insert-char ?\n 1)
              (insert-char 32 start-col)
              (insert " * ")
              (let ((tmp (point)))
                (insert " */")
                (goto-char tmp)))
          (insert-char ?\n 1)
          (insert-char 32 start-col)
          (insert " * ")))))
)


;;; SPACE CHARACTER
(defun comment-space-char ()
  (interactive)
  (if (not (and (eq (preceding-char) ?/) (eq (char-before (- (point) 1)) ?/)))
      (call-original-binding " ")
    (delete-char -1)
    (insert "*  */")
    (goto-char (- (point) 3)))
)


;;; NEWLINE BINDING
(defun comment-newline-binding ()
  (interactive)
  (let ((type (comment-type)))
    (if (save-excursion
          (and type 
               (not (limited-search-backward "*/"))
               (limited-re-search-backward "^[ \t]*/?\\*")))
        (comment-add-line type)
      (call-original-binding "\r")))
)


;;; RETABULATE COMMENT
(defun comment-retabulate ()
  (interactive)
  (let ((type (comment-type)))
    (if type
        (save-excursion
          (indent-region cs-region ce-region nil)
          (goto-char ce-region)
          (forward-line -1)      
          (if (eq type 'multi) (comment-reformat)))
      (call-original-binding "\t")))
)


;;; REFORMAT REGION
(defun comment-reformat-region ()
  "Reformat region between point and mark."
  (interactive)
  (save-excursion
    (let ((start (make-marker)) (end (make-marker)))
      (set-marker start (mark))
      (set-marker end (point))
      (indent-region start end nil)
      (goto-char start)
      (while (< (point) end)
        (let ((type (comment-type)))
          (when (eq type 'multi)
            (comment-reformat)
            (goto-char ce-region)))
          (forward-line 1))))
)


;;; REFORMAT COMMENT
;;; When positioned on any line of a comment, reformats the right margin of the
;;; entire comment, reflowing text where necessary.
(defun comment-reformat ()
  (save-excursion
    (let ( (region-start (make-marker))
           (region-end (make-marker))
           (start-col (comment-start-col)))
      (goto-char cs-region)
      (reformat-solid-line)
      (beginning-of-line)
      (if (save-excursion (limited-search-forward "/**"))
          (progn
            (forward-line 1)
            (set-marker region-start (point)))
        (limited-search-forward "/*")
        (delete-char -1)
        (beginning-of-line)
        (set-marker region-start (point))
        (forward-line 1))
      (while (limited-re-search-forward "^[ \t]*\\*")
        (delete-char -1)
        (forward-line 1)
        (set-marker region-end (point)))
      (forward-line -1)
      (when (limited-search-forward " */")
        (delete-char -3)
        (insert "@*/"))

      (shuffle-text region-start 
                    region-end 
                    (+ start-col 2) 
                    (- comment-right-margin 1))

      (goto-char region-start)
      (beginning-of-line)
      (while (< (point) region-end)
        (move-to-column (+ start-col 1))
        (insert-char ?* 1)
        (when (limited-search-forward "@*/")
          (delete-char -3)
          (insert " */"))
        (forward-line 1))))
)


(defun convert-comment-region ()
  "Scans current buffer for box comments and removes right column of stars."
  (interactive)
  (save-excursion
    (let ((start (make-marker)) (end (make-marker)))
      (set-marker start (mark))
      (set-marker end (point))
      (goto-char start)
      (while (re-search-forward "^[ \t]*/\\*[ \t]*$" end t)
        (delete-region (progn (forward-line 0) (point))
                       (progn (forward-line 1) (point)))
        (limited-search-forward "*")
        (delete-char -2)
        (insert "/*")
        (forward-line 1)
        (search-forward "*/" end t)
        (delete-region (progn (forward-line 0) (point))
                       (progn (forward-line 1) (point)))
        (forward-line -1)
        (end-of-line)
        (insert " */")
        (beginning-of-line)
        (comment-type)
        (comment-reformat))))
)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;; Private Functions:

;;; reformat-solid-line()
;;; Cut a solid /**** line down to size. Basically a helper fn for reformat().
(defun reformat-solid-line ()
  (end-of-line)
  (when (limited-search-backward "/**")
    (end-of-line)
    (if (> (current-column) comment-right-margin)
        (delete-char (- comment-right-margin (current-column)))
      (insert-char ?* (- comment-right-margin (current-column)))))
)

;;; comment-start-col()
;;; Returns: left margin of comment on current line.
(defun comment-start-col ()
  (save-excursion
    (beginning-of-line)
    (limited-search-forward "*")
    (- (current-column) 2))
)


;;; comment-type() 
;;; Returns: 'single if in a single-line comment.
;;;          'multi  if in a multi-line comment.
;;;           nil    if not in a position to add a new line to a valid comment.
;;;
;;; NB. this is far from fool-proof, but will work in nearly all cases.
(defun comment-type ()
  (save-excursion
    (beginning-of-line)

    ;; 1. valid comment lines contain a '*'
    (if (not (limited-re-search-forward "^[ \t]*/?\\* ")) nil

      (if (and (limited-search-forward "*/")
               (limited-search-backward "/*"))

          ;; single-line comment
          (progn
            (beginning-of-line)
            (set-marker cs-region (point))
            (forward-line 1)
            (set-marker ce-region (point))
            'single)

        ;; could be a multi-line comment....
        (beginning-of-line)
        (while (limited-re-search-forward "^[ \t]+\\*") (forward-line -1))
        (if (not (limited-re-search-forward "^[ \t]*/\\*")) nil
          (beginning-of-line)
          (set-marker cs-region (point))
          (search-forward "*/")
          (forward-line 1)
          (set-marker ce-region (point))
          'multi))))
)


;;; comment-solid-line()
;;; Creates a /********* style comment line on the current line.
;;; If <spaces-prefix> is not nil, <start-col> spaces are inserted first.
(defun comment-solid-line (start-col spaces-prefix)
  (if spaces-prefix (insert-char 32 start-col))
  (insert-char ?/ 1)
  (insert-char ?* (- comment-right-margin start-col 1))
)


;;; shuffle-text(rs re sc ec)
;;; Reflows the text in the region delimited by <rs> and <re> (which should 
;;; both be positioned at line starts).
;;; Left margin of the text will be <sc>, right margin at <ec>. 
;;; We assume that any comment chaff has been temporarily removed, 
;;; so we can ignore that crap.
(defun shuffle-text (rs re sc ec)

  (let ((flow-back 0) (prev-point (make-marker)))
    (goto-char rs)

    ;; For every line in the region delimited by <rs> and <re>.
    (while (< (point) re)

      ;; Remove spurious white space at the end of the line.
      (end-of-line)
      (while (and (> (current-column) sc) 
                  (eq (preceding-char) 32)) 
        (delete-char -1))

      (if (<= (current-column) sc)
          
          ;; Line is empty -- treat as a paragraph break (=> no flow-back)
          (setq flow-back 0)

        ;; There is text on this line. Move text to the end of the 
        ;; previous line until it is full.
        (move-to-column sc)
        (while (and (> flow-back 0) 
                    (not (eq (following-char) 32))
                    (not (eq (following-char) ?\n)))
          (set-marker prev-point (point))
          (re-search-forward "[^ \t\n]+[ \t]*") ; grab a word and trailing ws
          (if (> (- (point) prev-point) flow-back)
              (setq flow-back 0)
            (setq flow-back (- flow-back (- (point) prev-point)))
            (kill-region prev-point (point))
            (forward-line -1)
            (end-of-line)
            (unless (eq (preceding-char) 32) 
              (insert-char 32 1)
              (setq flow-back (- flow-back 1)))
            (yank)
            (goto-char prev-point)))

        ;; Next we shift any text that overflows the current line to the next,
        ;; setting the <flow-back> variable appropriately.
        (end-of-line)
        (if (<= (current-column) ec)
          
            ;; this line is not full: set <flow-back> appropriately.
            (setq flow-back (- ec (current-column)))

          ;; line is full: we want no flow-back, and we push text to next line.
          (setq flow-back 0)
          (while (> (current-column) ec) 
            (re-search-backward "[ \t][^ \t\n]+")
            ;; NB. we could make this _delete_ white space, but I think this
            ;;     will seem saner :-)
            (while (eq (preceding-char) 32) (backward-char)))
          (set-marker prev-point (point))
          (end-of-line)
          (kill-region prev-point (point))
          (forward-line 1)
          (move-to-column sc)
          (when (or (eq (following-char) 32) 
                    (eq (following-char) ?/)
                    (> (point) re))
            (forward-line -1)
            (end-of-line)
            (insert-char ?\n 1)
            (insert-char 32 sc))
          (yank)
          (unless (eq (preceding-char) 32) (insert-char 32 1))
          (goto-char (mark))
          (while (eq (following-char) 32) (delete-char 1))
          (forward-line -1))

        ;; Stage 4 - if we have managed to empty the line, nuke it.
        ;; We then have to repeat stage 3 for the preceding line.
        (beginning-of-line)
        (when (save-excursion (limited-re-search-forward "^[ \t]*$"))
          (set-marker prev-point (point))
          (forward-line 1)
          (delete-region prev-point (point))
          (forward-line -1)
          (end-of-line)
          (setq flow-back (- ec (current-column)))))
        
      (forward-line 1)))
)
(provide 'comment-mode)

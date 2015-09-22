;;;; mal-lisp.lisp
(defpackage #:mal-lisp
  (:use #:cl
        #:linedit
        #:cl-ppcre
        )
  (:export #:step0
           #:step1))

(in-package #:mal-lisp)

;;step0_repl

(defun quit ()
  (fresh-line)
  (format t "bye~%")
  (sb-ext:exit))

(defun prompt ()
  (format t "user> ")
  (force-output))

(defun mal-read ()
  (prompt)
  (handler-case
      ;;(linedit:linedit :prompt "user> ") ; this would cause tests to fail
      ;;even though it "werks"
      (read-line)
    (end-of-file () (quit))))

(defun mal-eval (arg)
  arg)

(defun mal-print (arg)
  (format t "~A~%" arg))

(defun repl ()
  (loop
     (mal-print
      (mal-eval
       (mal-read)))))

(defun step0 (args)
  (declare (ignore args))
  (repl))


;;step1_read_print

(defun reader (list-of-tokens)
  "is instantiated with a list of tokens.  has 2 methods, next, and peek"
  (let ((position -1)); start just before the list of tokens
    (lambda (command)
      (case command
        ((next) (nth (incf position) list-of-tokens))
        ((peek) (nth position list-of-tokens))
        (otherwise 'what-did-you-do)))))

;; (defparameter *r* (reader '(1 2 3)))

;; (funcall *r* 'next)
;; (funcall *r* 'peek)
-
;;(defun read_str )

(defun step1 (args)
  (declare (ignore args))
  (repl)
  )

;;;; mal-lisp.lisp

;;package
(defpackage #:mal-lisp
  (:use #:cl
        #:linedit
        #:cl-ppcre
        #:lisp-unit
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
  (identity arg))

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

(defun reader-maker (list-of-tokens)
  "is instantiated with a list of tokens.  has 2 methods, next, and peek"
  (lambda (command)
    (ecase command
      ((next) (pop list-of-tokens))
      ((peek) (car list-of-tokens)))))


(defun step1 (args)
  (declare (ignore args))
  (repl))

;;;; mal-lisp.lisp
(defpackage #:mal-lisp
  (:use #:cl
     ;; #:linedit
        )
  (:export #:step0))

(in-package #:mal-lisp)

;;step0

(defun prompt ()
  (format t "user> ")
  (force-output))

(defun mal-read ()
  ;;(linedit :prompt "user> ")
  (prompt)
  (read-line))

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



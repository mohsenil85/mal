;;;; mal-lisp.lisp
(defpackage #:mal-lisp
  (:use #:cl
        #:linedit
        #:cl-ppcre
        )
  (:export #:repl))

(in-package #:mal-lisp)

;;step0

(defun prompt ()
  (format t "user> ")
  (force-output))

(defun quit ()
  (fresh-line)
  (format t "bye~%")
  (sb-ext:exit))

(defun mal-read ()
  (handler-case
      (linedit:linedit :prompt "user> ")
    (end-of-file () (quit))))

(defun mal-eval (arg)
  arg)

(defun mal-print (arg)
  (format t "~A~%" arg))

(defun repl (args)
  (declare (ignore args))
  (loop
     (mal-print
      (mal-eval
       (mal-read)))))

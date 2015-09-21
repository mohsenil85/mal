;;;; mal-lisp.lisp
(defpackage #:mal-lisp
  (:use #:cl
        #:linedit
        #:log4cl)
  (:export #:repl))

(in-package #:mal-lisp)


;;config
(defparameter *logger*
  (open "./mal.log" :direction :output :if-exists :supersede))

(log:config  :stream *logger*)


;;;step0 --  repl

(defun prompt ()
  (format t "user> ")
  (force-output))

(defun mal-read ()
  ;(linedit :prompt "user> ")
  (prompt)
  (read-line)
  )

(defun mal-eval (arg) arg)

(defun mal-print (arg)
  (format t "~A~%" arg))

(defun repl (args)
  (declare (ignore args))
  (loop
     (mal-print
      (mal-eval
       (mal-read)))))

(close *logger*)



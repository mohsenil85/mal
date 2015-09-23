;;;; mal-lisp.lisp

;;package
 (defpackage #:mal-lisp
  (:use #:cl
        #:linedit
        #:cl-ppcre
        #:should-test
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
  (format t "~a~%" arg))

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

;;test read
(deftest reader-maker ()
  (let ((r (reader-maker '(1 2 3))))
    (should be = 1 (funcall r 'peek))
    (should be = 1 (funcall r 'peek))
    (should be = 1 (funcall r 'next))
    (should be = 2 (funcall r 'peek))
    (should be = 2 (funcall r 'next))
    (should be = 3 (funcall r 'next))
    (should be eq nil (funcall r 'peek))
    (should be eq nil (funcall r 'next))
    (should be eq nil (funcall r 'next))
    (should be eq nil (funcall r 'peek))))



(defparameter *re*
  (create-scanner
   "[\\s ,]*(~@|[\\[\\]{}()'`~@]|\"(?:[\\\\].|[^\\\\\"])*\"|;.*|[^\\s \\[\\]{}()'\"`~@,;]*)"))

(defun tokenizer (string)
  (loop
     for c across string
     when (scan-to-strings *re* (string c))
     collect it))

(defun read_form (s)
  (case s
    ("(" 'read-list)
    (t 'read-atom)))

(mapcar #'(lambda (s) (read_form s))(tokenizer "foobar(foobar"))


(defun step1 (args)
  (declare (ignore args))
  (repl))

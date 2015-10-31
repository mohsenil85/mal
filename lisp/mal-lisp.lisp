;;;; mal-lisp.lisp

;;package
(defpackage #:mal-lisp
  (:use #:cl
        #:linedit
        #:cl-ppcre
        #:should-test
        #:split-sequence
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

(defun make-reader (list-of-tokens)
  "is instantiated with a list of tokens.  has 2 methods, next, and peek"
  (lambda (command)
    (ecase command
      ((next) (pop list-of-tokens))
      ((peek) (car list-of-tokens)))))

(defun reader-peek (r)
  (funcall r 'peek ))

(defun reader-next (r)
  (funcall r 'next ))

;;test read
(deftest make-reader ()
  (let ((r (make-reader '(1 2 3))))
    (should be = 1 (reader-peek r))
    (should be = 1 (reader-peek r))
    (should be = 1 (reader-next r))
    (should be = 2 (reader-peek r))
    (should be = 2 (reader-next r))
    (should be = 3 (reader-next r))
    (should be eq nil (reader-peek r))
    (should be eq nil (reader-next r))
    (should be eq nil (reader-next r))
    (should be eq nil (reader-peek r))))



(defun tokenize (string)
  "returns a list of tokens...  maybe whitespace delimited"
  (let ((pattern
         (create-scanner
          "[\\s ,]*(~@|[\\[\\]{}()'`~@]|\"(?:[\\\\].|[^\\\\\"])*\"|;.*|[^\\s \\[\\]{}()'\"`~@,;]*)") )
        (str (regex-replace-all "[)]" string " )")))
    (loop
       for token in (split-sequence  #\Space  str :remove-empty-subseqs t)
       when (scan-to-strings pattern token)
       collect it
         )))



(defun read-str (string)
  (read-form (make-reader (tokenize string))))

(defun read-form (reader)
  (case  (reader-peek reader)
    ("("  (read-list reader))
    (otherwise (read-atom reader))))

(defun read-atom (reader)
  (let ((token (reader-next reader))
        (pattern "(^-?[0-9]+$)|(.*)"))
    (register-groups-bind ((#'new-number n) (#'new-atom a))
        (pattern token))))


(defun read-list (reader)
  reader)


(defun new-atom(val)
  (make-instance '<mal-atom> :value val))
(defun new-number (val)
  (make-instance '<mal-number> :value val))


;;(read-atom (mr(make-reader (tokenize "123 abc 1we"))))
;;(read-form (make-reader (tokenize "x123")))


(defun step1 (args)
  (declare (ignore args))
  (repl))


;;types
(defclass <mal-value> ()())
(defclass <mal-number> (<mal-atom>)
  ((value :accessor value
          :type number
          :initarg :value)))


;; (defmethod print-object :after (<mal-value> *query-io*)
;;   (print (value <mal-value>)))
(defun mal-atom (a)
  (make-instance '<mal-atom> :value a))
(defun mal-int (val)
  (make-instance '<mal-number> :value val))
(defclass <mal-atom> (<mal-value>)
  ((value :accessor value
          :type string
          :initarg value)))

(defclass <mal-list> (<mal-value>)
  ((head
    :accessor head
    :initform '()
    :type <mal-atom>)
   (tail
    :accessor tail
    :initform '()
    :type <mal-list>)))

(defgeneric copy (<mal-val>)
  (:documentation "i donno"))

(defmethod copy (<mal-value>)
  <mal-value>)

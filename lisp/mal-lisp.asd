;;;; mal-lisp.asd

(asdf:defsystem #:mal-lisp
  :depends-on (#:cl-ppcre
               #:linedit
               #:should-test
               #:split-sequence)
  :components ((:file "mal-lisp")))

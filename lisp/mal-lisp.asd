;;;; mal-lisp.asd

(asdf:defsystem #:mal-lisp
  :depends-on (#:cl-ppcre
               #:linedit
               #:should-test)
  :components ((:file "mal-lisp")))

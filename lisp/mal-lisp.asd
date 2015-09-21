;;;; mal-lisp.asd

(asdf:defsystem #:mal-lisp
  :depends-on (#:cl-ppcre
               #:linedit)
  :components ((:file "mal-lisp")))

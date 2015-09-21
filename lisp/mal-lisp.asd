;;;; mal-lisp.asd

(asdf:defsystem #:mal-lisp
  :depends-on (#:cl-ppcre
               #:linedit
               #:log4cl)
  :components ((:file "mal-lisp")))

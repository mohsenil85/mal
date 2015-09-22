;;;; mal-lisp.asd

(asdf:defsystem #:mal-lisp
  :depends-on (#:cl-ppcre
               #:linedit
               #:lisp-unit)
  :components ((:file "mal-lisp")))

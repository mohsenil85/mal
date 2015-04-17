(defun prompt-read (prompt)
  (format *query-io* "~%~a" prompt)
  (force-output *query-io*)
  (read-line *query-io*))

(defun run ()
  (loop (princ (prompt-read "user> "))))

(handler-case (run)
  (sb-sys:interactive-interrupt ()
    (sb-ext:exit)))

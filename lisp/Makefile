#manifest:
#	sbcl \
#	--eval '(ql:write-asdf-manifest-file  (concatenate (quote string)  (sb-posix:getcwd) "/.manifest.txt"))' \
#	-eval '(sb-ext:exit)'

step0_repl:
	buildapp \
		--manifest-file .manifest.txt \
		--load-system mal-lisp \
		--output step0_repl \
		--entry mal-lisp:step0

step1_read_print:
	buildapp \
		--manifest-file .manifest.txt \
		--load-system mal-lisp \
		--output step1_read_print \
		--entry mal-lisp:step1



clean:
	rm *.fasl step*

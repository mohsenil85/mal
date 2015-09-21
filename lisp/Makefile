#manifest:
#	sbcl \
#	--eval '(ql:write-asdf-manifest-file  (concatenate (quote string)  (sb-posix:getcwd) "/.manifest.txt"))' \
#	--eval '(sb-ext:exit)'

step0_repl:
	buildapp \
		--manifest-file .manifest.txt \
		--load-system mal-lisp \
		--output step0_repl \
		--entry mal-lisp:step0

clean:
	rm *.fasl step0_repl

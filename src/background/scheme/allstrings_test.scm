(require-extension test)
(include "sllstrings.scm")


;; ======= bitstrings
(test-begin "bitstrings")
(test #t (= 0 (triangle-num 0)))
(test #t (= 1 (triangle-num 1)))
(test #t (= 3 (triangle-num 2)))
(test #t (= 6 (triangle-num 3)))
(test #t (= 10 (triangle-num 4)))
(test-end "bitstrings")

;; --------------------------- required footer

(display (string-append "TOTAL NUMBER OF FAILURES OVER ALL TESTS: "
			(number->string (test-failure-count))))
(newline)

(test-exit)
;; When running this from the command line, test for return code with
;; $ echo $?
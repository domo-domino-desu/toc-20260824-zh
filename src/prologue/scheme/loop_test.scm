(require-extension test)
(include "loop.scm")


;; ======= zero
(test-begin "zero")
(test-assert (= 0 (Z 0)))
(test-assert (= 0 (Z 1)))
(test-end "zero")


;; ======= successor
(test-begin "successor")
(test-assert (= 1 (succ 0)))
(test-assert (= 2 (succ 1)))
(test-end "successor")


;; ======= projection
(test-begin "projection")
(test-assert (= 0 (i1_1 0)))
(test-assert (= 1 (i1_1 1)))
(test-assert (= 0 (i2_1 0 1)))
(test-assert (= 1 (i2_1 1 1)))
(test-assert (= 0 (i2_2 0 0)))
(test-assert (= 1 (i2_2 0 1)))
(test-assert (= 0 (i3_1 0 1 2)))
(test-assert (= 1 (i3_1 1 1 2)))
(test-assert (= 1 (i3_2 0 1 2)))
(test-assert (= 0 (i3_2 1 0 2)))
(test-assert (= 2 (i3_3 0 1 2)))
(test-assert (= 0 (i3_3 2 1 0)))
(test-end "projection")




;; ======= predecessor
(test-begin "predecessor")
(test-assert (= 0 (pred 1)))
(test-assert (= 1 (pred 2)))
(test-assert (= 0 (pred 0)))
(test-end "predecessor")


;; ======= plus
(test-begin "plus")
(test-assert (= 0 (plus 0 0)))
(test-assert (= 5 (plus 5 0)))
(test-assert (= 7 (plus 5 2)))
(test-assert (= 5 (plus 0 5)))
(test-end "plus")



;; ======= product
(test-begin "product")
(test-assert (= 0 (product 0 0)))
(test-assert (= 0 (product 0 5)))
(test-assert (= 0 (product 1 0)))
(test-assert (= 6 (product 2 3)))
(test-end "product")


;; ======= power
(test-begin "power")
(test-assert (= 1 (power 2 0)))
(test-assert (= 1 (power 0 0)))
(test-assert (= 2 (power 2 1)))
(test-assert (= 25 (power 5 2)))
(test-end "power")


;; ======= propersub
(test-begin "propersub")
(test-assert (= 2 (propersub 5 3)))
(test-assert (= 1 (propersub 4 3)))
(test-assert (= 0 (propersub 3 3)))
(test-assert (= 0 (propersub 3 5)))
(test-assert (= 0 (propersub 0 0)))
(test-end "propersub")


;;;; ==================== LOOP programs ======
(define REGLIST '())
(define (initialize-REGLIST)
  (set! REGLIST (list (cons #\A 0) (cons #\B 1))))


;; ======= getters and setters
(test-begin "register getters and setters")
(initialize-REGLIST)
(test-assert (equal? (cons #\A 0) 
		     (get-reg #\A)))
(test-assert (equal? (cons #\B 1) 
		     (get-reg #\B)))
(test-assert (= 0 (get-reg-value #\A)))
(test-assert (= 1 (get-reg-value #\B)))
(test-assert (= 4 (begin 
		    (set-reg-value! #\A 4)
		    (get-reg-value #\A))))
(test-assert "update existing register" 
	     (= 4 (begin 
		    (set-reg-value! #\A 4)
		    (get-reg-value #\A))))
(test-assert "create new register"
	     (= 4 (begin 
		    (set-reg-value! #\C 4)
		    (get-reg-value #\C))))
(test-end "register getters and setters")




;; ======= simulate the instructions, except LOOP
(test-begin "register manipulations")
(initialize-REGLIST)
(test-assert "increment register" 
	     (= 4 (begin 
		    (set-reg-value! #\A 3)
		    (increment-reg! #\A)
		    (get-reg-value #\A))))
(test-assert "copy register" 
	     (= 5 (begin 
		    (set-reg-value! #\A 5)
		    (set-reg-value! #\B 3)
		    (copy-reg! #\A #\B)
		    (get-reg-value #\B))))
(test-end "register manipulations")


;; ======= parse functions
(test-begin "parse functions")
(test-assert (equal? '("a b c" "d e f") 
		     ((split-program-into-lines (string-append "a b c" "#\newline" "d e f")))))

(test-end "parse functions")





;; --------------------------- required footer

(display (string-append "TOTAL NUMBER OF FAILURES OVER ALL TESTS: "
			(number->string (test-failure-count))))
(newline)

(test-exit)
;; When running this from the command line, test for return code with
;; $ echo $?
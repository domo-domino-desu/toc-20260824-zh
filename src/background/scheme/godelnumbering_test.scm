(require-extension test)
(include "godelnumbering.scm")


;; ======= triangle-num
(test-begin "triangle-num")
(test #t (= 0 (triangle-num 0)))
(test #t (= 1 (triangle-num 1)))
(test #t (= 3 (triangle-num 2)))
(test #t (= 6 (triangle-num 3)))
(test #t (= 10 (triangle-num 4)))
(test-end "triangle-num")


;; ======= diagonal enumeration
(test-begin "diagonal enumeration")
(test #t (= 0 (cantor 0 0)))
(test #t (= 1 (cantor 0 1)))
(test #t (= 2 (cantor 1 0)))
(test #t (= 3 (cantor 0 2)))
(test #t (= 4 (cantor 1 1)))
(do ((i 0 (+ i 1)))
    ((= i 10) '())
  (test #t (= (triangle-num i) (cantor 0 i))))
(test-end "diagonal enumeration")


;; ======= diagonal number from diagonal enumeration
(test-begin "diagonal number from enumeration")
(test #t (= 0 (diag-num (cantor 0 0))))  ; (0,0) is on diagonal 0
(test #t (= 1 (diag-num (cantor 0 1))))  ; (0,1) is on diagonal 1
(test #t (= 1 (diag-num (cantor 1 0))))  ; 
(test #t (= 2 (diag-num (cantor 0 2))))  ; 
(test #t (= 2 (diag-num (cantor 1 1))))  ; 
(do ((x 0 (+ x 1))
     (y 0 (+ y 1)))
    ((= (+ x y) 10) '())
  (test #t (= (+ x y) (diag-num (cantor x y)))))
(test-end "diagonal number from enumeration")


;; ======= xy from diagonal enumeration
(test-begin "xy from enumeration")
(test #t (equal? '(0 0) (xy (cantor 0 0))))  
(test #t (equal? '(0 1) (xy (cantor 0 1))))  
(test #t (equal? '(1 0) (xy (cantor 1 0))))  
(test #t (equal? '(0 2) (xy (cantor 0 2))))  
(test #t (equal? '(1 1) (xy (cantor 1 1))))  
(test #t (equal? '(2 0) (xy (cantor 2 0))))  
(do ((x 0 (+ x 1))
     (y 0 (+ y 1)))
    ((= (+ x y) 10) '())
  (test #t (equal? (list x y) (xy (cantor x y)))))
(test-end "xy from enumeration")


;; ======= cantor-3 and xy-3 
(test-begin "cantor-3 and xy-3")
(test #t (equal? '(0 0 0) (xy-3 (cantor-3 0 0 0))))  
(test #t (equal? '(0 0 1) (xy-3 (cantor-3 0 0 1))))  
(test #t (equal? '(0 1 0) (xy-3 (cantor-3 0 1 0))))  
(test #t (equal? '(1 0 0) (xy-3 (cantor-3 1 0 0))))  
(test #t (equal? '(1 2 3) (xy-3 (cantor-3 1 2 3))))  
(do ((x 0 (+ x 1)))
    ((>= x 5) x)
  (do ((y 0 (+ y 1)))
      ((>= y 5) y)
    (do ((z 0 (+ z 1)))
	((>= z 5) '())
      (test (string-append "case: x=" (number->string x)
			   " y=" (number->string y)
			   " z=" (number->string z))
	    #t (equal? (list x y z) (xy-3 (cantor-3 x y z)))))))
(test-end "cantor-3 and xy-3")


;; ======= cantor-4 and xy-4 
(test-begin "cantor-4 and xy-4")
(test #t (equal? '(0 0 0 0) (xy-4 (cantor-4 0 0 0 0))))  
(test #t (equal? '(0 0 0 1) (xy-4 (cantor-4 0 0 0 1))))  
(test #t (equal? '(0 0 1 0) (xy-4 (cantor-4 0 0 1 0))))  
(test #t (equal? '(0 1 0 0) (xy-4 (cantor-4 0 1 0 0))))  
(test #t (equal? '(1 0 0 0) (xy-4 (cantor-4 1 0 0 0))))  
(test #t (equal? '(1 2 3 4) (xy-4 (cantor-4 1 2 3 4))))  
(do ((x0 0 (+ x0 1)))
    ((>= x0 5) '())
  (do ((x1 0 (+ x1 1)))
      ((>= x1 5) '())
    (do ((x2 0 (+ x2 1)))
	((>= x2 5) '())
      (do ((x3 0 (+ x3 1)))
	  ((>= x3 5) '())
	(test (string-append "case: x0=" (number->string x0)
			     " x1=" (number->string x1)
			     " x2=" (number->string x2)
			     " x3=" (number->string x3))
	    #t (equal? (list x0 x1 x2 x3) (xy-4 (cantor-4 x0 x1 x2 x3))))))))
(test-end "cantor-4 and xy-4")



;; ======= xy-arity 2 returns the same as xy? 
(test-begin "xy-arity and xy")
(test #t (equal? (xy 0) (xy-arity 2 0)))
(test #t (equal? (xy 1) (xy-arity 2 1)))
(test #t (equal? (xy 2) (xy-arity 2 2)))
(test #t (equal? (xy 3) (xy-arity 2 3)))
(do ((c 0 (+ c 1)))
    ((>= c 100) c)
  (test (string-append "case: c=" (number->string c))
	#t (equal? (xy c) (xy-arity 2 c))))
(test-end "xy-arity and xy")




;; ======= cantor-3 and xy-arity 
(test-begin "cantor-3 and xy-arity")
(test #t (equal? '(0 0 0) (xy-arity 3 (cantor-3 0 0 0))))  
(test #t (equal? '(0 0 1) (xy-arity 3 (cantor-3 0 0 1))))  
(test #t (equal? '(0 1 0) (xy-arity 3 (cantor-3 0 1 0))))  
(test #t (equal? '(1 0 0) (xy-arity 3 (cantor-3 1 0 0))))  
(test #t (equal? '(1 2 3) (xy-arity 3 (cantor-3 1 2 3))))  
(do ((x 0 (+ x 1)))
    ((>= x 5) x)
  (do ((y 0 (+ y 1)))
      ((>= y 5) y)
    (do ((z 0 (+ z 1)))
	((>= z 5) '())
      (test (string-append "case: x=" (number->string x)
			   " y=" (number->string y)
			   " z=" (number->string z))
	    #t (equal? (list x y z) (xy-arity 3 (cantor-3 x y z)))))))
(test-end "cantor-3 and xy-arity")


;; helper: makelist-seed  make a list of length len containing all seed's
(define (makelist-seed len seed)
  (if (= len 1)
     (list seed)                       
     (cons seed (makelist-seed (- len 1) seed)))) 

;; ======= cantor-n and xy-arity 
(test-begin "cantor-n and xy-arity")
(test #t (equal? '(0 0 0) (xy-arity 3 (cantor-n 0 0 0))))  
(test #t (equal? '(0 0 1) (xy-arity 3 (cantor-n 0 0 1))))  
(test #t (equal? '(0 1 0) (xy-arity 3 (cantor-n 0 1 0))))  
(test #t (equal? '(1 0 0) (xy-arity 3 (cantor-n 1 0 0))))  
(test #t (equal? '(1 2 3) (xy-arity 3 (cantor-n 1 2 3))))  
(test #t (equal? '(0 0 0 0) (xy-arity 4 (cantor-n 0 0 0 0))))  
(test #t (equal? '(0 0 0 1) (xy-arity 4 (cantor-n 0 0 0 1))))  
(test #t (equal? '(1 2 3 4) (xy-arity 4 (cantor-n 1 2 3 4))))  
(test #t (equal? '(1 0 0 0 5) (xy-arity 5 (cantor-n 1 0 0 0 5))))  
(test #t (equal? '(1 2) (xy-arity 2 (cantor-n 1 2))))  
(do ((n 2 (+ n 1)))
    ((> n 5) n)  ;; 7 or more fails for numerical issues
  (let ((lst (makelist-seed n n)))
    (test (string-append "case: n=" (number->string n))
	  #t (equal? lst (xy-arity n (apply cantor-n lst))))))
(test-end "cantor-n and xy-arity")




;; ============== cantor-omega and xy-omega
(test-begin "cantor-omega xy-omega")
(let ((lst '(1 2 3)))
  (test-assert (equal? lst
		       (xy-omega (apply cantor-omega lst)))))
(do ((x 0 (+ x 1)))
    ((>= x 4) x)
  (do ((y 0 (+ y 1)))
      ((>= y 4) y)
    (do ((z 0 (+ z 1)))
	((>= z 4) '())
      (let ((lst (list x y z)))
	(test-assert (equal? lst
			     (xy-omega (apply cantor-omega lst))))))))
(let ((lst '(1 2 3 4 5 6)))
  (test-assert (equal? lst
		       (xy-omega (apply cantor-omega lst)))))
(let ((lst '(1 2)))
  (test-assert (equal? lst
		       (xy-omega (apply cantor-omega lst)))))

(test-end "cantor-omega xy-omega")



;; ======= Machine counting ===========

;; ======= instruction to integer and back again 
(test-begin "instruction->integer integer->instruction")
(test-assert "instructions are length 4 lists" 
	     (= 4 (length (integer->instruction 0)))) 
(do ((n 1 (+ n 1)))
    ((> n 10) '())
  (test-assert 
	     (= 4 (length (integer->instruction n)))))  
(test-assert "length 4 lists are instructions" 
	     (= 0 (instruction->integer (integer->instruction 0)))) 
(do ((n 1 (+ n 1)))
    ((> n 20) '())
  (test-assert 
	     (= n (instruction->integer (integer->instruction n))))) 
(do ((x 0 (+ x 1)))
    ((>= x 5) x)
  (do ((y 0 (+ y 1)))
      ((>= y 5) y)
    (do ((z 0 (+ z 1)))
	((>= z 5) '())
      (do ((w 0 (+ w 1)))
	  ((>= w 5) '())
	(test (string-append "case: x=" (number->string x)
			     " y=" (number->string y)
			     " z=" (number->string z)
			     " w=" (number->string w))
	      #t (integer? (instruction->integer (list x y z w))))))))
(test-end "instruction->integer integer->instruction")



;; ======= show instructions in some readable format
(test-begin "tminstruction")
;; first we test the four component functions and their inverses
;; one
(test-assert "initially is a state" 
	     (integer? (instruction-integer->tm-one 0))) 
(do ((i 1 (+ i 1)))
    ((> i 10) '())
  (test-assert 
	       (integer? (instruction-integer->tm-one i)))) 
(do ((i 1 (+ i 1)))
    ((> i 10) '())
  (test-assert (equal? i
		       (tm->instruction-integer-one (instruction-integer->tm-one i))))) 
;; four
(test-assert "finally is a state" 
	     (integer? (instruction-integer->tm-four 0))) 
(do ((i 1 (+ i 1)))
    ((> i 10) '())
  (test-assert 
	       (integer? (instruction-integer->tm-four i)))) 
(let ((inst (instruction-integer->tm-two 0)))
  (test-assert "second entry is a char or blank" 
	       (or (integer? inst)
		   (equal? #\B inst)
		   (char-lower-case? inst)))) 
(do ((i 1 (+ i 1)))
    ((> i 10) '())
  (test-assert (equal? i
		       (tm->instruction-integer-four (instruction-integer->tm-four i))))) 
; two
(do ((i 1 (+ i 1)))
    ((> i 40) '())
  (let ((inst (instruction-integer->tm-two i)))
    (test-assert (string-append "second entry is a char or blank i=" 
				(number->string i)) 
		 (or (integer? inst)
		     (equal? #\B inst)
		     (char-lower-case? inst)))))
(do ((i 1 (+ i 1)))
    ((> i 40) '())
  (test-assert (string-append "i=" (number->string i))
	       (equal? i
		       (tm->instruction-integer-two (instruction-integer->tm-two i))))) 
; three
(let ((inst (instruction-integer->tm-three 0)))
  (test-assert "third entry is a char or blank or L or R" 
	       (or (integer? inst)
		   (equal? #\L inst)
		   (equal? #\R inst)
		   (equal? #\B inst)
		   (char-lower-case? inst)))) 
(do ((i 1 (+ i 1)))
    ((> i 40) '())
  (let ((inst (instruction-integer->tm-three i)))
    (test-assert (string-append "third entry is a char or blank or L or R i=" 
				(number->string i)) 
		 (or (integer? inst)
		     (equal? #\B inst)
		     (equal? #\L inst)
		     (equal? #\R inst)
		     (char-lower-case? inst)))))
(do ((i 1 (+ i 1)))
    ((> i 40) '())
  (test-assert (string-append "i=" (number->string i))
	       (equal? i
		       (tm->instruction-integer-three (instruction-integer->tm-three i))))) 
;; Now we test the two function of which the above are components
(test-assert (= 4
		(length (instruction->tminstruction '(0 0 0 0)))))
(test-assert (= 4
		(length (instruction->tminstruction '(0 1 2 3)))))
(do ((x 0 (+ x 1)))
    ((>= x 5) x)
  (do ((y 0 (+ y 1)))
      ((>= y 4) y)
    (do ((z 0 (+ z 1)))
	((>= z 3) '())
      (do ((w 0 (+ w 1)))
	  ((>= w 2) '())
	(test-assert (string-append "case: x=" (number->string x)
			     " y=" (number->string y)
			     " z=" (number->string z)
			     " w=" (number->string w))
		     (let ((lst (list x y z w)))
	      (equal? lst 
		      (tminstruction->instruction (instruction->tminstruction lst)))))))))
(test-end "tminstruction")



;; ======= 
(test-begin "godel")
(test-assert (equal? 2
		     (length (machine->numlist '((1 2 3 4) (5 6 7 8))))))
(do ((i 1 (+ i 1)))
    ((> i 10) '())
  (test-assert (equal? i
		       (length (machine->numlist (makelist-seed i '(1 2 3 4)))))))
(do ((i 1 (+ i 1)))
    ((> i 10) '())
  (let ((m (makelist-seed i '(1 2 3 4)))
	(n (makelist-seed i 5)))
    (test-assert (equal? (length (numlist->machine n))
			 (length (machine->numlist m))))))
;; Are they inverse?
(let ((n '(1 2 3 4)))
  (test-assert (equal? n 
		       (machine->numlist (numlist->machine n)))))
(do ((x 0 (+ x 1)))
    ((>= x 5) x)
  (do ((y 0 (+ y 1)))
      ((>= y 4) y)
    (do ((z 0 (+ z 1)))
	((>= z 3) '())
      (test-assert (string-append "case: x=" (number->string x)
			     " y=" (number->string y)
			     " z=" (number->string z))
		   (equal? (list x y z) 
			   (machine->numlist (numlist->machine (list x y z))))))))
; godel
;; (let ((m '(1 2 3 4)))
;;   (test-assert (equal? m
;; 		       (machine (godel m)))))
(test-end "godel")




;; --------------------------- required footer

(display (string-append "TOTAL NUMBER OF FAILURES OVER ALL TESTS: "
			(number->string (test-failure-count))))
(newline)

(test-exit)
;; When running this from the command line, test for return code with
;; $ echo $?
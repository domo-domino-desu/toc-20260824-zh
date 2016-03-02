;; triangle-num  return 1+2+3+..+n
(define (triangle-num n)
  (/ (* (+ n 1)
	n)
     2))

;; cantor  Cantor number of the pair (x,y) of integers
(define (cantor x y)
  (let ((d (+ x y)))
    (+ (triangle-num d)
       x)))

;; diag-num  given Cantor number, find the number of the diagonal
(define (diag-num c)
  (inexact->exact (floor (/
			  (- (sqrt (+ (* 8 c) 1))
			     1)
			  2))))

;; xy  given the cantor number, return (x y) 
(define (xy c)
  (let* ((d (diag-num c))
	 (t (triangle-num d)))
    (list (- c t)
	  (- d (- c t)))))

;; cantor-3 number triples
(define (cantor-3 x0 x1 x2)
  (cantor x0 (cantor x1 x2)))

;; (use numbers)
;; diag-num  given Cantor number, find the number of the diagonal
;; The other version of this returns numerical issues if c is too large
;; but this version requires "(use numbers)" to use bignums.
;;   The idea here is that exact-integer-sqrt x returns s and k so that
;; s is the largest integer with s^2<x and s^2+k = x.  If taking s gives
;; a number that is an exact integer then the floor will be the same as using
;; the s, while if it give a number ending in .5 then to bump it up to where
;; the entire expression floors to one higher would require s+1, but we 
;; know s+1 is too big.
;; (define (diag-num c)
;;   (let ((s (exact-integer-sqrt (+ 1 (* 8 c)))))
;;     (floor-quotient (- s 1)
;; 		    2)))

; xy-3  Return the triple that gave (cantor-3 x0 x1 x2) => c
(define (xy-3 c)
  (cons (car (xy c))
	(xy (cadr (xy c)))))

;; cantor-4  Number quads
(define (cantor-4 x0 x1 x2 x3)
  (cantor x0 (cantor-3 x1 x2 x3)))

; xy-4  Un-number quasd: give (x0 x1 x2 x3) so that (cantor-4 x0 x1 x2 x3) => c
(define (xy-4 c)
  (let ((pr (xy c)))
    (cons (car pr)
	  (xy-3 (cadr pr)))))

;; cantor-n number any-sized tuple
(define (cantor-n . args)
  (cond ((null? args) (display "ERROR: cantor-n requires an input"))
	((= 1 (length args)) (car args))
	((= 2 (length args)) (cantor (car args) (cadr args)))
	(else 
	 (cantor (car args) (apply cantor-n (cdr args))))))

;; cantor-omega encode the arity of the first component, so xy-omega can get it
(define (cantor-omega . tuple)
  (if (null? tuple)
      (display "ERROR: cantor-omega requires a nonempty tuple")
      (let ((newtuple (cons (length tuple) 
			    (apply cantor-n tuple))))
	(apply cantor newtuple))))

;; xy-arity  return the tuple of the given arity making the cantor number c
(define (xy-arity arity c)
  (if (= 1 arity)
      (list c)
      (cons (car (xy c))
	    (xy-arity (- arity 1) (cadr (xy c))))))

;; xy-omega  interpret c as a pair (arity cantor-number) and return the tuple
;;  of that arity with that cantor number
(define (xy-omega c)
  (let* ((pair (xy c))
	 (arity (car pair))
	 (cantor-number (cadr pair)))
    (xy-arity arity cantor-number)))


;; ========
;; Machine counting
;; A machine is a list of instructions.
;; An instruction is a 4-tuple.
;;    (current-state, current-tape-char, next-op, next-state)
;; Here, current-tape-char is interpreted as:
;;   blank <-> 0, a <-> 1, b <-> 2, ..
;; Also, next-op is interpreted as (the first two are tape head operations):
;;   L <-> 0, R <-> 1, blank <-> 2, a <-> 3, b <-> 4, ..  
;; TODO add conversions that use the instructions from the Turing simulation
;; in the prologue.

;; instruction->integer  Convert length-4 list ilist to corresponging nat number
(define (instruction->integer ilist)
  (apply cantor-4 ilist))

;; integer->instruction Return the instruction corresponding to i
(define (integer->instruction i)
  (xy-4 i))

;; Convert a four-tuple of integers to TM instruction
;;  The TM instructions are more readable and can be run by the TM code.
(define (instruction-integer->tm-four i)
  i)
(define (tm->instruction-integer-four i)
  i)

(define (instruction-integer->tm-three i)
  (cond
      ((= i 0) #\L)
      ((= i 1) #\R)
      ((= i 2) #\B)
      ((and (> i 2)
	    (<= i 28)) (integer->char (+ i (- (char->integer #\a) 3))))
      (else (- i 29))))
(define (tm->instruction-integer-three i)
  (cond
      ((equal? i #\L) 0)
      ((equal? i #\R) 1)
      ((equal? i #\B) 2)
      ((char? i) 
       (if (char-lower-case? i)
	   (+ 3 (- (char->integer i) (char->integer #\a)))
	   (display (string-append "expected lower-case character: " i))))
      (else (+ i 29))))

(define (instruction-integer->tm-two i)
  (cond
      ((= i 0) #\B)
      ((and (> i 0)
	    (<= i 26)) (integer->char (+ i (- (char->integer #\a) 1))))
      (else (- i 27))))
(define (tm->instruction-integer-two i)
  (cond
      ((equal? i #\B) 0)
      ((char? i) 
       (if (char-lower-case? i)
	   (+ 1 (- (char->integer i) (char->integer #\a)))
	   (display (string-append "expected lower-case character: " 
				   i))))
      (else (+ i 27))))

(define (instruction-integer->tm-one i)
  i)
(define (tm->instruction-integer-one i)
  i)

;; instruction->tminstruction  Convert a 4-tuple of ints to a readable 4-tuple
(define (instruction->tminstruction fourtuple)
  (let ((tminst '())
	(one (car fourtuple))
	(two (cadr fourtuple))
	(three (caddr fourtuple))
	(four (cadddr fourtuple)))
    (cons (tminteger->instruction-four four) tminst)
    (cons (tminteger->instruction-three three) tminst)
    (cons (tminteger->instruction-two two) tminst)
    (cons (tminteger->instruction-one one) tminst)
    tminst))
(define (tminstruction->instruction fourtuple)
  (let ((inst '())
	(one (car fourtuple))
	(two (cadr fourtuple))
	(three (caddr fourtuple))
	(four (cadddr fourtuple)))
    (cons (tm->instruction-integer-four four) inst)
    (cons (tm->instruction-integer-three three) inst)
    (cons (tm->instruction-integer-two two) inst)
    (cons (tm->instruction-integer-one one) inst)
    inst))

;; machine->numlist convert list of 4-tuples m to list of corresponding
;;   natural numbers
(define (machine->numlist m)
  (if (null? m)
      '()
      (cons (instruction->integer (car m)) 
	    (machine->numlist (cdr m)))))

;; numlist->machine  Return the machine represented by nlist
(define (numlist->machine nlist)
  (map integer->instruction nlist))
  ;; (if (null? nlist)
  ;;     '()
  ;;     (cons (integer->instruction (car nlist)) 
  ;; 	    (numlist->machine (cdr nlist)))))

;; godel  Return godel number of Turing machine m
(define (godel m)
  (apply cantor-omega (machine->numlist m)))

;; machine Return the list of 4-tuples represtented by the godel number g
(define (machine g)
  (let ((numlist (xy-omega g)))
    (numlist->machine numlist)))

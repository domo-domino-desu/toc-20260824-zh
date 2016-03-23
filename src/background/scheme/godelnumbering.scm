;; see the diag-num routine for why this is here
(use numbers)

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
;; (define (diag-num c)
;;   (inexact->exact (floor (/
;; 			  (- (sqrt (+ (* 8 c) 1))
;; 			     1)
;; 			  2))))

;; The other version of this, commented above, has numerical issues if 
;; c is too large but this version requires "(use numbers)" at the top
;; of this file, to use bignums.
;;   The idea here is that exact-integer-sqrt x returns s and k so that
;; s is the largest integer with s^2<x and s^2+k = x.  If taking s gives
;; a number that is an exact integer then the floor will be the same as using
;; the s, while if it give a number ending in .5 then to bump it up to where
;; the entire expression floors to one higher would require s+1, but we 
;; know s+1 is too big.
(define (diag-num c)
  (let ((s (exact-integer-sqrt (+ 1 (* 8 c)))))
    (floor-quotient (- s 1)
		    2)))

;; xy  given the cantor number, return (x y) 
(define (xy c)
  (let* ((d (diag-num c))
	 (t (triangle-num d)))
    (list (- c t)
	  (- d (- c t)))))

;; cantor-3 number triples
(define (cantor-3 x0 x1 x2)
  (cantor x0 (cantor x1 x2)))

; xy-3  Return the triple that gave (cantor-3 x0 x1 x2) => c
(define (xy-3 c)
  (cons (car (xy c))
	(xy (cadr (xy c)))))

;; cantor-4  Number quads
(define (cantor-4 x0 x1 x2 x3)
  (cantor x0 (cantor-3 x1 x2 x3)))

; xy-4  Un-number quads: give (x0 x1 x2 x3) so that (cantor-4 x0 x1 x2 x3) => c
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

;; cantor-omega encode the arity of the first component, so xy-omega ca
(define (cantor-omega . tuple)
  (if (null? tuple)
      (display "ERROR: cantor-omega requires a nonempty tuple")
      (let ((newtuple (list (length tuple) 
			    (apply cantor-n tuple))))
	(apply cantor newtuple))))

;; xy-arity  return the tuple of the given arity making the cantor number c
(define (xy-arity arity c)
  (if (= 1 arity)
      (list c)
      (cons (car (xy c))
	    (xy-arity (- arity 1) (cadr (xy c))))))

;; xy-omega  interpret c as a pair (arity cantor-number) and return the tuple
;;  of that arity and having that cantor number
(define (xy-omega c)
  (let* ((pair (xy c))
	 (arity (car pair))
	 (cantor-number (cadr pair)))
    (xy-arity arity cantor-number)))


;; ========
;; Machine counting
;; A Turing machine is a set of 4-tuples, subject to determinism.
;; A quad or instruction is a 4-tuple of natural numbers. 
;;    (current-state, current-tape-char, next-op, next-state)
;; A quadlist is a list of instructions, maybe not a set or nondeterministic.
;; Below we give a routine to interpret the numbers in a readable way:
;; current-tape-char is interpreted as:
;;   blank <-> 0, a <-> 1, b <-> 2, ..
;; next-op is interpreted as (the first two are tape head operations):
;;   L <-> 0, R <-> 1, blank <-> 2, a <-> 3, b <-> 4, ..  
;; TODO add conversions that use the instructions from the Turing simulation
;; in the prologue.

;; instruction->integer  Convert length-4 list to corresponging nat number
(define (instruction->integer ilist)
  (apply cantor-4 ilist))

;; integer->instruction Return the instruction corresponding to the input
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
  (let ((one (car fourtuple))
	(two (cadr fourtuple))
	(three (caddr fourtuple))
	(four (cadddr fourtuple)))
    (list (instruction-integer->tm-one one) 
	  (instruction-integer->tm-two two)
	  (instruction-integer->tm-three three)
	  (instruction-integer->tm-four four))))
(define (tminstruction->instruction fourtuple)
  (let ((one (car fourtuple))
	(two (cadr fourtuple))
	(three (caddr fourtuple))
	(four (cadddr fourtuple)))
    (list (tm->instruction-integer-one one) 
	  (tm->instruction-integer-two two) 
	  (tm->instruction-integer-three three)
	  (tm->instruction-integer-four four))))

;; quadlist->numlist convert list of 4-tuples m to list of corresponding
;;   natural numbers
(define (quadlist->numlist qlist)
  (map instruction->integer qlist))

;; numlist->quadlist  Return the list of quads represented by nlist
(define (numlist->quadlist nlist)
  (map integer->instruction nlist))

;; quad-less Lex ordering of two quads of numbers
;;  q1, q2  length 4 lists of numbers
(define (quad-less? q1 q2)
  (if (< (car q1) (car q2))
      #t
      (< (cadr q1) (cadr q2))))

;; first-two-equal?  are the first two elets of the two args equal?
;; q1, q2  length 4 lists of numbers
(define (first-two-equal? q1 q1)
  (and (= (car q1) (car q2))
       (= (cadr q1) (cadr q2))))

;; quadlist-is-set?  Is the list of quads a set?
;;  qlist  list of length 4 lists of numbers
(define (quadlist-is-set? qlist)
  (let ((sorted-qlist (sort qlist quad-less?)))
    (quadlist-is-set-helper sorted-qlist)))

;; quadlist-is-set-helper  walk list looking for adjacent quads that differ 
;; sq sorted list of quads
(define (quadlist-is-set-helper sq)
  (cond
   ((null? sq) #t)
   ((= 1 (length sq)) #t)
   ((equal? (car sq) (cadr sq)) #f)
   (else (quadlist-is-set-helper (cdr sq)))))

;; quadlist-is-deterministic?  Is the list of quads deterministic?
;;  qlist  list of length 4 lists of numbers
(define (quadlist-is-deterministic? qlist)
  (let ((sorted-qlist (sort qlist quad-less?)))
    (quadlist-is-deterministic-helper sorted-qlist)))

;; quadlist-is-set-helper  walk list looking for adjacent quads that differ 
;; sq sorted list of quads
(define (quadlist-is-deterministic-helper sq)
  (cond
   ((null? sq) #t)
   ((= 1 (length sq)) #t)
   ((first-two-equal? (car sq) (cadr sq)) #f)
   (else (quadlist-is-set-helper (cdr sq)))))

;; quadlist-is-tm  Decide if a quadlist is a Turing machine
;;  qlist  list of length 4 lists of numbers
;; Observe that if a quadlist is not a set then it is automatically not
;; deterministic so we need only check the one.
(define (quadlist-is-tm? qlist)
  (quadlist-is-deterministic? qlist))

;; godel  Return godel number of Turing machine m
(define (godel m)
  (apply cantor-omega (quadlist->numlist m)))

;; machine Return the list of 4-tuples represtented by the godel number g
(define (machine g)
  (let ((numlist (xy-omega g)))
    (numlist->quadlist numlist)))

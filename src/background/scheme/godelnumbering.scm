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
;; but this version requires "(use numbers)" at the top of the file.
;;   The idea here is that exact-integer-sqrt x returns s and k so that
;; s is the largest integer with s^2<x and s^2+k = x.  If taking s gives
;; a number that is an exact integer then the floor will be the sam eas using
;; the s, while if it give a number ending in .5 then to bump it up to where
;; the entire expression floors to one higher would require s+1, but we 
;; know s+1 is too big.
;; (define (diag-num c)
;;   (let ((s (exact-integer-sqrt (+ 1 (* 8 c)))))
;;     (floor-quotient (- s 1)
;; 		    2)))


(define (xy-3 c)
  (cons (car (xy c))
	(xy (cadr (xy c)))))

;; cantor-4 number quads
(define (cantor-4 x0 x1 x2 x3)
  (cantor x0 (cantor-3 x1 x2 x3)))

;; cantor-n number any-sized tuple
(define (cantor-n . args)
  (cond ((null? args) (display "ERROR: cantor-omega requires an input"))
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
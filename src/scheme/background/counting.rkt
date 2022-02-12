#lang racket
;; counting.rkt
;;  Cantor counting fcn

;; triangle-num  return 1+2+3+..+n
(define (triangle-num n)
  (/ (* (+ n 1)
     n)
     2))

;; cantor-unpairing  Cantor number of the pair (x,y) of integers
(define (cantor-unpairing x y)
  (let ((d (+ x y)))
    (+ (triangle-num d)
       x)))

;; diag-num 
(define (diag-num c)
  (let ([s (integer-sqrt (+ 1 (* 8 c)))])
    (floor (quotient (- s 1)
                     2))))

;; cantor-pairing  given the cantor number, return (x y) 
(define (cantor-pairing c)
  (let* ([d (diag-num c)]
         [t (triangle-num d)])
    (list (- c t)
      (- d (- c t)))))

;; cantor-unpairing-3 number triples
(define (cantor-unpairing-3 x0 x1 x2)
  (cantor-pairing x0 (cantor-pairing x1 x2)))

; cantor-pairing-3  Return the triple that gave (cantor-unpairing-3 x0 x1 x2) => c
(define (cantor-pairing-3 c)
  (cons (car (cantor-pairing c))
    (cantor-pairing (cadr (cantor-pairing c)))))

;; cantor-unpairing-4  Number quads
(define (cantor-unpairing-4 x0 x1 x2 x3)
  (cantor-unpairing x0 (cantor-unpairing-3 x1 x2 x3)))

; cantor-pairing-4  Un-number quads: give (x0 x1 x2 x3) so that (cantor-unpairing-4 x0 x1 x2 x3) => c
(define (cantor-pairing-4 c)
  (let ((pr (cantor-pairing c)))
    (cons (car pr)
      (cantor-pairing-3 (cadr pr)))))

;; These routines generalize: number any tuple, or find the tuple corresponging
;; to a number.
;;   The only ugliness is that the empty tuple is unique, so there is only
;; one tupe of that arity.

;; cantor-n number any-sized tuple
(define (cantor-unpairing-n . args)
  (cond ((null? args) 0)
    ((= 1 (length args)) (car args))
    ((= 2 (length args)) (cantor-unpairing (car args) (cadr args)))
    (else 
     (cantor-unpairing (car args) (apply cantor-unpairing-n (cdr args))))))

;; cantor-pairing-arity  return the list of the given arity making the cantor number c
;;  If arity=0 then only c=0 is valid (others return #f)
(define (cantor-pairing-arity arity c)
  (cond ((= 0 arity) 
     (if (= 0 c ) 
         '()
         (begin
           (display "ERROR: cantor-pairing-arity with arity=0 requires c=0") (newline)
           #f)))
    ((= 1 arity) (list c))
    (else (cons (car (cantor-pairing c))
            (cantor-pairing-arity (- arity 1) (cadr (cantor-pairing c)))))))

;; The next two routines give correspondences between the natural numbers
;; and the set of sequences of natural numbers.  They are inverse.
;; The null sequence is the issue; there is only one.  So we code like this:
;;   null sequence <--> (0,0)
;;   (i)           <--> (0,i+1)
;;   (a_0,.. a_n)  <--> (n-1,number of (a_0,.. a_n))

;; cantor-unpairing-omega encode the arity in the first component
(define (cantor-unpairing-omega . tuple)
  (let ((arity (length tuple)))
    (cond ((= arity 0) (cantor-unpairing 0 0))
      ((= arity 1) (cantor-unpairing 0 (+ 1 (car tuple))))
      (else 
       (let ((newtuple (list (- arity 1) 
             (apply cantor-unpairing-n tuple))))
         (apply cantor-unpairing newtuple))))))

;; cantor-pairing-omega  Inverse of cantor-unpairing-omega  
(define (cantor-pairing-omega c)
  (let* ((pr (cantor-pairing c))
     (a (car pr))
     (cantor-number (cadr pr)))
    (cond
     ((and (= a 0)
       (= cantor-number 0)) '())
     ((= a 0) (list (- cantor-number 1)))
     (else (cantor-pairing-arity (+ 1 a) cantor-number)))))
#lang racket
;; counting.rkt
;;  Cantor counting functions
;; 2022-Feb-13 Jim Hefferon GPL

;; triangle-num  return 1+2+3+..+n
;;   natural number -> natural number
(define (triangle-num n)
  (/ (* (+ n 1)
     n)
     2))

(module+ test
  (require rackunit)
  (check-equal? (triangle-num 3) 6)
  (check-equal? (triangle-num 0) 0)
  (check-equal? (triangle-num 1) 1)
  (check-equal? (triangle-num 2) 3)
  (check-equal? (triangle-num 4) 10)
  )

;; cantor-unpairing  Cantor number of the pair (x,y)
;;  natural number, natural number -> natural number
(define (cantor-unpairing x y)
  (let ((d (+ x y)))
    (+ (triangle-num d)
       x)))

;; unpair  Synonym for cantor-unpairing
(define (unpair x y)
  (cantor-unpairing x y))

;; untuple-2  Synonym for cantor-unpairing
(define (untuple-2 x y)
  (cantor-unpairing x y))

(provide cantor-unpairing)

(module+ test
  (check-equal? (cantor-unpairing 0 0) 0)
  (check-equal? (cantor-unpairing 0 1) 1)
  (check-equal? (cantor-unpairing 1 0) 2)
  (check-equal? (cantor-unpairing 0 2) 3)
  (check-equal? (cantor-unpairing 1 1) 4)
  )

;; diag-num  Give number of diagonal containing Cantor pair numbered c
;;  natural number -> natural number
;;  c  Where (cantor-unpairing x y) -> c, return x+y
(define (diag-num c)
  (let ([s (integer-sqrt (+ 1 (* 8 c)))])
    (floor (quotient (- s 1)
                     2))))

(provide diag-num)

;; cantor-pairing  Given the cantor number, return the pair with that number
;;   natural number -> list (natural number, natural number)
;;   c  Where (cantor-unpairing x y) -> c, return (x y)
(define (cantor-pairing c)
  (let* ([d (diag-num c)]
         [t (triangle-num d)])
    (list (- c t)
      (- d (- c t)))))

;; pair  Synonym for cantor-pairing
(define (pair c)
  (cantor-pairing c))

;; tuple-2  Synonym for cantor-pairing
(define (tuple-2 c)
  (cantor-pairing c))

(provide cantor-pairing)

(module+ test
  (check-equal? (cantor-pairing 0) '(0 0))
  (for ([x (range 4)]
        [y (range 4)])
    (check-equal? (list x y)
                  (cantor-pairing (cantor-unpairing x y))))
  (for ([c (range 10)])
    (check-equal? c
                  (apply cantor-unpairing (cantor-pairing c))))
  )

;; cantor-unpairing-3  Cantor number of a triple
;;  natural number, natural number, natural number -> natural number
(define (cantor-unpairing-3 x0 x1 x2)
  (cantor-unpairing x0 (cantor-unpairing x1 x2)))

;; untuple-3  Synonym for cantor-unpairing-3
(define (untuple-3 x0 x1 x2)
  (cantor-unpairing-3 x0 x1 x2))

(provide cantor-unpairing-3)

(module+ test
  (check-equal? (cantor-unpairing-3 0 0 0) 0)
  (for ([x (range 4)]
        [y (range 4)]
        [z (range 4)])
    (check-equal? (list x y z)
                  (cantor-pairing-3 (cantor-unpairing-3 x y z))))
  (for ([c (range 15)])
    (check-equal? c
                  (apply cantor-unpairing-3 (cantor-pairing-3 c))))
  )

;; cantor-pairing-3  Return the triple that gave (cantor-unpairing-3 x0 x1 x2) => c
;;   natural number -> (natural natural natural)
(define (cantor-pairing-3 c)
  (cons (car (cantor-pairing c))
    (cantor-pairing (cadr (cantor-pairing c)))))

;; tuple-3  Synonym for cantor-pairing-3
(define (tuple-3 c)
  (cantor-pairing-3 c))

(provide cantor-pairing-3)

(module+ test
  (check-equal? (cantor-pairing-3 0) '(0 0 0))
  (for ([x (range 4)]
        [y (range 4)])
    (check-equal? (list x y)
                  (cantor-pairing (cantor-unpairing x y))))
  (for ([c (range 10)])
    (check-equal? c
                  (apply cantor-unpairing (cantor-pairing c))))
  )

;; cantor-unpairing-4  Number quads
(define (cantor-unpairing-4 x0 x1 x2 x3)
  (cantor-unpairing x0 (cantor-unpairing-3 x1 x2 x3)))

;; untuple-4  Synonym for cantor-unpairing-4
(define (untuple-4 x0 x1 x2 x3)
  (cantor-unpairing-4 x0 x1 x2 x3))

(provide cantor-unpairing-4)

; cantor-pairing-4  Un-number quads: give (x0 x1 x2 x3) so that (cantor-unpairing-4 x0 x1 x2 x3) => c
(define (cantor-pairing-4 c)
  (let ((pr (cantor-pairing c)))
    (cons (car pr)
      (cantor-pairing-3 (cadr pr)))))

;; tuple-4  Synonym for cantor-pairing-4
(define (tuple-4 c)
  (cantor-pairing-4 c))

(provide cantor-pairing-4
         tuple-4)

;; These routines generalize: number any tuple, or find the tuple corresponding
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

(provide cantor-unpairing-n)

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

(provide cantor-pairing-arity)

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

(provide cantor-unpairing-omega
         cantor-pairing-omega)
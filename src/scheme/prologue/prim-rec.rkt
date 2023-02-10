#lang racket
;; ===== Primitive recursive functions
;; Defns for primitive recursive functions, for fun

;; integer -> integer
;; Always return zero
(define (Z x)
  0)
;(module+ test
;  (require rackunit)
;  (check-equal? 0 (Z 0))
;  (check-equal? 0 (Z 1))
;  )

;; integer -> integer
;; Return the successor of the input
(define (successor x)
  (+ 1 x))
;(module+ test
;  (require rackunit)
;  (check-equal? 1 (successor 0))
;  (check-equal? 2 (successor 1))
;  )


(define (i1_1 x0)  ;; projections 
  x0)
(define (i2_1 x0 x1) 
  x0)
(define (i2_2 x0 x1) 
  x1)
(define (i3_1 x0 x1 x2) 
  x0)
(define (i3_2 x0 x1 x2) 
  x1)
(define (i3_3 x0 x1 x2) 
  x2)

(provide Z
         successor
         i1_1
         i2_1
         i2_2
         i3_1
         i3_2
         i3_3)

;; Schema of primitive recursion, for arity 1 and 2

(define (pred x)  ;; convenience for defn of schema of prim rec
  (if (= x 0)
      0
      (- x 1)))

(provide pred)

;; prim-rec-1  Return a function of one variable computed by primitive recursion
(define (prim-rec-1 g h)  ;; g fcn of 0 args, h fcn of 2 args
  (define (f y)
    (if (= y 0)
	g
	(h (f (pred y)) (pred y))))
  f)

;; prim-rec-2  Return a fcn of two variables computed by primitive recursion
(define (prim-rec-2 g h)   ;; g fcn of 1 arg, h fcn of 3 args
  (define (f x0 y)
    (if (= y 0)
	(g x0)
	(h (f x0 (pred y))  x0 (pred y))))
  f)

(provide prim-rec-1
         prim-rec-2)


;; Some simple ones
(define plus
  (prim-rec-2 i1_1
	      (lambda (w x0 z) (successor w))))

(define product
  (prim-rec-2 Z
	      (lambda (w x0 z) (plus w x0))))

(define (one x)
  (successor (Z x)))

(define power 
  (prim-rec-2 one
	      (lambda (w x0 z) (product w x0))))

(define propersub
  (prim-rec-2 i1_1
	      (lambda (w x0 z) (pred w))))

(provide plus
         product
         one
         power
         propersub)



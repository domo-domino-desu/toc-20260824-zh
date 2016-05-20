;; Run programs in LOOP.
;; Adapted from _Computability in an INtro Course on Programming_
;; by Hans Jurgen Schnieder


;; defns for primitive recursive functions, for fun
(define (Z x)
  0)
(define (succ x)
  (+ x 1))
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

(define (pred x)  ;; convenience for defn of schema of prim rec
  (if (= x 0)
      0
      (- x 1)))

;; prim-rec-1  Return a function of one variable computed by primitive recursion
(define (prim-rec-1 g h)  ;; g fcn of 0 args, h fcn of 2 args
  (define (f y)
    (if (= y 0)
	g
	(h (f (pred y)) (pred y))))
  f)

;; prim-rec-2  Return a function of two variables comuted by primitive recursion
(define (prim-rec-2 g h)   ;; g fcn of 1 arg, h fcn of 3 args
  (define (f x0 y)
    (if (= y 0)
	(g x0)
	(h (f x0 (pred y))  x0 (pred y))))
  f)

(define plus
  (prim-rec-2 i1_1
	      (lambda (w x0 z) (succ w))))
(define product
  (prim-rec-2 Z
	      (lambda (w x0 z) (plus w x0))))
(define (one x)
  1)
(define power 
  (prim-rec-2 one
	      (lambda (w x0 z) (product w x0))))

(define propersub
  (prim-rec-2 i1_1
	      (lambda (w x0 z) (pred w))))


;; (define (propersub_reverse x y)
;;   (prim-rec-1 i1_1
;; 	      (lambda (z x y)
;; 		(pred (i3_1 z x y)))))
;; (define (propersub x y)
;;   (propersub_reverse (i2_2 x y) (i2_1 x y)))
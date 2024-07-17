#lang racket
;; mu-addition Exercise on unbounded minimization

(define (g x y)
  (if (= 100 (+ x y))
      0
      1))

(define (f x)
  (define (f-helper y)  ; value of x inherited from enclosing defn of f
    (if (= 0 (g x y))
        y
        (f-helper (+ 1 y))))
  
  (f-helper 0))


;; Like the prior one but using multiplication
(define (g-mult x y)
  (if (= 100 (* x y))
      0
      1))

(define (f-mult x)
  (define (f-helper y)  ; value of x inherited from enclosing defn of f-mult
    (if (= 0 (g-mult x y))
        y
        (f-helper (+ 1 y))))
  
  (f-helper 0))

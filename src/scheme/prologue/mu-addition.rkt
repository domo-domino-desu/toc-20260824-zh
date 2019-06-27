#lang racket
;; mu-addition Exercise on unbounded minimization

(define (g x y)
  (+ x y))

(define (f x)
  (define (f-helper x y)
    (if (= 100 (g x y))
        y
        (f-helper x (+ 1 y))))
  (let ([y 0])
    (f-helper x 0)))

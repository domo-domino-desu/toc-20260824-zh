#lang racket
;; mu-addition Exercise on unbounded minimization

(define (g x y)
  (if (= 100 (+ x y))
      0
      1))

(define (f x)
  (define (f-helper x y)
    (if (= 0 (g x y))
        y
        (f-helper x (+ 1 y))))
  (let ([y 0])
    (f-helper x 0)))

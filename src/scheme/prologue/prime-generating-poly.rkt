#lang racket
;; prime-generating-poly.rkt

(require math/number-theory)  ;; provides prime? 

;; p  Compute the value of the function given by y |->  x0 * y^2 + x1 * y + x2
(define (p x0 x1 x2 y)
  (+ (* x0 y y) (* x1 y) x2))

(provide p)

;; g  Test p's output for primality
(define (g x0 x1 x2 y)
  (if (prime? (p x0 x1 x2 y))
      1
      0))

(provide g)

;; f  Unbounded search to test if quadratic poly with params generates only primes
(define (f x0 x1 x2)
  (define (f-helper y)
    (if (= 0 (g x0 x1 x2 y))
        y
        (f-helper (add1 y))))
  
    (f-helper 0))

(provide f)
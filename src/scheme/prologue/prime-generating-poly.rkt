#lang racket
;; prime-generating-poly.rkt

;; prime?  Brute force test for primality; stops if no factor bigger than square root found
(define (prime? n)
  (define (prime-helper n c)
    (cond [(< n (* c c)) 0]
          [(zero? (modulo n c)) 1]
          [else (prime-helper n (add1 c))]))
  
  (prime-helper n 2))

;; p  Compute the value of the function given by y |->  x2 * y^2 + x1 * y + x0
(define (p x0 x1 x2 y)
  (+ (* x2 y y) (* x1 y) x0))

;; g-sub-p  Test p's output for primality
(define (g-sub-p x0 x1 x2 y)
  (prime? (p x0 x1 x2 y)))

;; f-sub-g  Unbounded search to test if quadratic poly with params generates only primes
(define (f-sub-g x0 x1 x2)
  (define (f-sub-g-helper y)
    (if (= 0 (g-sub-p x0 x1 x2 y))
        y
        (f-sub-g-helper (add1 y))))
  
  (let ([y 0])
    (f-sub-g-helper y)))


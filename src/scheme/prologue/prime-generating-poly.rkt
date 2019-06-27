#lang racket
;; prime-generating-poly.rkt

;; prime?  Brute force test for primality; stops if no factor bigger than square root found
(define (prime? n)
  (define (prime-helper n c)
    (cond [(< n (* c c)) #t]
          [(zero? (modulo n c)) #f]
          [else (prime-helper n (add1 c))]))
  
  (prime-helper n 2))

;; candidate-poly  the function y |-> y^2 + y + 41
(define (candidate-poly y)
  (+ (* y y) y 41))

;; f  Unbounded search to test if candidate-poly generates only primes
(define (f)
  (define (f-helper y)
    (if (not (prime? (candidate-poly y)))
        y
        (f-helper (add1 y))))
  
  (let ([y 0])
    (f-helper y)))

;; g  Return the function given by y |->  ay^2 + by + c
(define (g x0 x1 x2 y)
  (+ (* x0 y y) (* x1 y) x2))

;; f-sub-g?  Unbounded search to test if given quadratic poly generates only primes
(define (f-sub-g x0 x1 x2)
  (define (f-sub-g-helper y)
    (if (not (prime? (g x0 x1 x2 y)))
        y
        (f-sub-g-helper (add1 y))))
  
  (let ([y 0])
    (f-sub-g-helper y)))


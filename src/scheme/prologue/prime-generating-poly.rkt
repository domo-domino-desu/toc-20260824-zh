#lang racket
;; prime-generating-poly.rkt

(require math/number-theory)  ;; provides predicate: prime? 

;; p  Compute the value of the function y |->  x0 * y^2 + x1 * y + x2
(define (p x0 x1 x2 y)
  (+ (* x0 y y) (* x1 y) x2))

(provide p)

;; g  Test quadratic polynomial's output for primality
(define (g x0 x1 x2 y)
  (if (prime? (+ (* x0 y y) (* x1 y) x2))
      1
      0))

(provide g)

;; f  Unbounded search to find least y where quad poly is not prime
(define (f x0 x1 x2)
  (define (f-helper y)   ; x0, x1, x2 inherited from enclosing def of f
    (if (= 0 (g x0 x1 x2 y))
        y
        (f-helper (add1 y))))
  
    (f-helper 0))

(provide f)

;; Check if a number n is the sum of two primes
;; Returns minimal i < n such that i and n-i are prime; returns #f if no such i
(define (gb-check n)
  (for/first ([i (in-range 2 (add1 n))]
              #:when (and (prime? i)
                          (prime? (- n i))))
    i))

;; demonstrate that for/first returns #f if when is never triggered
(define (test-never)
  (for/first ([i (in-range 2 10)]
              #:when (< i 0))
    i))

;; Use gb-check to return predicate
(define (gb-g y)
  (if (gb-check (* 2 y))
      1
      0))

(define (gb-f)
  (define (gb-f-helper y)
    (if (= 0 (gb-g y))
        y
        (gb-f-helper (add1 y))))
  
    (gb-f-helper 2)) ;; start with 4
;; GCD  Compute the GCD of two numbers
;; Use a recurrence based on Euclid's observation that if a>b then the set
;; of common divisors of a and b is the same as the set of common divisors
;; of a-b and b
#lang racket

(define (gcd-first a b)
  (cond
    [(zero? a) b]
    [(zero? b) a]
    [(> b a) (gcd-first b a)]
    [else (gcd-first (- a b) b)]))

(module+ test
  (require rackunit)
  (check-equal? (gcd-first 9 12) 3)
  (check-equal? (gcd-first 256 125) 1)
  (check-equal? (gcd-first 0 7) 7)
  (check-equal? (gcd-first 5 0) 5)
  (check-equal? (gcd-first 0 0) 0)
  )

(define (gcd-second a b)
  (if (zero? b)
      a
      (gcd-second b (remainder a b))))

(module+ test
  (require rackunit)
  (check-equal? (gcd-second 9 12) 3)
  (check-equal? (gcd-second 256 125) 1)
  (check-equal? (gcd-second 0 7) 7)
  (check-equal? (gcd-second 5 0) 5)
  (check-equal? (gcd-second 0 0) 0)
  )

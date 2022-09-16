;; GCD  Compute the GCD of two numbers
;; Use a recurrence based on these rules:
;; gcd(x+y,y)=gcd(x,y)
;; gcd(x,y)=gcd(y,x)
;; gcd(x,x)=x
;; gcd(x,1)=1

#lang racket
(define (gcd a b)
  (cond
    [(= a b)
     a]
    [(= b 1)
     1]
    [(> b a)
     (gcd b a)]
    [else
     (gcd (- a b) b)]))

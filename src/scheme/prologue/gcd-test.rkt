#lang racket
(require rackunit
         "gcd.rkt")

(test-case
  "Check simple"
  (check = 2 (gcd-euclid 12 10))
  (check = 3 (gcd-euclid 15 9))
  (check = 1 (gcd-euclid 12 11)))

(test-case
  "Check reversed args"
  (check = (gcd-euclid 12 10) (gcd-euclid 10 12))
  (check = (gcd-euclid 9 15) (gcd-euclid 15 9)))

(test-case
  "Check zero"
  (check = 10 (gcd-euclid 10 0)))

#lang racket
(require rackunit
         "primitive-recursive.rkt")

(test-case
  "Check successor"
  (check = 2 (successor 1))
  (check = 1 (successor 0)))

(test-case
  "Check plus"
  (check = 7 (plus 3 4))
  (check = 1 (plus 0 1))
  (check = 1 (plus 1 0))
  (check = 0 (plus 0 0)))

(test-case
  "Check product"
  (check = 12 (product 3 4))
  (check = 0 (product 0 1))
  (check = 0 (product 1 0))
  (check = 0 (product 0 0)))

(test-case
  "Check power"
  (check = 81 (power 3 4))
  (check = 0 (power 0 1))
  (check = 1 (power 1 0))
  (check = 1 (power 0 0)))

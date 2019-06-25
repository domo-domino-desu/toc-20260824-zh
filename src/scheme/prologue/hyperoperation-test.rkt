#lang racket
(require rackunit
         "hyperoperation.rkt")

(test-case
  "Check simple"
  (check = 3 (H 0 1 2))
  (check = 5 (H 1 2 3))
  (check = 12 (H 2 3 4)))

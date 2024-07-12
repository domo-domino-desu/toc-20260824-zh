#lang racket
(require rackunit
         "prime-generating-poly.rkt")

;; ======= prime testing predicate g ===== 
(check-equal? 1 (g 1 1 41 0))
(check-equal? 1 (g 1 1 41 1))
(check-equal? 1 (g 1 1 41 2))
(check-equal? 1 (g 1 1 41 39))
(check-equal? 0 (g 1 1 41 40))


;; ======= unbounded search f ===== 
(check-equal? 40 (f 1 1 41))


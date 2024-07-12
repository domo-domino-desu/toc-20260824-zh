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


;; ====================
;; Goldbach's conjecture

;; ======= gb-check ===== 
(check-equal? 2 (gb-check 4))
(check-equal? 3 (gb-check 6))
(check-equal? 3 (gb-check 8))
(check-equal? 3 (gb-check 10))
(check-equal? 5 (gb-check 12))
(check-equal? 3 (gb-check 14))
(check-equal? 3 (gb-check 16))
(check-equal? 5 (gb-check 18))
(check-equal? 3 (gb-check 20))
;; ======= gb-check returns #f if no such ===== 
(check-equal? #f (gb-check 27))

;; ======= gb-g ===== 
(check-equal? 1 (gb-g 4))
(check-equal? 1 (gb-g 6))
(check-equal? 1 (gb-g 8))
(check-equal? 1 (gb-g 10))
(check-equal? 1 (gb-g 12))
(check-equal? 1 (gb-g 14))
(check-equal? 1 (gb-g 16))
(check-equal? 1 (gb-g 18))
(check-equal? 1 (gb-g 20))
(check-equal? 1 (gb-g 2))
(check-equal? 1 (gb-g 1))




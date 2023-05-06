#lang racket

;; natural number -> natural number
;; See Wikipedia on the Collatz conjecture. 
(define (hailstone n)
  (cond
    [(or (= n 0)
         (= n 1)) 1]
    [(even? n) (hailstone (/ n 2))]
    [else (hailstone (+ 1 (* n 3)))]))
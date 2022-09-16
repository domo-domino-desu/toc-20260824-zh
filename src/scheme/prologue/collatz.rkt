#lang racket
;; Collatz conjecture numbers

;; 3n+1 function
(define (H n)
  (if (even? n)
      (/ n 2)
      (+ (* 3 n) 1)))

;; Collatz numer calculator: use unbounded search to find it
(define (C n)
  (define (C-helper n k)
    (if (= 1 n)
        k
        (C-helper (H n) (add1 k))))

  (C-helper n 0))
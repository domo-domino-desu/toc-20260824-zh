#lang racket
;; Simple functions to illustrate Big Oh
;; For Thoery of Computation book Jim Hefferon
;; 2025-Jan-03 Public Domain

(define (g0 n)
  (for ([i (in-range n)])
    (let ([x (* n n)])
      (for ([j (in-range n)])
        (printf "~a " (+ x i j))))))


(define (g1 n)
  (let ([x (* n n)])
    (for ([i (in-range n)])
      (for ([j (in-range n)])
        (printf "~a " (+ x i j))))))


(define (f n)
  (for ([i (in-range n)])
    (printf "~a " i)))

#lang racket
(define (g0 n)
  (for ([i '(0 1 2 3 4)])
    (let ([x (* n n)])
      (printf "~a " (+ i x)))))

(define (g1 n)
  (let ([x (* n n)])
    (for ([i '(0 1 2 3 4)])
      (printf "~a " (+ i x)))))
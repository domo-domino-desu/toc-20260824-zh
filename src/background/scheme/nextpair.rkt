#lang racket
(define (nextpair p)
  (let ((x (first p))
        (y (second p)))
  (if (= y 0)
      (list 0 (+ x 1))
      (list (+ x 1) (- y 1)))))

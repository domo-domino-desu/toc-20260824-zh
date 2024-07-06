#lang racket

;; Quine, credit Kevin Matulef
(define self
  (lambda (w)
    ((lambda (w) (list (quote lambda)
                       (quote (w))
                       (list w ((lambda (w) (list (quote quote) w)) w))))
     (quote
      (lambda (w) (list (quote lambda)
                        (quote (w))
                        (list w ((lambda (w) (list (quote quote) w)) w))))))))
#lang racket

;; hyperopertion  Ackermann's original function generalizing successor, etc.
(define (H n x y)
  (cond
      [(= n 0) (+ y 1)]
      [(and (= n 1) (= y 0)) x]
      [(and (= n 2) (= y 0)) 0]
      [(and (> n 2) (= y 0)) 1]
      [else (H (- n 1) x (H n x (- y 1)))]))

(define (H-fast n x y)
  (cond
      [(= n 0) (+ y 1)]
      [(and (= n 1) (= y 0)) x]
      [(and (= n 2) (= y 0)) 0]
      [(and (> n 2) (= y 0)) 1]
      [else (H-fast (- n 1) x (H-fast n x (- y 1)))]))

(provide H
         H-fast)

;; To get the outputs for Asymptote
;;(for ([y (in-range 10)])
;;    (printf "(~a,~a),\n" y (H 1 2 y)))
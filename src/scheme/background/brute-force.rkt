#lang racket

;; Return the pair following p in Cantor's correspondence
(define (next-pair p)
  (let ((x (first p))
        (y (second p)))
    (if (= y 0)
        (list 0 (+ x 1))
        (list (+ x 1) (- y 1)))))

;; Find pair n by brute force
(define (brute-force-pairing n)
  (define (bfp-helper j pr)
    (if (zero? j)
        pr
        (bfp-helper (sub1 j) (next-pair pr))))

  (bfp-helper n (list 0 0)))

(provide next-pair
         brute-force-pairing)
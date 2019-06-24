#lang racket
;; primitive-recursion.rkt
;;   Primitive recursive functions
;; File information at end.

;; successor  The ++ operation
(define (successor x)
  (+ x 1))

(provide successor)

;; plus  Addition of two natural numbers
(define (plus x y)
  (let ((z (- y 1)))
    (if (= y 0)
        x
        (successor (plus x z)))))

(provide plus)

;; product  Multiplication of two natural numbers
(define (product x y)
  (let ((z (- y 1)))
    (if (= y 0)
        0
        (plus (product x z) x))))

(provide product)

;; power  Exponentiation of two natural numbers
(define (power x y)
  (let ((z (- y 1)))
    (if (= y 0)
        1
        (product (power x z) x))))

(provide power)

;; File information: 
;; 2019-Jun-24 Jim Hefferon GPL 3

#lang racket

;; Used to illustrate freezing an input for slides on s-m-n 
(define (power base exponent) ; bit silly because 
  (expt base exponent))       ; expt does the same and is built in

(define (identity_fcn base) 
  (power base 1))
(define (square_fcn base)
  (power base 2))
(define (cube_fcn base)
  (power base 3))
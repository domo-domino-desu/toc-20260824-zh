#lang racket
;; This pertains to an exercise in the subsection on general recursion

;; g Function given in exercise
(define (g x y)
  (ceiling (- (/ (add1 x) (add1 y))
              1)))

;; f  Compute from g by mu-recursion
(define (f x)
  (define (f-helper y)
    (if (= 0 (g x y))
        y
        (f-helper (add1 y))))

  (let ([y 0])
    (f-helper y)));; f  Compute from g by mu-recursion

(define (f-verbose x)
  (define (f-verbose-helper y)
    (printf "x=~a y=~a g(x,y)=~a\n" x y (g x y))
    (if (= 0 (g x y))
        y
        (f-verbose-helper (add1 y))))

  (let ([y 0])
    (f-verbose-helper y)))
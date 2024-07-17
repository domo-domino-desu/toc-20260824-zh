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

(define (C-verbose n)
  (define (C-verbose-helper n k)
      (printf "n=~a k=~a H(n)=~a\n" n k (H n))
      (if (= 1 n)
          k
          (C-verbose-helper (H n) (add1 k))))

  (C-verbose-helper n 0))
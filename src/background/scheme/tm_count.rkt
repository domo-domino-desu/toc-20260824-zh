#lang racket
(module+ test
  (require rackunit))

;; Return the pair (i,j) counted n-th where set0 is infinite and set1 is finite
(define (count-infinite-cross-finite n set0 set1)
  (let ([m (length set1)])
    (list (list-ref set0 (quotient n m))
          (list-ref set1 (remainder n m)))))

;; Sanity check:
;;  6|  2  5  8 11 14
;;  4|  1  4  7 10 13
;;  2|  0  3  6  9 12  
;;    --------------------------------
;;      1  3  5  7  9
(module+ test
  (let ([s0 (list 1 3 5 7 9)]  ;; practically infinite ...
        [s1 (list 2 4 6)])
    (check-equal? (count-infinite-cross-finite 3 s0 s1)
                  '(3 2))
    (check-equal? (count-infinite-cross-finite 0 s0 s1)
                  '(1 2))
    (check-equal? (count-infinite-cross-finite 8 s0 s1)
                  '(5 6))
    (check-equal? (count-infinite-cross-finite 13 s0 s1)
                  '(9 4))
  ))
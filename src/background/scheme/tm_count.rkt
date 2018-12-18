#lang racket
(module+ test
  (require rackunit))

;; Return the nth elet of a list, or an error if list is too short
(define (nth lst counter)
  (cond ((null? lst) (error 'nth "index out of bounds"))
        ((= counter 0) (first lst))
        (else (nth (rest lst) (- counter 1)))))

;; Find position of an element in list (first occurrence)
(define (pos lst elet)
  (define (pos-helper lst elet dex)
    (cond ((null? lst) (error 'pos "element not in list"))
          ((equal? elet (first lst)) dex)
          (else (pos-helper (cdr lst) elet (+ dex 1)))))
  (pos-helper lst elet 0))

(module+ test
  (check-equal? (pos '(1 3 5) 3) 1)
  (check-equal? (pos '(1 3 5) 1) 0)
  (check-equal? (pos '(#\a #\b #\c) #\b) 1)
  (check-equal? (pos '(1 3 3) 3) 1)
  (check-equal? (pos '(3) 3) 0)
  (check-exn
   exn:fail?
   (lambda () (pos '(3 4 5 6) 2)))
  )


;; === infinite cross finite ===
;; Return the pair (i,j) counted n-th where set0 is infinite and set1 is finite
(define (pair-infinite-cross-finite n set0 set1)
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
    (check-equal? (pair-infinite-cross-finite 3 s0 s1)
                  '(3 2))
    (check-equal? (pair-infinite-cross-finite 0 s0 s1)
                  '(1 2))
    (check-equal? (pair-infinite-cross-finite 8 s0 s1)
                  '(5 6))
    (check-equal? (pair-infinite-cross-finite 13 s0 s1)
                  '(9 4))
  ))


;; Return the n associated with (i,j)
(define (unpair-infinite-cross-finite p set0 set1)
  (let ([m (length set1)])
    (+ (pos set1 (second p))
       (* m (pos set0 (first p))))))

(module+ test
  (let ([s0 (list 1 3 5 7 9)]  ;; practically infinite ...
        [s1 (list 2 4 6)])
    (check-equal? 10 (unpair-infinite-cross-finite (list 7 4) s0 s1))
    (check-equal? 0 (unpair-infinite-cross-finite (list 1 2) s0 s1))
    (check-equal? 5 (unpair-infinite-cross-finite (list 3 6) s0 s1))
    (check-equal? 14 (unpair-infinite-cross-finite (list 9 6) s0 s1))
    ))



;; === finite cross infinite ===
;; Return the pair (i,j) counted n-th where set0 is finite and set1 is infinite
(define (pair-finite-cross-infinite n set0 set1)
  (let ([m (length set0)])
    (list (list-ref set0 (remainder n m))
          (list-ref set1 (quotient n m)))))


;; Sanity check:
;; 12| 15 16 17
;; 10| 12 13 14
;;  8|  9 10 11
;;  6|  6  7  8
;;  4|  3  4  5
;;  2|  0  1  2
;;    ---------
;;      1  3  5 
(module+ test
  (let ([s0 (list 1 3 5)]  
        [s1 (list 2 4 6 8 10 12)])
    (check-equal? (pair-finite-cross-infinite 3 s0 s1)
                  '(1 4))
    (check-equal? (pair-finite-cross-infinite 0 s0 s1)
                  '(1 2))
    (check-equal? (pair-finite-cross-infinite 8 s0 s1)
                  '(5 6))
    (check-equal? (pair-finite-cross-infinite 7 s0 s1)
                  '(3 6))
    (check-equal? (pair-finite-cross-infinite 16 s0 s1)
                  '(3 12))
  ))

;; Return the n associated with (i,j)
(define (unpair-finite-cross-infinite p set0 set1)
  (let ([m (length set0)])
    (+ (pos set0 (first p))
       (* m (pos set1 (second p))))))

(module+ test
  (let ([s0 (list 1 3 5)]  
        [s1 (list 2 4 6 8 10 12)])
    (check-equal? 3 (unpair-finite-cross-infinite (list 1 4) s0 s1))
    (check-equal? 0 (unpair-finite-cross-infinite (list 1 2) s0 s1))
    (check-equal? 8 (unpair-finite-cross-infinite (list 5 6) s0 s1))
    (check-equal? 7 (unpair-finite-cross-infinite (list 3 6) s0 s1))
    ))



;; === infinite cross infinite ===

;; Return the n associated with (i,j)
(define (unpair-infinite-cross-infinite p set0 set1)
  (let ([x (pos set0 (first p))]
        [y (pos set1 (second p))])
    (+ (/ (* (+ x y)
             (+ x y 1))
          2)
       x)))

;; Sanity check:
;; 12| 15 
;; 10| 10 16 
;;  8|  6 11 17
;;  6|  3  7 12 18
;;  4|  1  4  8 13 19 
;;  2|  0  2  5  9 14 20
;;    -----------------
;;      1  3  5  7  9 11
(module+ test
  (let ([s0 (list 1 3 5 7 9 11)]  
        [s1 (list 2 4 6 8 10 12)])
    (check-equal? 7 (unpair-infinite-cross-infinite (list 3 6) s0 s1))
    (check-equal? 0 (unpair-infinite-cross-infinite (list 1 2) s0 s1))
    (check-equal? 15 (unpair-infinite-cross-infinite (list 1 12) s0 s1))
    (check-equal? 20 (unpair-infinite-cross-infinite (list 11 2) s0 s1))
    ))


;; triangle-num return 1+2+3+..+ n
(define (triangle-num n)
   (/ (* (+ n 1)
         n)
      2))

(define (diag-num c)
  (let ([s (exact-integer-sqrt (+ 1 (* 8 c )))])
    (floor-quotient (- s 1)
                    2)))

;; xy given the cantor number , return (x y)
(define (pair-infinite-cross-infinite c)
 (let* ([d (diag-num c)]
        [t (triangle-num d)])
   (list (- c t)
         (- d (- c t )))))
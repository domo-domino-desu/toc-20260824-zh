#lang rosette/safe

;; A SMALL BOARD is 2x2.  A solution consists of a 1 and a 0 in each row and column.
;;  The predicate v_i_j is T if there is a 1 in row i and column j, and F otherwise.
(define-symbolic v00 v01 v10 v11 boolean?)

(define (check-small-board)
  ;; On each row is at least one T
  (assert (and (or v00 v01)
               (or v10 v11)))
  ;; In each column is at least one T
  (assert (and (or v00 v10)
               (or v01 v11)))
  ;; On each row there are not two T's
  (assert (or (not v00) (not v01)))
  (assert (or (not v10) (not v11)))
  ;; In each column there are not two T's
  (assert (or (not v00) (not v10)))
  (assert (or (not v01) (not v11)))
  )

;; Soduku board
(define (generate-var-list)
    (define-symbolic y boolean? #:length (* 9 9 9))
    y)
(define VARIABLE-LIST (generate-var-list))
(define (get-pred row column value)
  (list-ref VARIABLE-LIST (+ (* 81 (- value 1))
                             (* 9 (- row 1))
                             (- column 1))))

;; Using integers
(define-symbolic v_1_1 v_1_2 v_1_3 v_1_4 v_1_5 v_1_6 v_1_7 v_1_8 v_1_9 integer?) ; row 1
(define-symbolic v_2_1 v_2_2 v_2_3 v_2_4 v_2_5 v_2_6 v_2_7 v_2_8 v_2_9 integer?)
(define-symbolic v_3_1 v_3_2 v_3_3 v_3_4 v_3_5 v_3_6 v_3_7 v_3_8 v_3_9 integer?)
(define-symbolic v_4_1 v_4_2 v_4_3 v_4_4 v_4_5 v_4_6 v_4_7 v_4_8 v_4_9 integer?)
(define-symbolic v_5_1 v_5_2 v_5_3 v_5_4 v_5_5 v_5_6 v_5_7 v_5_8 v_5_9 integer?)
(define-symbolic v_6_1 v_6_2 v_6_3 v_6_4 v_6_5 v_6_6 v_6_7 v_6_8 v_6_9 integer?)
(define-symbolic v_7_1 v_7_2 v_7_3 v_7_4 v_7_5 v_7_6 v_7_7 v_7_8 v_7_9 integer?)
(define-symbolic v_8_1 v_8_2 v_8_3 v_8_4 v_8_5 v_8_6 v_8_7 v_8_8 v_8_9 integer?)
(define-symbolic v_9_1 v_9_2 v_9_3 v_9_4 v_9_5 v_9_6 v_9_7 v_9_8 v_9_9 integer?)
  

;; Values are 1-9
(define (declare-values-1-to-9)
  (assert (and (> v_1_1 0) (< v_1_1 10))) ; row 1
  (assert (and (> v_1_2 0) (< v_1_2 10)))
  (assert (and (> v_1_3 0) (< v_1_3 10)))
  (assert (and (> v_1_4 0) (< v_1_4 10)))
  (assert (and (> v_1_5 0) (< v_1_5 10)))
  (assert (and (> v_1_6 0) (< v_1_6 10)))
  (assert (and (> v_1_7 0) (< v_1_7 10)))
  (assert (and (> v_1_8 0) (< v_1_8 10)))
  (assert (and (> v_1_9 0) (< v_1_9 10)))
  (assert (and (> v_2_1 0) (< v_2_1 10))) ; row 2
  (assert (and (> v_2_2 0) (< v_2_2 10)))
  (assert (and (> v_2_3 0) (< v_2_3 10)))
  (assert (and (> v_2_4 0) (< v_2_4 10)))
  (assert (and (> v_2_5 0) (< v_2_5 10)))
  (assert (and (> v_2_6 0) (< v_2_6 10)))
  (assert (and (> v_2_7 0) (< v_2_7 10)))
  (assert (and (> v_2_8 0) (< v_2_8 10)))
  (assert (and (> v_2_9 0) (< v_2_9 10)))
  (assert (and (> v_3_1 0) (< v_3_1 10))) ; row 3
  (assert (and (> v_3_2 0) (< v_3_2 10)))
  (assert (and (> v_3_3 0) (< v_3_3 10)))
  (assert (and (> v_3_4 0) (< v_3_4 10)))
  (assert (and (> v_3_5 0) (< v_3_5 10)))
  (assert (and (> v_3_6 0) (< v_3_6 10)))
  (assert (and (> v_3_7 0) (< v_3_7 10)))
  (assert (and (> v_3_8 0) (< v_3_8 10)))
  (assert (and (> v_3_9 0) (< v_3_9 10)))
  (assert (and (> v_4_1 0) (< v_4_1 10))) ; row 4
  (assert (and (> v_4_2 0) (< v_4_2 10)))
  (assert (and (> v_4_3 0) (< v_4_3 10)))
  (assert (and (> v_4_4 0) (< v_4_4 10)))
  (assert (and (> v_4_5 0) (< v_4_5 10)))
  (assert (and (> v_4_6 0) (< v_4_6 10)))
  (assert (and (> v_4_7 0) (< v_2_7 10)))
  (assert (and (> v_4_8 0) (< v_4_8 10)))
  (assert (and (> v_4_9 0) (< v_4_9 10)))
  (assert (and (> v_5_1 0) (< v_5_1 10))) ; row 5
  (assert (and (> v_5_2 0) (< v_5_2 10)))
  (assert (and (> v_5_3 0) (< v_5_3 10)))
  (assert (and (> v_5_4 0) (< v_5_4 10)))
  (assert (and (> v_5_5 0) (< v_5_5 10)))
  (assert (and (> v_5_6 0) (< v_5_6 10)))
  (assert (and (> v_5_7 0) (< v_5_7 10)))
  (assert (and (> v_5_8 0) (< v_5_8 10)))
  (assert (and (> v_5_9 0) (< v_5_9 10)))
  (assert (and (> v_6_1 0) (< v_6_1 10))) ; row 6
  (assert (and (> v_6_2 0) (< v_6_2 10)))
  (assert (and (> v_6_3 0) (< v_6_3 10)))
  (assert (and (> v_6_4 0) (< v_6_4 10)))
  (assert (and (> v_6_5 0) (< v_6_5 10)))
  (assert (and (> v_6_6 0) (< v_6_6 10)))
  (assert (and (> v_6_7 0) (< v_6_7 10)))
  (assert (and (> v_6_8 0) (< v_6_8 10)))
  (assert (and (> v_6_9 0) (< v_6_9 10)))
  (assert (and (> v_7_1 0) (< v_7_1 10))) ; row 7
  (assert (and (> v_7_2 0) (< v_7_2 10)))
  (assert (and (> v_7_3 0) (< v_7_3 10)))
  (assert (and (> v_7_4 0) (< v_7_4 10)))
  (assert (and (> v_7_5 0) (< v_7_5 10)))
  (assert (and (> v_7_6 0) (< v_7_6 10)))
  (assert (and (> v_7_7 0) (< v_7_7 10)))
  (assert (and (> v_7_8 0) (< v_7_8 10)))
  (assert (and (> v_7_9 0) (< v_7_9 10)))
  (assert (and (> v_8_1 0) (< v_8_1 10))) ; row 8
  (assert (and (> v_8_2 0) (< v_8_2 10)))
  (assert (and (> v_8_3 0) (< v_8_3 10)))
  (assert (and (> v_8_4 0) (< v_8_4 10)))
  (assert (and (> v_8_5 0) (< v_8_5 10)))
  (assert (and (> v_8_6 0) (< v_8_6 10)))
  (assert (and (> v_8_7 0) (< v_8_7 10)))
  (assert (and (> v_8_8 0) (< v_8_8 10)))
  (assert (and (> v_8_9 0) (< v_8_9 10)))
  (assert (and (> v_9_1 0) (< v_9_1 10))) ; row 9
  (assert (and (> v_9_2 0) (< v_9_2 10)))
  (assert (and (> v_9_3 0) (< v_9_3 10)))
  (assert (and (> v_9_4 0) (< v_9_4 10)))
  (assert (and (> v_9_5 0) (< v_9_5 10)))
  (assert (and (> v_9_6 0) (< v_9_6 10)))
  (assert (and (> v_9_7 0) (< v_9_7 10)))
  (assert (and (> v_9_8 0) (< v_9_8 10)))
  (assert (and (> v_9_9 0) (< v_9_9 10)))
  )

;; One of each digit in each row and column
;(define (one-in-each-row-and-column)
;  )
  
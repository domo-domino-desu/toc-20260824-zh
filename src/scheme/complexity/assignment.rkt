#lang racket
;; assignment.rkt
;;   Solve the assignment problem by brute force.
;; 2025-Feb-17 Jim Hefferon PD

(define cost-table
  #[#[13 4 7 6]
    #[1 11 5 4]
    #[6 7 2 8]
    #[1 3 5 9]])

(define (get-cost i j cost-table)
  (vector-ref (vector-ref cost-table i) j))

;; Find minimum cost of matching workers with tasks
;;   For every permutation of task indices, make a list of costs,
;;   then add, and then find the min.
(define (minimize-assignment cost-table)
  (apply min
         (for*/list ([task-perm (in-permutations '(0 1 2 3))])
           (apply + (map (lambda (i j) (get-cost i j cost-table))
                         '(0 1 2 3)
                         task-perm)))))


#lang racket
;;;; sat-solver.rkt

;; (require SAT)
(require "soduku-dimacs.rkt")

(define (solution-triples solution)
  (map varnum->triple (hash-keys solution)))

(define (show-board triples)
  (map (lambda (x)
         (set-board-entry! BOARD x))
       triples)
  BOARD)

(define (show-solution-triples list-of-triples)
  (define (compare-triples x y)
    (cond
      [(< (first x) (first y)) #t]
      [(> (first x) (first y)) #f]
      [(< (second x) (second y)) #t]
      [(> (second x) (second y)) #f]
      [(< (third x) (third y)) #t]
      [else #f]))
    
    (sort
     list-of-triples
     compare-triples))

;; read the output from MiniSat
(define (read-minisat-output)
  (define (get-two-lines input-port)
    (let ([head-line (read-line input-port)]
          [data-line (read-line input-port)])
      (list head-line data-line)))
  
  (call-with-input-file "test.out" get-two-lines))

(define (process-minisat-output pr)
  (let* ([data-line (second pr)]
         [number-list (map string->number (string-split data-line))]
         [triple-list (map varnum->triple number-list)]
         [filtered-triple-list (filter (lambda (x) (positive? (third x))) triple-list)])
    filtered-triple-list))

(define (show-solved-board)
  (show-board (cdr (show-solution-triples (process-minisat-output (read-minisat-output))))))

#lang racket
;; conway-test.rkt
(require rackunit
         "conway.rkt")
(require rackunit/text-ui) ; to run the test suites


;; ===== instruction tests
(define creation-tests
  (test-suite
   "Grid creation tests"
  
   (test-case
    "Grid creation simple"
    (let* ([g (grid-create 3 5)])
      ; (displayln g)
      (check-pred vector? g "grid is not a vector")
      (check-pred pair? (grid-size g) "grid-size is not a pair")
      (check-eq? (length (grid-size g)) 2 "grid-size is not a length-two list")
      (for* ([row (in-range 3)]
             [col (in-range 5)])
        (check-eq? (vector-ref (vector-ref g row) col) DEAD))  
      )) 
   (test-case
    "Grid getters and setters simple"
    (let* ([g (grid-create 3 5)])
      (for* ([row (in-range 3)]
             [col (in-range 5)])
        (check-eq? (grid-get g row col) DEAD) "Expect all elets of newly-created grid are DEAD")
      ; set something to non-DEAD
      (grid-set! g 1 3 ALIVE)
      ; (displayln g)
      ; (displayln (vector-ref (vector-ref g 1) 2))
      (check-eq? (grid-get g 1 3) ALIVE "Simple grid-get retrieval failed")
      )) 
   (test-case
    "Grid as string"
    (let ([g (grid-create 3 5)])
      (for* ([row (in-range 2)]
             [col (in-range 4)])
        ; (displayln (~a "row=" row " col=" col))
        (when (odd? (+ row col))
          (grid-set! g row col ALIVE)))
      ; Copy src to dest
      (check-pred string? (grid->string g) "grid->string failed to produce a string")
      (displayln (~a "grid as a string is " (grid->string g)))
      ))
   (test-case
    "Grid copy"
    (let ([g-src (grid-create 3 5)]
          [g-dest (grid-create 5 10)])
      (for* ([row (in-range 2)]
             [col (in-range 4)])
        ; (displayln (~a "row=" row " col=" col))
        (when (odd? (+ row col))
          (grid-set! g-src row col ALIVE)))
      ; Copy src to dest
      (grid-copy g-src g-dest (list 1 2))
      (displayln g-dest)
      ))
   )) ;; end suite and tests

(run-tests creation-tests)

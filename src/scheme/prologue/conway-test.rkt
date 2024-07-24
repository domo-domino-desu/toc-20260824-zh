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
      (displayln g)
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
        (check-eq? (grid-get g row col) DEAD) "Expect all eleets of newly-created grid are DEAD")
      ; set something to non-DEAD
      (grid-set! g 1 2 ALIVE)
      (displayln (vector-ref (vector-ref g 1) 2))
      (check-eq? (grid-get g 1 2) ALIVE "Simple grid-get retrieval failed")
      )) 
   )) ;; end suite and tests

(run-tests creation-tests)

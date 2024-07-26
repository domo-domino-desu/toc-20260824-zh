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
    (let* ([num-rows 3]
           [num-cols 5]
           [g (grid-create num-rows num-cols)])
      (for* ([row (in-range 3)]
             [col (in-range 5)])
        ; (displayln (~a "row=" row " col=" col))
        (when (odd? (+ row col))
          (grid-set! g row col ALIVE)))
      (check-pred string? (grid->string g) "grid->string failed to produce a string")
      (check-eqv? (string-length (grid->string g)) (+ (- num-rows 1) (* num-rows num-cols)) "grid->string length not right")
      ; (displayln (~a "grid is\n" g))
      ; (displayln (~a "string is \n" (grid->string g) "<---"))
      (check-true (string=? (grid->string g) ".*.*.\n*.*.*\n.*.*.") "grid->string didn't produce expected string")
      ))
   (test-case
    "Getting the values of the neighbors of a grid cell"
    (let ([g (grid-create 3 5)])
      (for* ([row (in-range 3)]
             [col (in-range 5)])
        ; (displayln (~a "row=" row " col=" col))
        (when (odd? (+ row col))
          (grid-set! g row col ALIVE)))
      ; (displayln (grid->string g))
      ; Test a cell not on the boundary
      (check-pred list? (grid-neighbor-vals-get g '(1 1)) "grid-neighbor-vals-get failed to return a list")
      ; (displayln (~a "list is \n" (grid-neighbor-vals-get g '(1 1))))
      (check-pred list? (grid-neighbor-vals-get g '(1 1)) "grid-neighbot-vals-get failed to return a list")
      (check-eq? (length (grid-neighbor-vals-get g '(1 1))) 8 "grid-neighbor-vals-get list is not length 8")
      (check-equal? (grid-neighbor-vals-get g '(1 1)) '(0 1 0 1 0 1 0 1) "grid-neighbor-vals-get unexpected returned listfor (1 1)")
      ; Test a cell on the boundary; (2 0) has two alive neighbors
      (check-pred list? (grid-neighbor-vals-get g '(2 0)) "grid-neighbor-vals-get failed to return a list")

      ;(displayln (~a "grid is \n" (grid->string g) "\n"))

      ;(displayln (~a "list is \n" (grid-neighbor-vals-get g '(2 0))))
      (check-pred list? (grid-neighbor-vals-get g '(2 0)) "grid-neighbot-vals-get failed to return a list")
      (check-eq? (length (grid-neighbor-vals-get g '(2 0))) 8 "grid-neighbor-vals-get list is not length 8 ")
      (check-equal? (grid-neighbor-vals-get g '(2 0)) '(0 1 0 1 0 0 0 0) "grid-neighbor-vals-get unexpected returned list")
      ))
;   (test-case
;    "Grid copy"
;    (let ([g-src (grid-create 3 5)]
;          [g-dest (grid-create 5 10)])
;      (for* ([row (in-range 2)]
;             [col (in-range 4)])
;        ; (displayln (~a "row=" row " col=" col))
;        (when (odd? (+ row col))
;          (grid-set! g-src row col ALIVE)))
;      ; Copy src to dest
;      (grid-copy g-src g-dest (list 1 2))
;      ; (displayln g-dest)
;      ))
   )) ;; end suite and tests

(run-tests creation-tests)

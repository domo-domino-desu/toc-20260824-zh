#lang racket
(require rackunit
         "loop.rkt")
(require rackunit/text-ui) ; to run the test suites

;; Primitive recursive funcions, initial functions tests
(define pr-initial-functions-tests

  (test-suite
   "initial functions"
 
   (test-case
    "zero"
    (check-equal? 0 (Z 0))
    (check-equal? 0 (Z 1))
    )

   (test-case
    "successor"
    (check-equal? 1 (successor 0))
    (check-equal? 2 (successor 1))
    )

   (test-case
    "projection"
    (check-equal? 0 (i1_1 0))
    (check-equal? 1 (i1_1 1))
    (check-equal? 0 (i2_1 0 1))
    (check-equal? 1 (i2_2 0 1))
    (check-equal? 0 (i3_1 0 1 2))
    (check-equal? 1 (i3_2 0 1 2))
    (check-equal? 2 (i3_3 0 1 2))
    )

   (test-case
    "predecessor"
    (check-equal? 0 (pred 1))
    (check-equal? 1 (pred 2))
    (check-equal? 0 (pred 0))
    )
   
;   (test-case
;    "schema of primitive recursion"
;    )

   )
  )
  
;; Primitive recursive functions, derived functions tests
(define pr-derived-functions-tests

  (test-suite
   "primitive recursive functions derived from intial ones"
 
   (test-case
    "plus"
    (check-equal? 0 (plus 0 0))
    (check-equal? 5 (plus 5 0))
    (check-equal? 5 (plus 0 5))
    (check-equal? 5 (plus 2 3))
    (check-equal? 5 (plus 4 1))
    )

   (test-case
    "product"
    (check-equal? 0 (product 0 0))
    (check-equal? 0 (product 0 5))
    (check-equal? 0 (product 1 0))
    (check-equal? 6 (product 2 3))
    )

   (test-case
    "power"
    (check-equal? 1 (power 2 0))
    (check-equal? 1 (power 0 0))
    (check-equal? 2 (power 2 1))
    (check-equal? 25 (power 5 2))
    )

   (test-case
    "propersub"
    (check-equal? 2 (propersub 5 3))
    (check-equal? 1 (propersub 4 3))
    (check-equal? 0 (propersub 3 3))
    (check-equal? 0 (propersub 3 5))
    (check-equal? 0 (propersub 0 0))
    )
   )
  )

;; ==============================
;; Run the tests
;; Uncomment the tests you are working on
(run-tests pr-initial-functions-tests)
(run-tests pr-derived-functions-tests)


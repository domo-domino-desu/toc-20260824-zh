#lang racket
(require rackunit
         rackunit/text-ui
         "brute-force.rkt")

(define next-pair-tests
  (test-suite
   "Tests for next-pair function"
 
   (test-case
    "List some cases"
    (check-equal? (next-pair '(0 0)) '(0 1))
    (check-equal? (next-pair '(0 1)) '(1 0))
    (check-equal? (next-pair '(1 0)) '(0 2))
    (check-equal? (next-pair '(0 2)) '(1 1))
    )
   
   )
  )


(define brute-force-pairing-tests
  (test-suite
   "Tests for brute-force-pairing function"
 
   (test-case
    "List some cases"
    (check-equal? (brute-force-pairing 0) '(0 0))
    (check-equal? (brute-force-pairing 1) '(0 1))
    (check-equal? (brute-force-pairing 2) '(1 0))
    (check-equal? (brute-force-pairing 3) '(0 2))
    )
   
   )
  )
  
;; ===== Drive the tests ==============

(run-tests next-pair-tests)
(run-tests brute-force-pairing-tests)
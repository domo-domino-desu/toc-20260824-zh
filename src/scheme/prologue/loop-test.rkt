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

;; ========= Registers ==============
(define register-tests

  (test-suite
   "registers, with getters and setters"
 
   (test-case
    "make-reg-name"
    (check-equal? 'r5 (make-reg-name 5))
    (check-true (symbol? (make-reg-name 5)))
    )

    (test-case
    "clear-regs!"
    (hash-set! REGISTERS (make-reg-name 1) 10)
    (clear-regs!)
    (check-false (hash-ref REGISTERS (make-reg-name 1) #f))
    (check-equal? 0 (get-reg-value (make-reg-name 0)))
    )
    
    (test-case
    "set-reg-value!"
    (clear-regs!)
    (set-reg-value! (make-reg-name 1) 10)
    (check-equal? 10 (hash-ref REGISTERS (make-reg-name 1) #f))
    )

    (test-case
    "get-reg"
    (clear-regs!)
    (let ([reg-name-one (make-reg-name 1)])
      (check-equal? (cons reg-name-one 0)
                    (get-reg reg-name-one) "Check it returns a pair")
      (check-equal? 0 (hash-ref REGISTERS reg-name-one #f) "Check the new register created")
      )
    (clear-regs!)
    (let ([reg-name-one (make-reg-name 1)])
      (set-reg-value! reg-name-one 5)
      (check-equal? (cons reg-name-one 5)
                    (get-reg reg-name-one) "Check it returns a pair, with the right cdr")
      )
    )

    (test-case
     "get-reg-value"
     (let ([reg-name-one (make-reg-name 1)])
       (hash-set! REGISTERS reg-name-one 10)
       (check-equal? 10 (get-reg-value reg-name-one))
       )
     (let ([reg-name-two (make-reg-name 2)])
       (check-equal? 0 (get-reg-value reg-name-two) "No such register; return zero")
       (show-regs)
       (check-equal? 0 (hash-ref REGISTERS reg-name-two #f) "Check the get-reg-value made the reg")
       )
     )
    )
  )

;; ========= Registers ==============
(define register-operations-tests

  (test-suite
   "register operations"
   
   (test-case
    "increment-reg!"
    (clear-regs!)
    (let ([reg-zero (make-reg-name 0)])
      (increment-reg! reg-zero)
      (check-equal? 1 (get-reg-value reg-zero))
      )
    )
   
   (test-case
    "copy-reg!"
    (clear-regs!)
    (let ([reg-zero (make-reg-name 0)]
          [reg-one (make-reg-name 1)])
      (increment-reg! reg-zero)
      (set-reg-value! reg-one 5)
      (copy-reg! reg-zero reg-one)  ; put value from 'r0 into 'r1
      (check-equal? 1 (get-reg-value reg-one))
      (check-equal? 1 (get-reg-value reg-zero))
      )
    ;; Now put value in a reg that does not yet exist
    (clear-regs!)
    (let ([reg-zero (make-reg-name 0)]
          [reg-one (make-reg-name 1)])
      (set-reg-value! reg-zero 5)
      (copy-reg! reg-zero reg-one)  ; put value from 'r0 into 'r1 
      (check-equal? 5 (get-reg-value reg-zero))
      (check-equal? 5 (get-reg-value reg-one))
      )
    ;; Now copy from a reg that does not yet exist
    (clear-regs!)
    (let ([reg-one (make-reg-name 1)]
          [reg-two (make-reg-name 2)])
      (copy-reg! reg-one reg-two)  ; put value from 'r1 into 'r2 
      (check-equal? 0 (get-reg-value reg-one))
      (check-equal? 0 (get-reg-value reg-two))
      )
    )

   )
  )


;; Run the tests
;; Uncomment the tests you are working on
; (run-tests pr-initial-functions-tests)
; (run-tests pr-derived-functions-tests)
; (run-tests register-tests)
(run-tests register-operations-tests)
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


;; ========= Interpret operations ==============
(define interpret-operations-tests

  (test-suite
   "interpret operations"
   
   (test-case
    "intr-zero"
    (clear-regs!)
    (letrec ([reg-five (make-reg-name 5)]
             [pars (cons reg-five 42)])
      (set-reg-value! reg-five 10)
      (intr-zero pars)
      (check-equal? 0 (get-reg-value reg-five))
      )
    ; Try on a register that doesn't yet exist
    (clear-regs!)
    (letrec ([reg-five (make-reg-name 5)]
             [pars (cons reg-five 42)])
      (intr-zero pars)
      (check-equal? 0 (get-reg-value reg-five))
      )
     )
   
   (test-case
    "intr-incr"
    (clear-regs!)
    (letrec ([reg-five (make-reg-name 5)]
             [pars (cons reg-five 42)])
      (set-reg-value! reg-five 10)
      (intr-incr pars)
      (check-equal? 11 (get-reg-value reg-five))
      )
    ; Try on a register that doesn't yet exist?
    (clear-regs!)
    (letrec ([reg-five (make-reg-name 5)]
             [pars (cons reg-five 42)])
      (intr-incr pars)  ; allocate it, then increment it
      (check-equal? 1 (get-reg-value reg-five))
      )
    )
   
   (test-case
    "intr-copy"
    (clear-regs!)
    (letrec ([reg-five (make-reg-name 5)]
             [reg-six (make-reg-name 6)]
             [pars (cons reg-five (cons reg-six 42))])
      (set-reg-value! reg-six 10)
      (intr-copy pars)
      (check-equal? 10 (get-reg-value reg-five))
      (check-equal? 10 (get-reg-value reg-six))
      )
    ; Try on a register that doesn't yet exist?
    (clear-regs!)
    (letrec ([reg-five (make-reg-name 5)]
             [reg-six (make-reg-name 6)]
             [pars (cons reg-five (cons reg-six 42))])
      ; (set-reg-value! reg-six 10)
      (intr-copy pars)
      (check-equal? 0 (get-reg-value reg-five))
      (check-equal? 0 (get-reg-value reg-six))
      )
 
    )

   (test-case
    "intr-loop"
    (clear-regs!)
    (letrec ([reg-five (make-reg-name 5)]
             [reg-six (make-reg-name 6)]
             [lp (list (list 'loop reg-five) (list (list 'incr reg-six) (list 'incr reg-six)))])
      ;(write lp)(newline)
      (set-reg-value! reg-five 2)
      (set-reg-value! reg-six 10)
      (intr-body lp)
      (check-equal? 2 (get-reg-value reg-five))
      (check-equal? 14 (get-reg-value reg-six))
      )
    )

   )
  )


;; ============= ALGOL to scm =========
(define algol-to-scm-tests
  ; (printf "testing")

  (test-suite
   "ALGOL to Scheme"
   
;   (test-case
;    "simplest"
;    (clear-regs!) 
;    (let ([pgm "r0 = r0 + 1"])
;      (check-equal? (loop-without-parens pgm '(0)) 1)
;      )
;    )
   
;   (test-case
;    "using loops"
;    (clear-regs!)
;    (let ([pgm "r1 = r1 + 1\nloop r1\n  r0 = r0 + 1\nend"])
;      (check-equal? (loop-without-parens pgm '(1 2)) 4)
;      )
;    )
   ; Nested loop
   (clear-regs!)
   (let ([pgm "loop r1\nloop r2\n  r0 = r0 + 1\nend\nend"])
     (check-equal? (loop-without-parens pgm '(3 4 5)) 23)
     )
   (clear-regs!)
   (let ([pgm "r1 = r1 + 1\nr1 = r1 + 1\nr2 = r2 + 2\nr2 = r2 + 1\nloop r1\nloop r2\n  r0 = r0 + 1\nend\nend"])
     (check-equal? (loop-without-parens pgm '(0 0 0)) 4)
     )
   )
  )

;; Run the tests
;; Uncomment the tests you are working on
; (run-tests pr-initial-functions-tests)
; (run-tests pr-derived-functions-tests)
; (run-tests register-tests)
; (run-tests register-operations-tests)
; (run-tests interpret-operations-tests)
(run-tests algol-to-scm-tests)
#lang racket
(require rackunit
         "loop.rkt")
(require rackunit/text-ui) ; to run the test suites


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

(define LOOP-MACHINE-DIR "machines/")  ; subdirectory holding the .loop files

;; string -> string
;; From the .loop filename, return the string of that file
;;   filename  string  Name of .loop file, without directory and including the .loop
(define (read-loop-pgm filename)
  (port->string (open-input-file (string-append LOOP-MACHINE-DIR filename)) #:close? #t))

;; ============= ALGOL to scm =========
(define algol-to-scm-tests

  (test-suite
   "ALGOL to Scheme"
   
   (test-case
    "simplest"
    (clear-regs!) 
    (let ([pgm "r0 = r0 + 1"])
      (check-equal? (loop-without-parens pgm '(0)) 1)
      )
    )
   
   (test-case
    "using loops"
    (clear-regs!)
    (let ([pgm "r1 = r1 + 1\nloop r1\n  r0 = r0 + 1\nend"])
      (check-equal? (loop-without-parens pgm '(1 2)) 4)
      )
    ; Nested loops
    (clear-regs!)
    (let ([pgm "loop r1\nloop r2\n  r0 = r0 + 1\nend\nend"])
      (check-equal? (loop-without-parens pgm '(3 4 5)) 23)
      )
    (clear-regs!)
    (let ([pgm "r1 = r1 + 1\nr1 = r1 + 1\nr2 = r2 + 1\nr2 = r2 + 1\nloop r1\nloop r2\n  r0 = r0 + 1\nend\nend"])
      (check-equal? (loop-without-parens pgm '(0 0 0)) 4)
     )
   )

   (test-case
    "regexp's"
    ; empty line
    (check-true (regexp-match? EMPTY-LINE-REGEXP "  "))
    (check-true (regexp-match? EMPTY-LINE-REGEXP ""))
    (check-false (regexp-match? EMPTY-LINE-REGEXP " k "))
    ; zero instruction
    (check-true (regexp-match? ZERO-REGEXP "r0 = 0"))
    (check-true (regexp-match? ZERO-REGEXP "r5 = 0"))
    (check-true (regexp-match? ZERO-REGEXP "  r0=0  "))
    (check-false (regexp-match? ZERO-REGEXP "r0 = 5"))
    ; increment instruction
    (check-true (regexp-match? INCREMENT-REGEXP "r0 = r0 + 1"))
    (check-true (regexp-match? INCREMENT-REGEXP "r1=r1+1"))
    (check-true (regexp-match? INCREMENT-REGEXP "  r0 = r0 + 1  "))
    (check-false (regexp-match? INCREMENT-REGEXP "r0 = r1 + 1"))
    ; loop instruction
    (check-true (regexp-match? LOOP-REGEXP "loop r0"))
    (check-true (regexp-match? LOOP-REGEXP "loop r5"))
    (check-true (regexp-match? LOOP-REGEXP "  loop   r0  "))
    (check-false (regexp-match? LOOP-REGEXP "loop"))
    ; end instruction
    (check-true (regexp-match? END-REGEXP "end"))
    (check-true (regexp-match? END-REGEXP "  end   "))
    (check-false (regexp-match? END-REGEXP "r0 end"))
    ; copy instruction
    (check-true (regexp-match? COPY-REGEXP "r1 = r0"))
    (check-true (regexp-match? COPY-REGEXP "r1=r0"))
    (check-true (regexp-match? COPY-REGEXP "  r1 =  r0   "))
    (check-true (regexp-match? COPY-REGEXP "r0 = r0"))  ;; noop
    ;; Checking the selection of parenthesized submatches
    (check-equal? (caar (regexp-match* INCREMENT-REGEXP "r0 = r0 + 1" #:match-select cdr))
                  "r0")
    (check-equal? (caar (regexp-match* COPY-REGEXP "r0 = r1" #:match-select cdr))
                  "r0")
    (check-equal? (cadar (regexp-match* COPY-REGEXP "r0 = r1" #:match-select cdr))
                  "r1")
    )

   (test-case
    "comments"
    (let ([pgm "r0 = r0 + 1 # test comment"])
      (let ([data '()])
        (check-equal? (loop-without-parens pgm data) 1)))
    (let ([pgm "# Test comment header\nr0 = r0 + 1"])
      (let ([data '()])
        (check-equal? (loop-without-parens pgm data) 1)))
    (let ([pgm "r0 = r0 + 1\n# Test comment between commands\nr0 = r0 + 1"])
      (let ([data '()])
        (check-equal? (loop-without-parens pgm data) 2)))
      ) ; close test-case
   
   (test-case
    "book examples"
    ; First example
    (clear-regs!)
    (let ([pgm "r1 = r1 + 1\nr1 = r1 + 1\nloop r1\nr0 = r0 + 1\nr0 = r0 + 1\nend"])
      ; (loop-without-parens pgm '(0 0))
      (check-equal? (loop-without-parens pgm '(0 0)) 4))
    ; Addition of r0 and r1
    (let ([pgm "loop r1\nr0 = r0 + 1\nend"])
      (let ([data '(3 5)])
        (check-equal? (loop-without-parens pgm data) 8))
      (let ([data '(0 0)])
        (check-equal? (loop-without-parens pgm data) 0))
      (let ([data '(10 0)])
        (check-equal? (loop-without-parens pgm data) 10))
      )
    ; Multiplication of r0 and r1
    (let ([pgm "loop r1\nloop r0\nr2 = r2 + 1\nend\nend\nr0 = r2"])
      (let ([data '(2 3)])
        (check-equal? (loop-without-parens pgm data) 6))
      (let ([data '(5 4)])
        (check-equal? (loop-without-parens pgm data) 20))
      (let ([data '(0 0)])
        (check-equal? (loop-without-parens pgm data) 0))
      (let ([data '(10 0)])
        (check-equal? (loop-without-parens pgm data) 0))
      )
    ; Predecessor of r0 
    (let ([pgm "loop r0\nr2 = r1\nr1 = r1 + 1\nend\nr0 = r2"])
      (let ([data '(2)])
        (check-equal? (loop-without-parens pgm data) 1))
      (let ([data '(5)])
        (check-equal? (loop-without-parens pgm data) 4))
      (let ([data '(0)])
        (check-equal? (loop-without-parens pgm data) 0))
      )
    ; Proper subtraction
    (let ([pgm "loop r1\nr3 = 0\nloop r0\nr2 = r3\nr3 = r3 + 1\nend\nr0 = r2\nend"])
      (let ([data '(3 1)])
        (check-equal? (loop-without-parens pgm data) 2))
      (let ([data '(5 2)])
        (check-equal? (loop-without-parens pgm data) 3))
      (let ([data '(3 3)])
        (check-equal? (loop-without-parens pgm data) 0))
      (let ([data '(1 3)])
        (check-equal? (loop-without-parens pgm data) 0))
      )
    ) ;; close test-case  
   ) ;; close suite
  ) ;; close fcn

;; Run the tests
;; Uncomment the tests you are working on
; (run-tests pr-initial-functions-tests)
; (run-tests pr-derived-functions-tests)
; (run-tests register-tests)
; (run-tests register-operations-tests)
; (run-tests interpret-operations-tests)
(run-tests algol-to-scm-tests)
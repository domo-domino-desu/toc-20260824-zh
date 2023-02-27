#lang racket
(require rackunit
         "pushdown-machine.rkt")
(require rackunit/text-ui) ; to run the test suites




;; ===== tape-making tests
(define tape-making-tests
  (test-suite
   "make tape"
  
   (test-case
    "Test making the tape"
    (let ([tape (make-tape A B)])
      (check = 3 (length tape))
      (check equal? A (first tape))
      (check equal? B (second tape))
      (check equal? INPUTEND (third tape))))
   (test-case
    "Test making the empty tape"
    (let ([tape (make-tape)])
      (check = 1 (length tape))
      (check equal? INPUTEND (first tape))))
   (test-case
    "Test tape operations"
    (let ([tape (make-tape A B)]
          [empty-tape (make-tape)])
      (check equal? A  (tape-char tape))
      (check equal? INPUTEND (tape-char empty-tape))
      (check equal? ERROR (tape-char (list )))
      (check equal? B (tape-char (tape-shift tape)))
      ))
   )) ;; end tape-making suite and tests


;; ===== Stack making
(define stack-making-tests
  (test-suite
   "stack making tests"

   (test-case
    "Test making the stack"
    (let ([stack (make-stack G0 G1)])
      (check = 3 (length stack))
      (check equal? G0 (first stack))
      (check equal? G1 (second stack))
      (check equal? BOT (third stack))))
   (test-case
    "Test making the empty stack"
    (let ([stack (make-stack)])
      (check = 1 (length stack))
      (check equal? BOT (first stack))))

   ; Stack operations
   (test-case
    "Test stack push and pop operations"
    (let ([st (make-stack G0 G1 G2)])
      (check = (+ 1 (length st)) (length (stack-push #\w st)))
      (check = (- (length st) 1) (length (stack-pop st)))
      (check equal? (cdr st) (stack-pop st))
      (check equal? G0 (stack-top st))
      (check equal? st (stack-push G0 (stack-pop st)))
      (check equal? st (stack-pop (stack-push G3 st)))
      (check equal? (make-stack G3 G2 G0 G1 G2) (stack-push-list (list G3 G2) st))
      ))
   (test-case
    "Test stack-bot? operation"
    (let ([st0 (make-stack G0 G1 G2)]
          [st1 (make-stack)])
      (check-false (stack-bot? st0))
      (check-true (stack-bot? st1))
      ))
   )) ;; end stack-making suite and tests


;; ===== Configs
(define config-tests
  (test-suite
   "configurations"

   (test-case
    "Test configuration getters and setters for minimal functionality"
    (let ([config (make-config 1 (make-tape A B) (make-stack G0 G1))])
      (check = 1 (get-current-state config))
      (check equal? A (get-current-symbol config))
      (check equal? (make-stack G0 G1) (get-stack-list config))
      (check equal? G0 (get-stack-top config))
      (check equal? (make-tape A B) (get-tape-list config))
      (check equal? A (get-current-symbol config))
      ))
   
   (test-case
    "Test configuration getters and setters for trivial list and stack"
    (let ([config (make-config 0 (make-tape) (make-stack))])
      (check = 0 (get-current-state config))
      (check equal? INPUTEND (get-current-symbol config))
      (check equal? BOT (get-stack-top config))
      ))
   
   (test-case
    "Test string representation of the configuration"
    (let ([config (make-config 0 (make-tape) (make-stack))])
      (check-true (string? (configuration->string config)))
      ))
   )) ;; end configuration suite and tests


;; ===== Make a machine
(define machine-making-tests
  (test-suite
   "test making machines"

   (test-case
    "Test making a pushdown machine instruction, minimal functionality"
    (check = 5 (length (make-instruction 0 A G0 1 (list G1 G2))))
    )
   
   (test-case
    "Test making a pushdown machine instruction, getters and setters"
    (let ([inst (make-instruction 0 A G0 1 (list G1 G2))])
      (check = 0 (get-present-state inst))
      (check equal? A (get-present-tape-char inst))
      (check equal? G0 (get-present-stack-char inst))
      (check = 1 (get-next-state inst))
      (check equal? (list G1 G2) (get-push-stack-list inst))
      (check-pred string? (instruction->string inst))
      (printf "~s\n" (instruction->string inst))))
   
   (test-case
    "Test instruction->string"
    (let ([inst (make-instruction 0 A G0 1 (list G1 G2))])
      (check-pred string? (instruction->string inst)))
    (let ([inst (make-instruction 0 A G0 1 (list G1))])
      (check-pred string? (instruction->string inst)))
    (let ([inst (make-instruction 0 A G0 1 (list))])
      (check-pred string? (instruction->string inst)))
    )

   (test-case
    "Test pdm->string"
    ; (printf "(pdm->string pdm1)=~s\n" (pdm->string pdm1))
    (check-pred string? (pdm->string pdm0))
    (check-pred string? (pdm->string pdm1))
    )

   ; Pushdown machines
   (test-case
    "Make a pushdown machine"
    (let ([pdm (pdm-create)]
          [instr (make-instruction 0 A G0 1 (list G1 G2))])
      (check-true (pushdownmachine? pdm))
;      (printf "created: pdm=~s\n" pdm)
;      (pdm-add-instruction pdm instr)
;      (printf "  instruction added: pdm=~s\n" pdm)
;      (pdm-add-accepting-state pdm 3)
;      (printf "  accepting state added: pdm=~s\n" pdm)    
      )
    )
   )) ;; end machine making suite and tests

;; ===== Machines to use for tests
; a simple pushdown machine
(define pdm0
  (let ([pdm (pdm-create)])
    (pdm-add-instruction pdm (make-instruction 0 A G0 1 (list G1 G2)))
    (pdm-add-instruction pdm (make-instruction 0 B G1 1 (list G2)))
    pdm))
;
;;; a balanced parens pushdown machine
(define pdm1
  (let ([pdm (pdm-create)])
    (pdm-add-instruction pdm (make-instruction 0 "[" BOT 0 (list G0 BOT)))
    (pdm-add-instruction pdm (make-instruction 0 "[" G0  0 (list G0 G0)))
    (pdm-add-instruction pdm (make-instruction 0 "]" G0  0 (list)))
    (pdm-add-instruction pdm (make-instruction 0 "]" BOT 2 (list)))
    (pdm-add-instruction pdm (make-instruction 0 INPUTEND BOT 1 (list)))
    pdm)
  )


;; ===== Delta
(define delta-tests
  (test-suite
   "test delta"

   (test-case
    "Test Delta, minimal functionality"
    (let* ([output (delta pdm0 0 A G0)]
           [next-state (first output)]
           [stack-char-list (second output)])
      (check = 1 next-state "Next state for pdm0 should be 1")
      (check equal? (list G1 G2) stack-char-list "For pdm0 stack-char-list should be (g1 g2)")
      ))
   
;   (test-case
;    "Test Delta, second instruction"
;    (let* ([output (delta pdm0 0 B G1)]
;           [next-state (first output)]
;           [stack-char-list (second output)])
;      (check = 1 next-state "Next state for pdm0 second instruction should be 1")
;      (check equal? (list G2) stack-char-list "For pdm0 second instruction stack-char-list should be (x y)")
;      ))
;   
;   (test-case
;    "Test Delta, missing instruction"
;    (let ([output (delta pdm0 10 B G3)])
;      (check equal? ERROR output "For pdm0 missing instruction should raise an error")
;      ))
   )) ;; end delta suite and tests


;; ===== Step
(define step-tests
  (test-suite
   "test step"

   (test-case
    "Test step, minimal functionality"
    (let* ([config (make-config 0 (make-tape "[" "]") (make-stack))]
           [next-config (step pdm1 config)])
      ; (printf "configuration: ~a\n" (configuration->string next-config))
      (check equal? (make-config 0 (make-tape "]") (make-stack G0)) next-config)))
   
   (test-case
    "Test step, first step of paren matching machine"
    (let* ([config (make-config 0 (make-tape "[" "[" "]" "]") (make-stack))])
      (check equal?
             (make-config 0 (make-tape "[" "]" "]") (make-stack G0))
             (step pdm1 config))
      ))

   (test-case
    "Test step, empty tape"
    (let* ([config (make-config 0 (tape-shift (make-tape)) (make-stack))])
      ; (printf "configuration: ~a\n" (configuration->string config))
      (check equal? HALT (step pdm0 config))))
   )) ;; end step suite and tests


;; ===== yield-star
(define yield-star-tests
  (test-suite
   "test yield-star"

   (test-case
    "Test yield-star, minimal functionality"
    (printf "===Doing yield-star===\n")
    (let ([tau "[[]]"])
      (yield-star pdm1 tau)))
   
   (test-case
    "Test show-yield-star"
    (let ([tau "[[]]"])
      (show-yield-star pdm1 tau)
      ))
   )) ;; end yield-star suite and tests

;; ===== parse file
;; string -> string
;; From the .loop filename, return the string of that file
;;   filename  string  Name of .loop file, without directory and including the .loop
(define MACHINE-DIR "machines/")  ; subdirectory holding the .pdm files

;; string -> string
;; Get contents of file as one long string
(define (read-pgm-file filename)
  (port->string (open-input-file (string-append MACHINE-DIR filename)) #:close? #t))

(define parse-file-tests
  (test-suite
   "test parsing a file"

   (test-case
    "Test regexp's"
    (regexp-match? EMPTY-LINE-REGEXP "# test comment line")
    (regexp-match? EMPTY-LINE-REGEXP "")
    (regexp-match? EMPTY-LINE-REGEXP "   ")
    (let ([line "0 [ G0 1 (G0 G1)"])
      (check-true (regexp-match? LINE-REGEXP line)))
    (let ([line "0 B  G0 (G0 G1)"])
      (check-true (regexp-match? LINE-REGEXP line)))
    (let ([line "0 [ ] 1 (G0 G1) # test of comment"])
      (check-true (regexp-match? LINE-REGEXP line)))
    (let ([line "0 [ ] 1 (G0) # length one stack push"])
      (check-true (regexp-match? LINE-REGEXP line)))
    (let ([line "0 [ ] 1 () # length zero stack push"])
      (check-true (regexp-match? LINE-REGEXP line)))
    )

   (test-case
    "Test parse-one-line"
    (let* ([line "0 [ G0 1 (G0 G1)"]
           [inst-and-states (parse-one-line line)]
           [inst (first inst-and-states)])
      (check-equal? (get-present-state inst) 0)
      (check-equal? (get-present-tape-char inst) "[")
      (check-equal? (get-present-stack-char inst) "G0")
      (check-equal? (get-next-state inst) 1)
      (check-equal? (get-push-stack-list inst) '("G0" "G1"))
      )
    (let* ([line "0 [ G0 1 (G0 G1) # aba"]  ; with comment
           [inst-and-states (parse-one-line line)]
           [inst (first inst-and-states)])
      (check-equal? (get-present-state inst) 0)
      (check-equal? (get-present-tape-char inst) "[")
      (check-equal? (get-present-stack-char inst) "G0")
      (check-equal? (get-next-state inst) 1)
      (check-equal? (get-push-stack-list inst) '("G0" "G1"))
      )
    (let* ([line "0 [ G0 1 (G0)"]  ; one thing in the list
           [inst-and-states (parse-one-line line)]
           [inst (first inst-and-states)])
      (check-equal? (get-present-state inst) 0)
      (check-equal? (get-present-tape-char inst) "[")
      (check-equal? (get-present-stack-char inst) "G0")
      (check-equal? (get-next-state inst) 1)
      (check-equal? (get-push-stack-list inst) '("G0"))
      )
    (let* ([line "0 [ G0 1 ()"]   ; nothing in the list
           [inst-and-states (parse-one-line line)]
           [inst (first inst-and-states)])
      (check-equal? (get-present-state inst) 0)
      (check-equal? (get-present-tape-char inst) "[")
      (check-equal? (get-present-stack-char inst) "G0")
      (check-equal? (get-next-state inst) 1)
      (check-equal? (get-push-stack-list inst) '())
      )
    )

;   (test-case
;    "Test parse"
;    (printf "pgm-file=~s\n" (read-pgm-file "balanced-parens.pdm"))
;    (printf "  (string-split pgm-file=~s\n" (string-split (read-pgm-file "balanced-parens.pdm") "\n"))
;    (let ([file-contents '("# balanced-parens.pdm  Pushdown machine to accept balanced parens"
;                           "0 [ BOT 0 (G0 BOT)"
;                           "0 [ G0  0 (G0 G0)"
;                           "0 ] G0  0 ()"
;                           "0 ] BOT 2 ()"
;                           "0 INPUTEND BOT 1 ()")])
;      (printf "  parse returns ~s\n" (parse file-contents)))
;;    (let* ([file-contents (string-split (read-pgm-file "balanced-parens.pdm") "\n")]
;;           [pdm (parse file-contents)])
;;      ; (printf "~s\n" file-contents)
;;      (check-equal? (string-length pdm) 5))
;    )
   
   
   )) ;; end parse file suite and tests


;; ===== Run the tests; comment out ones not being worked-on
;(run-tests tape-making-tests)
;(run-tests stack-making-tests)
;(run-tests config-tests)
;(run-tests machine-making-tests)
;(run-tests delta-tests)
;(run-tests step-tests)
; (run-tests yield-star-tests)
(run-tests parse-file-tests)
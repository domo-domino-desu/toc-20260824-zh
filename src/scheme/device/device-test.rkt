#lang racket
(require rackunit
         "device.rkt")
(require rackunit/text-ui) ; to run the test suites

;; device-test.rkt
;;
;; Unit tests for device.rkt, from Jim Hefferon's _Theory of Computation_
;; License: GPL 3.0


; return a delta-map
; useful for test setups
(define (trial-delta-map)
  (let ([delta-map (make-delta-map)])
    (set-delta-map! delta-map '(0 "a") '("b" 0))
    (set-delta-map! delta-map '(0 "b") '("b" 1))
    (set-delta-map! delta-map '(1 "a") '("b" 1)) ;; one input has two outputs
    (set-delta-map! delta-map '(1 "a") '("b" 0))
    (set-delta-map! delta-map '(1 "b") '("a" 0))
    delta-map))


;; ===== delta tests
(define delta-tests
  (test-suite
   "initialize and manipulate delta-map and delta"
  
   (test-case
    "Test making delta-map"
    (let ([delta-map (make-delta-map)]
          [input (list 0 "a")]
          [other-input (list 3 "b")]
          [output (list 1)]
          [other-output (list 2)])
      (set-delta-map! delta-map input output)
      (check-true (set-member? (delta delta-map input) output))
      (set-delta-map! delta-map input other-output)
      (set-delta-map! delta-map other-input output)
      (check-true (set-member? (delta delta-map input) output))
      (check-true (set-member? (delta delta-map input) other-output))
      (check-true (set-member? (delta delta-map other-input) output))
      )
    );; end test-case
  
   (test-case
    "Test delta function"
    (let ([delta-map (make-delta-map)]
          [input (list 0 "a")]
          [other-input (list 3 "b")]
          [output (list 1)])
      (set-delta-map! delta-map input output)
      (check-true (set-member? (delta delta-map input) output))
      (check-equal? (delta delta-map other-input) DELTA-NOKEY)
      )
    );; end test-case

   (test-case
    "Another test delta function"
    (let ([delta-map (trial-delta-map)])
      (check-true (set-member? (delta delta-map '(0 "a")) '("b" 0)))
      (check-equal? (delta delta-map '(3 "a")) DELTA-NOKEY)
      )
    );; end test-case
  
   (test-case
    "Test delta-map->string function"
    (let ([delta-map (make-delta-map)]
          [input (list 0 "a")]
          [other-input (list 3 "b")]
          [output (list 1 "z")]
          [other-output (list 1 "x")]
          )
      (set-delta-map! delta-map input output)
      (set-delta-map! delta-map input other-output)
      (set-delta-map! delta-map other-input other-output)
      ; (printf "DELTA: ~s\n" (delta-map->string delta-map))
      (check-true (string? (delta-map->string delta-map)))
      )
    );; end test-case
  
   (test-case
    "Test get-states function"
    (let ([delta-map (make-delta-map)]
          [input (list 0 "a")]
          [other-input (list 3 "b")]
          [output (list "z" 1)]
          [other-output (list "y" 1)])
      (set-delta-map! delta-map input output)
      (set-delta-map! delta-map other-input other-output)
      ; (printf "get-states: ~a\n" (get-states delta-map))
      (check-true (list? (get-states delta-map)))
      (check-true (list? (member 0 (get-states delta-map))))
      (check-true (list? (member 3 (get-states delta-map))))
      )
    (let ([delta-map (make-delta-map)])
      ; (printf "get-states: ~s\n" (get-states delta-map))
      (check-true (null? (get-states delta-map)))
      )
    );; end test-case
  
   (test-case
    "Test make-epsilon-closure hash"
    (let ([delta-map (make-delta-map)])
      (set-delta-map! delta-map (list 0 "a") (list 1 "z"))
      (set-delta-map! delta-map (list 0 "EPS") (list 1 "y"))
      (set-delta-map! delta-map (list 1 "b") (list 2 "x"))
      (set-delta-map! delta-map (list 2 "a") (list 0 "w"))
      ; (printf "epsilon-closure: ~s\n" (make-epsilon-closure delta-map))
      (let ([e (make-epsilon-closure delta-map)])
        (check-true (set-member? (hash-ref e 0) 0))
        (check-true (set-member? (hash-ref e 0) 1))
        (check-true (set-member? (hash-ref e 1) 1))
        (check-true (set-member? (hash-ref e 2) 2))
        )
      )
    (let ([delta-map (make-delta-map)])
      (set-delta-map! delta-map (list 0 "a") (list 1 "z"))
      (set-delta-map! delta-map (list 0 "EPS") (list 1 "y"))
      (set-delta-map! delta-map (list 1 "b") (list 2 "x"))
      (set-delta-map! delta-map (list 1 "EPS") (list 2 "x"))
      (set-delta-map! delta-map (list 2 "a") (list 0 "w"))
      (printf "epsilon-closure: ~s\n" (make-epsilon-closure delta-map))
      (let ([e (make-epsilon-closure delta-map)])
        (check-true (set-member? (hash-ref e 0) 0))
        (check-true (set-member? (hash-ref e 0) 1))
        (check-true (set-member? (hash-ref e 0) 2))
        (check-true (set-member? (hash-ref e 1) 1))
        (check-true (set-member? (hash-ref e 1) 2))
        (check-true (set-member? (hash-ref e 2) 2))
        )
      )
    (let ([delta-map (trial-delta-map)]) ; use one that looks like a Turing machine delta-map
      (printf "epsilon-closure: ~s\n" (make-epsilon-closure delta-map))
      (let ([e (make-epsilon-closure delta-map)])
        (check-true (set-member? (hash-ref e 0) 0))
        (check-true (set-member? (hash-ref e 1) 1))
        )
      )
    );; end test-case

   )) ;; end DELTA-tests suite and tests


;; ===== tapestruct tests
(define tape-tests
  (test-suite
   "initialize and manipulate tape"
  
   (test-case
    "Test making tape"
    (let ([tape (make-tape)])
      (check-equal? (get-tape-right tape) '())
      (check-equal? (get-tape-left tape) '())
      (check-true (or (equal? (get-tape-current tape) " ")
                      (equal? (get-tape-current tape) BLANK)))
      )
    (let ([tape (make-tape "a" "b" "B")])
      (check-equal? (get-tape-right tape) (list "b" "B"))
      (check-equal? (get-tape-left tape) '())
      (check-equal? (get-tape-current tape) "a")
      )
    (let ([tape (make-tape "a")])
      (check-equal? (get-tape-right tape) '())
      (check-equal? (get-tape-left tape) '())
      (check-equal? (get-tape-current tape) "a")
      )
    );; end test-case
  
   (test-case
    "Test trimming tape"
    (let ([left-tape '(" " " " "b")]
          [right-tape '("a" " ")])
      (check-equal? (trim-left-tape left-tape) '("b"))
      (check-equal? (trim-right-tape right-tape) '("a"))
      )
    (let ([left-tape '("B" " " "b")]
          [right-tape '("a" "B")])
      (check-equal? (trim-left-tape left-tape) '("b"))
      (check-equal? (trim-right-tape right-tape) '("a"))
      )
    (let ([left-tape '(" " " ")]
          [right-tape '(" " "B")])
      (check-equal? (trim-left-tape left-tape) '())
      (check-equal? (trim-right-tape right-tape) '())
      )
    (let ([left-tape '("a" " " "b" " ")]
          [right-tape '(" " "a" " " "b")])
      (check-equal? (trim-left-tape left-tape) left-tape)
      (check-equal? (trim-right-tape right-tape) right-tape)
      )
    (let ([tape (make-tape)])
      (set-tape! tape '(" " "B" "z") "B" '(" "))
      (trim-tape tape)
      (check-equal? (get-tape-left tape) '("z"))
      (check-equal? (get-tape-right tape) '())
      (check-true (or (equal? (get-tape-current tape) " ")
                      (equal? (get-tape-current tape) BLANK)))
      )
    );; end test-case

   (test-case
    "Test moving head against TAPE"
    (let ([tape (make-tape "a" "b" "B")])
      (move-head-right tape)
      (check-equal? (get-tape-left tape) (list "a"))
      (check-equal? (get-tape-right tape) (list "B"))
      (check-equal? (get-tape-current tape) "b")
      (move-head-left tape)
      (check-equal? (get-tape-left tape) '())
      (check-equal? (get-tape-right tape) (list "b" "B"))
      (check-equal? (get-tape-current tape) "a"))
    (let ([tape (make-tape)])
      (check-equal? (get-tape-right tape) '())
      (check-equal? (get-tape-left tape) '())
      (check-true (or (equal? (get-tape-current tape) " ")
                      (equal? (get-tape-current tape) BLANK)))
      (move-head-right tape)
      (trim-tape tape)
      (check-equal? (get-tape-left tape) '())
      (check-equal? (get-tape-right tape) '())
      (check-true (or (equal? (get-tape-current tape) " ")
                      (equal? (get-tape-current tape) BLANK)))
      (move-head-left tape)
      (trim-tape tape)
      (check-equal? (get-tape-left tape) '())
      (check-equal? (get-tape-right tape) '())
      (check-true (or (equal? (get-tape-current tape) " ")
                      (equal? (get-tape-current tape) BLANK)))
      )
    );; end test-case

   )) ;; end TAPE-tests suite and tests


;; ===== Stack making
(define stack-tests
  (test-suite
   "stack making tests"

   (test-case
    "Test making the stack"
    (let ([stack (make-stack "g0" "g1")])
      (check = 3 (length stack))
      (check equal? "g0" (first stack))
      (check equal? "g1" (second stack))
      (check equal? BOT (third stack))))
   (test-case
    "Test making the empty stack"
    (let ([stack (make-stack)])
      (check = 1 (length stack))
      (check equal? BOT (first stack))))

   ; Stack operations
   (test-case
    "Test stack push and pop operations"
    (let ([st (make-stack "g0" "g1" "g2")])
      (check = (+ 1 (length st)) (length (stack-push #\w st)))
      (check = (- (length st) 1) (length (stack-pop st)))
      (check equal? (cdr st) (stack-pop st))
      (check equal? "g0" (stack-top st))
      (check equal? st (stack-push "g0" (stack-pop st)))
      (check equal? st (stack-pop (stack-push "g3" st)))
      (check equal? (make-stack "g3" "g2" "g0" "g1" "g2") (stack-push-list (list "g3" "g2") st))
      ))
   (test-case
    "Test stack-bot? operation"
    (let ([st0 (make-stack "g0" "g1" "g2")]
          [st1 (make-stack)])
      (check-false (stack-bot? st0))
      (check-true (stack-bot? st1))
      ))
   )) ;; end stack-making suite and tests


;; ===== Machine making
(define machine-tests
  (test-suite
   "machine making tests"

   (test-case
    "Test making the machine"
    (let ([m (machine-create)])
      (check equal? (machinestruct-instructions m) '())
      ))

   (test-case
    "Test machine operations"
    (let ([m (machine-create)]
          [dummy-instruction (list "state" "token")]
          [dummy-accepting-state 5])
      (machine-add-instruction m dummy-instruction)
      (check-equal? (machinestruct-instructions m) (list dummy-instruction))
      (machine-add-accepting-state m dummy-accepting-state)
      (check-true (set-member? (machinestruct-acceptingstates m) dummy-accepting-state))
      ))
      
   (test-case
    "Test machine->string"
    (let ([m (machine-create)]
          [dummy-instruction (list "state" "token")]
          [dummy-accepting-state 5])
      (machine-add-instruction m dummy-instruction)
      (machine-add-accepting-state m dummy-accepting-state)
      ; (printf "~a\n" (machine->string m))
      ))
   )) ;; end machine-making suite and tests


;; ===== History making
(define (string-pad n)
  (apply string-append (build-list n (lambda (x) "  "))))
   
(define history-tests
  (test-suite
   "history tests"

   (test-case
    "Test making a history"
    (let* ([config (list "a" "b")]
           [history (make-history config)])
      ; (printf "~s\n" history)
      (check-equal? (car history) config)
      ))

   (test-case
    "Test building a history"
    (let* ([config (list "a" "b")]
           [history (make-history config)]
           [new-config (list "c" "d")]
           [new-history-node (make-history-node new-config)])
      (add-history-node! history new-history-node)
      (printf "~s\n" history)
      (check-equal? (car history) config)
      (check-true (set-member? (cdr history) new-history-node))
      ))

   (test-case
    "Test building a history"
    (let* ([config (list 1)]
           [history (make-history config)]
           ; rank 1
           [node-2 (add-history-node! history (make-history-node '(2)))]
           [node-3 (add-history-node! history (make-history-node '(3)))]
           ; rank 2
           [node-4 (add-history-node! node-2 (make-history-node '(4)))]
           [node-5 (add-history-node! node-2 (make-history-node '(5)))]
           [node-6 (add-history-node! node-2 (make-history-node '(6)))]
           [node-7 (add-history-node! node-3 (make-history-node '(7)))]
           ; rank 3
           [node-8 (add-history-node! node-4 (make-history-node '(8)))]
           [node-9 (add-history-node! node-4 (make-history-node '(9)))]
           [node-10 (add-history-node! node-5 (make-history-node '(10)))]
           [node-11 (add-history-node! node-6 (make-history-node '(11)))]
           [node-12 (add-history-node! node-7 (make-history-node '(12)))]
           [node-13 (add-history-node! node-7 (make-history-node '(13)))]
           ; rank 4
           [node-14 (add-history-node! node-11 (make-history-node '(14)))]
           [node-15 (add-history-node! node-13 (make-history-node '(15)))]
           )
      (printf "history: ~s\n" history)
      (traverse-history-dfs history 0 (lambda (x y) (printf "~a~s\n" (string-pad y) (caar x))))
;      (check-equal? (car history) config)
;      (check-true (set-member? (cdr history) new-history-node))
      ))

   )) ;; end history-making suite and tests


;; ===== Parsing
;; string -> string
;; From the .loop filename, return the string of that file
;;   filename  string  Name of .loop file, without directory and including the .loop
(define MACHINE-DIR "machines/")  ; subdirectory holding the .pdm files

;; string -> string
;; Get contents of file as one long string
(define (read-pgm-file filename)
  (port->string (open-input-file (string-append MACHINE-DIR filename)) #:close? #t))

(define parse-tests
  (test-suite
   "parse tests"

   (test-case
    "Test regexp's"
    (regexp-match? EMPTY-LINE-REGEXP "# test comment line")
    (regexp-match? EMPTY-LINE-REGEXP "")
    (regexp-match? EMPTY-LINE-REGEXP "   ")
    (let ([line "EPSILON 0 1"]) ;; epsilon transition
      (check-true (regexp-match? EPSILON-REGEXP line)))
    (let ([line "EPS 0 1"]) 
      (check-true (regexp-match? EPSILON-REGEXP line)))
    (let ([line "EPS: 0 1"]) 
      (check-true (regexp-match? EPSILON-REGEXP line)))
    (let ([line "EPS: 0, 1"]) 
      (check-true (regexp-match? EPSILON-REGEXP line)))
    (let ([line "EPS 0"]) 
      (check-false (regexp-match? EPSILON-REGEXP line)))
    (let* ([line "EPSILON 0 1"]
           [m (regexp-match* EPSILON-REGEXP line #:match-select cdr)]) 
      (check-equal? (length (car m)) 4))
    (let ([line "FINAL 3 4"]) ;; final states
      (check-true (regexp-match? FINAL-STATES-REGEXP line)))
    (let ([line "FINAL 3"]) 
      (check-true (regexp-match? FINAL-STATES-REGEXP line)))
    (let ([line "FINAL 3  # add final state"]) 
      (check-true (regexp-match? FINAL-STATES-REGEXP line)))
    (let ([line "FINAL: 3"]) 
      (check-true (regexp-match? FINAL-STATES-REGEXP line)))
    (let ([line "FINAL: 3, 4"]) 
      (check-true (regexp-match? FINAL-STATES-REGEXP line)))
    (let* ([line "FINAL 3 4"]
           [m (regexp-match* FINAL-STATES-REGEXP line #:match-select cdr)]) 
      (check-equal? (length (parse-final-states m)) 2)
      (check-equal? (first (parse-final-states m)) 3)
      (check-equal? (second (parse-final-states m)) 4))
    (let* ([line "FINAL 3 4  # test with comment"]
           [m (regexp-match* FINAL-STATES-REGEXP line #:match-select cdr)]) 
      (check-equal? (length (parse-final-states m)) 2)
      (check-equal? (first (parse-final-states m)) 3)
      (check-equal? (second (parse-final-states m)) 4))
    (let* ([line "ACCEPTING 3 4"]
           [m (regexp-match* FINAL-STATES-REGEXP line #:match-select cdr)]) 
      (check-equal? (length (parse-final-states m)) 2)
      (check-equal? (first (parse-final-states m)) 3)
      (check-equal? (second (parse-final-states m)) 4))
    (let* ([line "FINAL 3"]
           [m (regexp-match* FINAL-STATES-REGEXP line #:match-select cdr)]) 
      (check-equal? (length (parse-final-states m)) 1)
      (check-equal? (first (parse-final-states m)) 3))
    (let* ([line "FINAL"]
           [m (regexp-match* FINAL-STATES-REGEXP line #:match-select cdr)]) 
      (check-equal? (length (parse-final-states m)) 0))
    )
   
   (test-case
    "parse-epsilon-transition test"
    (let* ([line "EPSILON 0 1"]
           [m (regexp-match* EPSILON-REGEXP line #:match-select cdr)])
      (printf "(parse-epsilon-transition m)=~s\n" (parse-epsilon-transition m))
      (check-equal? (length (parse-epsilon-transition m)) 2)
      (check-equal? (first (parse-epsilon-transition m)) 0)
      (check-equal? (second (parse-epsilon-transition m)) 1)
      )
    )

   )) ;; end parse suite and tests


;; ===== Run the tests; comment out ones not being worked-on
; (run-tests delta-tests)
;(run-tests tape-tests)
;(run-tests stack-tests)
; (run-tests history-tests)
;(run-tests machine-tests)
(run-tests parse-tests)
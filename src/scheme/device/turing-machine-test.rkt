#lang racket
(require rackunit
         "device.rkt"
         "turing-machine.rkt")
(require rackunit/text-ui) ; to run the test suites


;; ===== instruction tests
(define instruction-tests
  (test-suite
   "instruction tests"
  
   (test-case
    "Test machine instructions simple"
    (let* ([ps 4]
           [pt "c"]
           [nt "d"]
           [ns 5]
           [i (instructionstruct ps pt nt ns)])
      (check-equal? (instructionstruct-presentstate i) ps)
      (check-equal? (instructionstruct-presenttoken i) pt)
      (check-equal? (instructionstruct-nexttoken i) nt)
      (check-equal? (instructionstruct-nextstate i) ns)
      )) ; end test-case and let*
   (test-case
    "Test string conversion"
    (let* ([ps 4]
           [pt "c"]
           [nt "d"]
           [ns 5]
           [i (instructionstruct ps pt nt ns)])
      ; (printf "instruction->string=~s\n" (instruction->string i))
      (check-true (string? (instruction->string i)))
      )) ; end test-case and let*
   )) ;; end instruction suite and tests



;; ===== configuration tests
(define configuration-tests
  (test-suite
   "configuration tests"
  
   (test-case
    "Test machine configuration simple"
    (let* ([s 4]
           [tape (make-tape "a" "b" "B")]
           [c (configurationstruct s tape)])
      (check-equal? (configurationstruct-state c) s)
      (check-equal? (configurationstruct-tape c) tape)
      )) ; end test-case and let*
   (test-case
    "Test string conversion"
    (let* ([s 0]
           [tape (make-tape)]
           [c (configurationstruct s tape)])
      (set-tape! tape '("a" "b") "c" '("d" "e"))
      ; (printf "configuration->string=~s\n" (configuration->string c))
      (check-true (string? (configuration->string c)))
      (check-equal? (configuration->string c) "q0: ab*c*de")
      (check-equal? (configuration->string c #:show-current-blank #t) "q0: ab*c*de")
      (check-equal? (configuration->string c #:show-all-blank #t) "q0: ab*c*de")
      ; try with some blanks so options do something
      (set-tape! tape '("a" " ") " " '(" " "e"))
      (check-true (string? (configuration->string c)))
      (check-equal? (configuration->string c) "q0: a * * e")
      (check-equal? (configuration->string c #:show-current-blank #t) "q0: a *B* e")
      (check-equal? (configuration->string c #:show-all-blank #t) "q0: aB*B*Be")
      )) ; end test-case and let*
   )) ;; end instruction suite and tests




;; ===== parse tests
(define parse-tests
  (test-suite
   "parse tests"
  
   (test-case
    "Test machine instructions only"
    (let* ([INPUT-LINES (list "0 a R 1" "0 b R 1")]
           [tm (parse INPUT-LINES INSTRUCTION-LINE-REGEXP parse-make-instruction instructionstruct)])
      ; (printf "tm=~a\n" (machine->string tm instruction->string))
      (check-equal? (length (machinestruct-instructions tm)) 2)
      ))
   (test-case
    "Test machine instructions and accepting states"
    (let* ([INPUT-LINES (list "0 a R 1" "0 b R 1" "1 a b 1" "ACCEPTING 1 0")]
           [tm (parse INPUT-LINES INSTRUCTION-LINE-REGEXP parse-make-instruction instructionstruct)])
      ; (printf "tm=~a\n" (machine->string tm instruction->string))
      (check-equal? (length (machinestruct-instructions tm)) 3)
      (check-equal? (set-count (machinestruct-acceptingstates tm)) 2)
      ))
   (test-case
    "Test machine instructions and accepting states and epsilon transitions"
    (let* ([INPUT-LINES (list "0 a R 1" "0 b R 1" "1 a b 1" "ACCEPTING 1 0" "EPSILON 1 0" "EPSILON 2 1")]
           [tm (parse INPUT-LINES INSTRUCTION-LINE-REGEXP parse-make-instruction instructionstruct)])
      ; (printf "tm=~a\n" (machine->string tm instruction->string))
      (check-equal? (length (machinestruct-instructions tm)) 3)
      (check-equal? (set-count (machinestruct-acceptingstates tm)) 2)
      (check-true (not (null? (member 1 (hash-keys (machinestruct-epsilonmap tm))))))
      (check-true (not (null? (member 2 (hash-keys (machinestruct-epsilonmap tm))))))
      ))
   )) ;; end tape-making suite and tests



;; ===== tm->string tests
(define tm->string-tests
  (test-suite
   "tm->string tests"
  
   (test-case
    "Test simple cases"
    (let* ([INPUT-LINES (list "0 a R 1" "0 b R 1" "1 a b 1" "ACCEPTING 1 0" "EPSILON 1 0" "EPSILON 2 1")]
           [tm (parse INPUT-LINES INSTRUCTION-LINE-REGEXP parse-make-instruction instructionstruct)])
      (check-true (string? (tm->string tm)))
      ;(printf "turing machine=~a\n" (tm->string tm))
    )
    ) ;; end test-case
   
   )) ;; end tm->string suite and tests


;; ===== tm-transition tests
(define tm-transition-tests
  (test-suite
   "Turing machine transition tests"
  
   (test-case
    "Test simple cases"
    (let* ([tape (make-tape "a" "b" "B")] ; curent token is "a", right tape is ("b" "B")
           [next-action LEFT]
           [next-state 3]
           [next-config (tm-transition tape next-action next-state)])
      ; (printf "tm next config is=~a\n" next-config)
      (check-equal? (configurationstruct-state next-config) 3)
      (check-equal? (get-tape-right (configurationstruct-tape next-config)) (list "a" "b" BLANK))
      (check-equal? (get-tape-current (configurationstruct-tape next-config)) BLANK)
      (check-equal? (get-tape-left (configurationstruct-tape next-config)) '())
      )
    (let* ([tape (make-tape "a" "b" "B")]
           [next-action RIGHT]
           [next-state 3]
           [next-config (tm-transition tape next-action next-state)])
      ; (printf "tm next config is=~a\n" next-config)
      (check-equal? (configurationstruct-state next-config) 3)
      (check-equal? (get-tape-right (configurationstruct-tape next-config)) (list BLANK))
      (check-equal? (get-tape-current (configurationstruct-tape next-config)) "b")
      (check-equal? (get-tape-left (configurationstruct-tape next-config)) (list "a"))
      )
    (let* ([tape (make-tape "a" "b" "B")]
           [next-action "c"]
           [next-state 3]
           [next-config (tm-transition tape next-action next-state)])
      ; (printf "tm next config is=~a\n" next-config)
      (check-equal? (configurationstruct-state next-config) 3)
      (check-equal? (get-tape-right (configurationstruct-tape next-config)) (list "b" BLANK))
      (check-equal? (get-tape-current (configurationstruct-tape next-config)) "c")
      (check-equal? (get-tape-left (configurationstruct-tape next-config)) '())
      )
    )
   
   )) ;; end tape-making suite and tests


;; ===== history tests
(define history-tests
  (test-suite
   "History tests"
  
   (test-case
    "Test building a history"
    (let* ([tape0 (make-tape "a" "b" "B")]
           [config0 (configurationstruct 0 tape0)]
           [history (history-create config0)]
           [tape1 (make-tape "x" "y" "z")]
           [config1 (configurationstruct 0 tape1)]
           [node1 (history-node-make config1)]
           [tape2 (make-tape "m" "n")]
           [config2 (configurationstruct 1 tape2)]
           [node2 (history-node-make config2)])
      (history-node-add! history node1)
      (history-node-add! history node2)
      (printf "~s\n" history)
      (check-equal? (car history) config0)
      (check-true (set-member? (cdr history) node1))
      (printf "history=~a\n" (history->string history))
      (let ([s0 "q0: *a*bB\n +--q0: *x*yz\n +--q1: *m*n"]
            [s1 "q0: *a*bB\n +--q1: *m*n\n +--q0: *x*yz"]
            [r (history->string history)])
        ;(printf "r=~s\n" r)
        ;(printf "(list s0 s1)=~s\n" (list s0 s1))
        (check-true (if (member r (list s0 s1)) #t #f))
        )
      )
    ) ;; end test-case
  
   (test-case
    "Test machine history simple"
    (let* ([s0 0]
           [tape0 (make-tape)]
           [config0 (configurationstruct s0 tape0)]
           [s1 1]
           [tape1 (make-tape)]
           [config1 (configurationstruct s1 tape1)]
           [s2 2]
           [tape2 (make-tape)]
           [config2 (configurationstruct s2 tape2)]
           [s3 3]
           [tape3 (make-tape)]
           [config3 (configurationstruct s3 tape3)]
           [history (history-create config0)]
           [history-node1 (history-node-make config1)]
           [history-node2 (history-node-make config2)]
           [history-node3 (history-node-make config3)])
      (history-node-add! history history-node1)
      (history-node-add! history history-node2)
      (history-node-add! history-node2 history-node3)
      (printf "history->string=~s\n" (history->string history))
      (let ([s0 "q0: *B*\n +--q1: *B*\n +--q2: *B*\n |   +--q3: *B*"]
            [s1 "q0: *B*\n +--q2: *B*\n |   +--q3: *B*\n +--q1: *B*"]
            [r (history->string history)])
;        (printf "history->string=~s\n" r)
;        (printf "             s0=~s\n" s0)
;        (printf "             s1=~s\n" s1)
        (check-true (if (member r (list s0 s1)) #t #f))
        )
;       (printf "!!history->string is: \n~s\n" (history->string history #:deterministic #f))
;       (printf "history->string history-node2 is: \n~a\n" (history->string history-node2 #:deterministic #f))
      )) ; end test-case and let*
   
   )) ;; end history suite and tests


;; ===== one step, one node tests
(define one-step-one-node-tests
  (test-suite
   "One step for one node tests"
  
;   (test-case
;    "Test simple cases"
;    (let* ([tape (make-tape "a" "b" "B")] ; curent token is "a", right tape is ("b" "B")
;           [current-state 0]
;           [config (configurationstruct current-state tape)]
;           [history-node (history-create config)]
;           [INPUT-LINES (list "0 a R 1" "0 b R 1" "1 a b 1" "ACCEPTING 1 0" "EPSILON 1 0" "EPSILON 2 1")]
;           [tm (parse INPUT-LINES INSTRUCTION-LINE-REGEXP parse-make-instruction instructionstruct)]
;           [delta-map (tm->delta-map tm)]
;           ; [test (printf "got here ~s\n" 9)]
;           [epsilon-map (machinestruct-epsilonmap tm)]
;           [all-states (all-states-get delta-map epsilon-map)]
;           [epsilon-closure (epsilon-closure-make epsilon-map all-states)])
;      (printf "turing machine=~a\n" (tm->string tm))
;      (printf "delta-map=~s\n" (delta-map->string delta-map))
;      (printf "epsilon-map=~s\n" (epsilon-map->string epsilon-map))
;      (printf "all-states=~s\n" (set->string all-states))
;      (printf "epsilon-closure=~s\n" (epsilon-closure->string epsilon-closure))
;      (one-step-one-node history-node delta-map epsilon-closure)
;      (printf "after: node=~s\n" (history->string history-node))
;    )
;    ) ;; end test-case
   
;   (test-case
;    "Test deterministic cases"
;    (let* ([tape (make-tape "a" "b" "B")] ; curent token is "a", right tape is ("b" "B")
;           [current-state 0]
;           [config (configurationstruct current-state tape)]
;           [history-node (history-create config)]
;           [INPUT-LINES (list "0 a R 1" "0 b R 1" "1 a b 1" "ACCEPTING 1 0" "EPSILON 1 0" "EPSILON 2 1")]
;           [tm (parse INPUT-LINES INSTRUCTION-LINE-REGEXP parse-make-instruction instructionstruct)]
;           [delta-map (tm->delta-map tm)]
;           ; [test (printf "got here ~s\n" 9)]
;           [epsilon-map (machinestruct-epsilonmap tm)]
;           [all-states (all-states-get delta-map epsilon-map)]
;           [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
;           [next-config-list (one-step-one-node history-node delta-map epsilon-closure)])
;;      (printf "turing machine=~a\n" (tm->string tm))
;;      (printf "delta-map=~s\n" (delta-map->string delta-map))
;;      (printf "epsilon-map=~s\n" (epsilon-map->string epsilon-map))
;;      (printf "all-states=~s\n" (set->string all-states))
;      (printf "epsilon-closure=~s\n" (epsilon-closure->string epsilon-closure))
;      (printf "after: \n~a\n" (history->string history-node #:deterministic #f))
;      (printf "======\n")
;      (printf "next-config-list=~s\n"
;              next-config-list)
;    )
;    ) ;; end test-case
   
;   (test-case
;    "Test deterministic doubler"
;    (let* ([filename "../prologue/machines/doubler.tm"]
;           [input-lines (string-split (port->string (open-input-file filename) #:close? #t) "\n")]
;           [tm (parse input-lines INSTRUCTION-LINE-REGEXP parse-make-instruction instructionstruct)]
;           [delta-map (tm->delta-map tm)]
;           [epsilon-map (machinestruct-epsilonmap tm)]
;           [all-states (all-states-get delta-map epsilon-map)]
;           [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
;           [tape (make-tape "1" "1")] ; current token is "1", right tape is ("1"))
;           [current-state 0]
;           [config (configurationstruct current-state tape)]
;           [history-node (history-create config)]
;           [next-config-list (one-step-one-node history-node delta-map epsilon-closure)]
;           ;; [third-config-list (one-step-one-node history-node delta-map epsilon-closure)]
;           )
;;      (printf "turing machine=~a\n" (tm->string tm))
;;      (printf "delta-map=~s\n" (delta-map->string delta-map))
;;      (printf "epsilon-map=~s\n" (epsilon-map->string epsilon-map))
;;      (printf "all-states=~s\n" (set->string all-states))
;;       (printf "epsilon-closure=~s\n" (epsilon-closure->string epsilon-closure))
;      (printf "after: \n~a\n" (history->string history-node #:deterministic #f))
;      (printf "after: next-config-list: ~s\n" next-config-list)
;      )) ;; end test-case
   
   (test-case
    "Test full run of deterministic doubler"
    (let* ([filename "../prologue/machines/doubler.tm"]
           [input-lines (string-split (port->string (open-input-file filename) #:close? #t) "\n")]
           [tm (parse input-lines INSTRUCTION-LINE-REGEXP parse-make-instruction instructionstruct)]
           [tape (make-tape "1" "1")] ; current token is "1", right tape is ("1"))
           [initial-history-node '()]
           )
      (set! initial-history-node (computation-history-make tm tape))
      (printf "\n\n\nafter: \n~a\n" (history->string initial-history-node #:deterministic #t))
      )) ;; end test-case
   
   )) ;; end tape-making suite and tests


;; ===== Run the tests; comment out ones not being worked-on
;(run-tests instruction-tests)
;(run-tests configuration-tests)
;(run-tests parse-tests)
;(run-tests tm->string-tests)
;(run-tests tm-transition-tests)
(run-tests history-tests)
; (run-tests one-step-one-node-tests)

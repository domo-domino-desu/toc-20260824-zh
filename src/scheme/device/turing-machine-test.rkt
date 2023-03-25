#lang racket
(require rackunit
         "device.rkt"
         "turing-machine.rkt")
(require rackunit/text-ui) ; to run the test suites


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
      (printf "tm next config is=~a\n" next-config)
      (check-equal? (configurationstruct-state next-config) 3)
      (check-equal? (get-tape-right (configurationstruct-tape next-config)) (list "b" BLANK))
      (check-equal? (get-tape-current (configurationstruct-tape next-config)) "c")
      (check-equal? (get-tape-left (configurationstruct-tape next-config)) '())
      )
    )
   
   )) ;; end tape-making suite and tests


;; ===== one step, one node tests
(define one-step-one-node-tests
  (test-suite
   "One step for one node tests"
  
   (test-case
    "Test simple cases"
    (let* ([tape (make-tape "a" "b" "B")] ; curent token is "a", right tape is ("b" "B")
           [current-state 0]
           [config (configurationstruct current-state tape)]
           [history-node (make-history config)]
           [delta-map (delta-map-make)])
      (delta-map-set! delta-map (list 0 "a") (list 1 "b"))
      (delta-map-set! delta-map (list 0 "EPS") (list 0 "b"))
      (delta-map-set! delta-map (list 0 "b") (list 1 "a"))
      (delta-map-set! delta-map (list 1 "a") (list 2 "b"))
      (printf "delta-map=~s\n" delta-map)
    )
    ) ;; end test-case
   
   )) ;; end tape-making suite and tests


;; ===== Run the tests; comment out ones not being worked-on
(run-tests parse-tests)
; (run-tests tm-transition-tests)
; (run-tests one-step-one-node-tests)

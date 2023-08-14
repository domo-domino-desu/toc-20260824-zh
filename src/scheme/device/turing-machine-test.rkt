#lang racket
(require rackunit
         "device.rkt"
         "turing-machine.rkt")
(require rackunit/text-ui) ; to run the test suites

; Example delta map.  Nondeterministic.  Copied from device-test.rkt
(define (trial-delta-map)
  (let ([delta-map (delta-map-make)])
    (delta-map-set! delta-map '(0 "a") '("b" 0))
    (delta-map-set! delta-map '(0 "b") '("b" 1))
    (delta-map-set! delta-map '(1 "a") '("b" 1)) ;; one input has two outputs
    (delta-map-set! delta-map '(1 "a") '("b" 0))
    (delta-map-set! delta-map '(1 "b") '("a" 0))
    delta-map))

; Example epsilon-map.  Modified from device-test.rkt
(define (trial-epsilon-map)
  (let ([epsilon-map (epsilon-map-make)])
    (epsilon-map-set! epsilon-map 0 1)
    epsilon-map))

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
           [tm (parse INPUT-LINES
                      INSTRUCTION-LINE-REGEXP
                      parse-make-instruction
                      instructionstruct)]
           [inst0 (instructionstruct 0 "a" "R" 1)] ; parse target
           [inst1 (instructionstruct 0 "b" "R" 1)])
      ; (printf "tm=~a\n" (tm->string tm))
      (check-equal? (length (machinestruct-instructions tm)) 2)
      (for ([inst (machinestruct-instructions tm)])
        ; (printf "~a\n" (instruction->string inst))
        (check-true (or (equal? inst inst0) (equal? inst inst1))))
      ))
   (test-case
    "Test machine instructions and accepting states"
    (let* ([INPUT-LINES (list "0 a R 1" "0 b R 1" "1 a b 1" "ACCEPTING 1 0")]
           [tm (parse INPUT-LINES
                      INSTRUCTION-LINE-REGEXP
                      parse-make-instruction
                      instructionstruct)]
           [inst0 (instructionstruct 0 "a" "R" 1)] ; parse target
           [inst1 (instructionstruct 0 "b" "R" 1)]
           [inst2 (instructionstruct 1 "a" "b" 1)])
      ; (printf "tm=~a\n" (tm->string tm))
      (check-equal? (length (machinestruct-instructions tm)) 3)
      (for ([inst (machinestruct-instructions tm)])
        ; (printf "~a\n" (instruction->string inst))
        (check-true (or (equal? inst inst0)
                        (equal? inst inst1)
                        (equal? inst inst2))))
      (check-equal? (set-count (machinestruct-acceptingstates tm)) 2)
      (check-true (set=? (machinestruct-acceptingstates tm) (mutable-set 0 1)))
      ))
   (test-case
    "Test machine instructions and accepting states and epsilon transitions"
    (let* ([INPUT-LINES (list "0 a R 1" "0 b R 1" "1 a b 1"
                              "ACCEPTING 1 0"
                              "EPSILON 1 0"
                              "EPSILON 2 1")]
           [tm (parse INPUT-LINES
                      INSTRUCTION-LINE-REGEXP
                      parse-make-instruction
                      instructionstruct)]
           [epsilon-map (machinestruct-epsilonmap tm)])
      ; (printf "tm=~a\n" (tm->string tm))
      (check-equal? (length (machinestruct-instructions tm)) 3)
      (check-equal? (set-count (machinestruct-acceptingstates tm)) 2)
      (check-equal? (mutable-set 0) (epsilon-map-get epsilon-map 1))
      (check-equal? (mutable-set 1) (epsilon-map-get epsilon-map 2))
      ))
   (test-case
    "Test comments"
    (let* ([INPUT-LINES (list "0 a R 1 # xxx" "0 b R 1")]
           [tm (parse INPUT-LINES
                      INSTRUCTION-LINE-REGEXP
                      parse-make-instruction
                      instructionstruct)]
           [inst0 (instructionstruct 0 "a" "R" 1)] ; parse target
           [inst1 (instructionstruct 0 "b" "R" 1)])
      ; (printf "tm=~a\n" (tm->string tm))
      (check-equal? (length (machinestruct-instructions tm)) 2)
      (for ([inst (machinestruct-instructions tm)])
        ; (printf "~a\n" (instruction->string inst))
        (check-true (or (equal? inst inst0) (equal? inst inst1))))
      )
    (let* ([INPUT-LINES (list "# machine name" "0 a R 1" "0 b R 1")]
           [tm (parse INPUT-LINES
                      INSTRUCTION-LINE-REGEXP
                      parse-make-instruction
                      instructionstruct)]
           [inst0 (instructionstruct 0 "a" "R" 1)] ; parse target
           [inst1 (instructionstruct 0 "b" "R" 1)])
      ; (printf "tm=~a\n" (tm->string tm))
      (check-equal? (length (machinestruct-instructions tm)) 2)
      (for ([inst (machinestruct-instructions tm)])
        ; (printf "~a\n" (instruction->string inst))
        (check-true (or (equal? inst inst0) (equal? inst inst1))))
      )
    (let* ([INPUT-LINES (list "  # machine name" "0 a R 1" "0 b R 1")] ; space
           [tm (parse INPUT-LINES
                      INSTRUCTION-LINE-REGEXP
                      parse-make-instruction
                      instructionstruct)]
           [inst0 (instructionstruct 0 "a" "R" 1)] ; parse target
           [inst1 (instructionstruct 0 "b" "R" 1)])
      ; (printf "tm=~a\n" (tm->string tm))
      (check-equal? (length (machinestruct-instructions tm)) 2)
      (for ([inst (machinestruct-instructions tm)])
        ; (printf "~a\n" (instruction->string inst))
        (check-true (or (equal? inst inst0) (equal? inst inst1))))
      )
    )
   
   )) ;; end parsing suite and tests



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


;; ===== yields tests

;; Sample Turing machine for tests
(define (trial-tm0)
  (let* ([tm (tm-create)]
         )
    (tm-add-instruction tm (instructionstruct 0 "0" "1" 1))
    (tm-add-instruction tm (instructionstruct 0 "1" "1" 1))
    (tm-add-instruction tm (instructionstruct 1 "0" "0" 0))
    (tm-add-instruction tm (instructionstruct 1 "1" "0" 0))
    tm))
(define (trial-tm1) ; move left and right
  (let* ([tm (tm-create)]
         )
    (tm-add-instruction tm (instructionstruct 0 "0" "R" 0))
    (tm-add-instruction tm (instructionstruct 0 "1" "L" 0))
    tm))
(define (trial-tm2) ;; nondeterminstic
  (let* ([tm (tm-create)]
         )
    (tm-add-instruction tm (instructionstruct 0 "0" "1" 1))
    (tm-add-instruction tm (instructionstruct 0 "0" "0" 1))
    (tm-add-instruction tm (instructionstruct 0 "1" "1" 1))
    ; (tm-add-instruction tm (instructionstruct 1 "0" "0" 0))
    (tm-add-instruction tm (instructionstruct 1 "1" "0" 0))
    tm))
(define (trial-tm3)  ; epsilon moves
  (let* ([tm (tm-create)]
         )
    (tm-add-instruction tm (instructionstruct 0 "0" "1" 1))
    (tm-add-instruction tm (instructionstruct 0 "1" "0" 0))
    (tm-add-instruction tm (instructionstruct 1 "0" "1" 0))
    (tm-add-instruction tm (instructionstruct 1 "1" "0" 1))
    (tm-add-epsilon tm 0 1)
    tm))

(define yields-tests
  (test-suite
   "Turing machine yields function tests"
  
   (test-case
    "Test simple case of delta-yields"
    (let* ([tm (trial-tm0)]
           [tape (make-tape "0" "0")]
           [initial-config (configurationstruct 0 tape)]
           [delta-map (tm->delta-map tm)]
           )
      ; (printf "tm=~a\n" (tm->string tm))
      ; (printf "delta-map=~a\n" (delta-map->string delta-map))
      (check-true (set-mutable? (delta-yields delta-map initial-config)))
      (check-equal? 1 (set-count (delta-yields delta-map initial-config)))
      (check-equal? 1 (configurationstruct-state
                       (set-first (delta-yields delta-map initial-config))))
      (check-equal? "1" (get-tape-current
                         (configurationstruct-tape
                          (set-first (delta-yields delta-map initial-config)))))
      )
    )
   (test-case
    "Test delta-yields"
    (let* ([tm (trial-tm0)]
           [tape (make-tape "1" "1")]
           [initial-config (configurationstruct 0 tape)]
           [delta-map (tm->delta-map tm)]
           [output-config-set (delta-yields delta-map initial-config)]
           )
      ; (printf "tm=~a\n" (tm->string tm))
      ; (printf "delta-map=~a\n" (delta-map->string delta-map))
      (check-equal? 1 (configurationstruct-state
                       (set-first output-config-set)))
      (check-equal? "1" (get-tape-current
                         (configurationstruct-tape
                          (set-first output-config-set))))
      )
    )
   (test-case
    "Test delta-yields left and right tape motion"
    (let* ([tm (trial-tm1)]
           [tape (make-tape "0" "1" "B")]
           [initial-config (configurationstruct 0 tape)]
           [delta-map (tm->delta-map tm)]
           [output-config-list1 (delta-yields delta-map initial-config)]
           [output-config-list2 (delta-yields delta-map
                                              (set-first output-config-list1))]
           )
      ; (printf "tm=~a\n" (tm->string tm))
      ; (printf "delta-map=~a\n" (delta-map->string delta-map))
      (check-equal? 0 (configurationstruct-state
                       (set-first output-config-list1)))
      (check-equal? "1" (get-tape-current
                         (configurationstruct-tape
                          (set-first output-config-list1))))
      (check-equal? 0 (configurationstruct-state
                       (set-first output-config-list2)))
      (check-equal? "0" (get-tape-current
                         (configurationstruct-tape
                          (set-first output-config-list2))))
      )
    )
   (test-case
    "Test delta-yields for nondeterministic machine"
    (let* ([tm (trial-tm2)]
           [tape (make-tape "0" "1" "B")]
           [initial-config (configurationstruct 0 tape)]
           [delta-map (tm->delta-map tm)]
           [output-config-set (delta-yields delta-map initial-config)]
           ; [first-output (set-first output-config-list)]
           ; [second-output (second output-config-list)]
           )
      ; (printf "tm=~a\n" (tm->string tm))
      ; (printf "delta-map=~a\n" (delta-map->string delta-map))
      (for ([config output-config-set])
        (check-true (or (equal? config
                                (configurationstruct 1 tape))
                        (equal? config
                                (configurationstruct 1 (make-tape "1" "1" "B"))))
                    ))
      )
    (let* ([tm (trial-tm2)]  ; machine has no instruction for q1, "0"
           [tape (make-tape "0" "B")]
           [initial-config (configurationstruct 1 tape)]
           [delta-map (tm->delta-map tm)]
           [output-config-set (delta-yields delta-map initial-config)]
           )
      ;(printf "tm=~a\n" (tm->string tm))
      ;(printf "delta-map=~a\n" (delta-map->string delta-map))
      ;(printf "output config set ~s\n" output-config-set)
      (check-true (set-empty? output-config-set)
      )
    )
    )
   (test-case
    "Test epsilon-yields for machine without epsilon moves"
    (let* ([tm (trial-tm2)]
           [tape (make-tape "0" "B")]
           [initial-config (configurationstruct 0 tape)]
           [delta-map (tm->delta-map tm)]
           [epsilon-map (machinestruct-epsilonmap tm)]
           [all-states (all-states-get delta-map epsilon-map)]
           [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
           [output-config-set (epsilon-yields epsilon-closure initial-config)]
           [initial-config1 (configurationstruct 1 tape)]
           [output-config-set1 (epsilon-yields epsilon-closure initial-config1)]
           )
      ;(printf "tm=~a\n" (tm->string tm))
      ;(printf "delta-map=~a\n" (delta-map->string delta-map))
      ;(printf "epsilon-map=~a\n" (epsilon-map->string epsilon-map))
      ;(printf "epsilon-closure=~a\n" (epsilon-closure->string epsilon-closure))
      (check-equal? output-config-set
                    (mutable-set (configurationstruct 0 tape)))
      (check-equal? output-config-set1
                    (mutable-set (configurationstruct 1 tape)))
      )
    )
   (test-case
    "Test epsilon-yields for machine with epsilon moves"
    (let* ([tm (trial-tm3)]
           [tape (make-tape "0" "1" "B")]
           [initial-config (configurationstruct 0 tape)]
           [delta-map (tm->delta-map tm)]
           [epsilon-map (machinestruct-epsilonmap tm)]
           [all-states (all-states-get delta-map epsilon-map)]
           [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
           [output-config-set (epsilon-yields epsilon-closure initial-config)]
           [initial-config1 (configurationstruct 1 tape)]
           [output-config-set1 (epsilon-yields epsilon-closure initial-config1)]
           )
      ;(printf "tm=~a\n" (tm->string tm))
      ;(printf "delta-map=~a\n" (delta-map->string delta-map))
      ;(printf "epsilon-map=~a\n" (epsilon-map->string epsilon-map))
      ;(printf "epsilon-closure=~a\n" (epsilon-closure->string epsilon-closure))
      (check-equal? output-config-set
                    (mutable-set (configurationstruct 0 tape)
                                 (configurationstruct 1 tape)))
      (check-equal? output-config-set1
                    (mutable-set (configurationstruct 1 tape)))
      )
    )
;   (test-case
;    "Test yields for simple machine"
;    (let* ([tm (trial-tm0)]
;           [tape (make-tape "0" "1" "B")]
;           [initial-config (configurationstruct 0 tape)]
;           [delta-map (tm->delta-map tm)]
;           [epsilon-map (machinestruct-epsilonmap tm)]
;           [all-states (all-states-get delta-map epsilon-map)]
;           [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
;           )
;      ;(printf "tm=~a\n" (tm->string tm))
;      ;(printf "delta-map=~a\n" (delta-map->string delta-map))
;      ;(printf "epsilon-map=~a\n" (epsilon-map->string epsilon-map))
;      ;(printf "epsilon-closure=~a\n" (epsilon-closure->string epsilon-closure))
;      ;(printf "yields: ~s\n " (yields initial-config delta-map epsilon-closure))
;      (check-true (set-mutable? (yields initial-config
;                                        delta-map
;                                        epsilon-closure)))
;      (check-equal? (set-first
;                      (yields initial-config delta-map epsilon-closure))
;                    (configurationstruct 1 (make-tape "1" "1" "B")))
;      )
;    )
;   (test-case
;    "Test yields for nondeterministic machine without epsilon moves"
;    (let* ([tm (trial-tm2)]
;           [tape (make-tape "0" "1" "B")]
;           [initial-config (configurationstruct 0 tape)]
;           [delta-map (tm->delta-map tm)]
;           [epsilon-map (machinestruct-epsilonmap tm)]
;           [all-states (all-states-get delta-map epsilon-map)]
;           [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
;           [y-set (yields initial-config delta-map epsilon-closure)]
;           )
;      ;(printf "tm=~a\n" (tm->string tm))
;      ;(printf "delta-map=~a\n" (delta-map->string delta-map))
;      ;(printf "epsilon-map=~a\n" (epsilon-map->string epsilon-map))
;      ;(printf "epsilon-closure=~a\n" (epsilon-closure->string epsilon-closure))
;      ;(printf "yields: ~s\n " (yields initial-config delta-map epsilon-closure))
;      (check-true (set-mutable? y-set))
;      (check-equal? 2 (set-count y-set))
;      (check-true (set=? y-set
;                         (mutable-set (configurationstruct
;                                       1
;                                       (make-tape "0" "1" "B"))
;                                      (configurationstruct
;                                       1
;                                       (make-tape "1" "1" "B")))))
;      )
;    )
;   (test-case
;    "Test yields for deterministic machine with epsilon moves"
;    (let* ([tm (trial-tm3)]
;           [tape (make-tape "1" "B")]
;           [initial-config (configurationstruct 0 tape)]
;           [delta-map (tm->delta-map tm)]
;           [epsilon-map (machinestruct-epsilonmap tm)]
;           [all-states (all-states-get delta-map epsilon-map)]
;           [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
;           [y-set (yields initial-config delta-map epsilon-closure)]
;           )
;      (printf "tm=~a\n" (tm->string tm))
;      (printf "delta-map=~a\n" (delta-map->string delta-map))
;      (printf "epsilon-map=~a\n" (epsilon-map->string epsilon-map))
;      (printf "epsilon-closure=~a\n" (epsilon-closure->string epsilon-closure))
;      (printf "yields: ~s\n " y-set)
;      (check-true (set-mutable? y-set))
;      (check-equal? 2 (set-count y-set))
;      (check-true (set=? y-set
;                         (mutable-set (configurationstruct
;                                       0
;                                       (make-tape "0" "B"))
;                                      (configurationstruct
;                                       1
;                                       (make-tape "0" "B")))))
;      )
;    )
    
   )) ;; end yield-tests suite and tests


;; ===== history tests

; Make a deep sample history (copied from device-test)
; q0
;   | q1
;      | q3
;        | q4
;           | q6
;        | q5
;   | q2
(define (history-make-test2)
  (let* ([config (list "q0")]
         [history (history-create config)]
         [config1 (list "q1")]
         [node1 (child-node-add! history config1)]
         [config2 (list "q2")]
         [node2 (child-node-add! history config2)]
         [config3 (list "q3")]
         [node3 (child-node-add! node1 config3)]
         [config4 (list "q4")]
         [node4 (child-node-add! node3 config4)]
         [config5 (list "q5")]
         [node5 (child-node-add! node3 config5)]
         [config6 (list "q6")]
         [node6 (child-node-add! node4 config6)]
         )
  history))

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

(define (trial-tm10) ; go to halting state
  (let* ([tm (tm-create)]
         )
    (tm-add-instruction tm (instructionstruct 0 "0" "L" 1))
    (tm-add-instruction tm (instructionstruct 0 "1" "L" 1))
    tm))

;; ===== one step tests
(define one-step-tests
  (test-suite
   "Tests of one-step!"

   (test-case
    "Test one-step! for simple machine without epsilon moves"
    (let* ([tm (trial-tm0)]
           [tape (make-tape "0" "B")]
           [initial-config (configurationstruct 0 tape)]
           [delta-map (tm->delta-map tm)]
           [epsilon-map (machinestruct-epsilonmap tm)]
           [all-states (all-states-get delta-map epsilon-map)]
           [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
           [history-root (history-create initial-config)]
           )
      ;(printf "tm=~a\n" (tm->string tm))
      ;(printf "delta-map=~a\n" (delta-map->string delta-map))
      ;(printf "epsilon-map=~a\n" (epsilon-map->string epsilon-map))
      ;(printf "epsilon-closure=~a\n" (epsilon-closure->string epsilon-closure))
      (check-true (set-mutable? (one-step! history-root
                                           delta-map
                                           epsilon-closure)))
      ;(printf "tree-root=\n~a\n" (history->string
      ;                            history-root
      ;                            #:configuration->string configuration->string))
      )
    )
   (test-case
    "Test one-step! for simple machine without epsilon moves"
    (let* ([tm (trial-tm0)]
           [tape (make-tape "0" "B")]
           [initial-config (configurationstruct 0 tape)]
           [delta-map (tm->delta-map tm)]
           [epsilon-map (machinestruct-epsilonmap tm)]
           [all-states (all-states-get delta-map epsilon-map)]
           [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
           [history-root (history-create initial-config)]
           [final-nodes (one-step! history-root delta-map epsilon-closure)]
           )
      ;(printf "tm=~a\n" (tm->string tm))
      ;(printf "delta-map=~a\n" (delta-map->string delta-map))
      ;(printf "epsilon-map=~a\n" (epsilon-map->string epsilon-map))
      ;(printf "epsilon-closure=~a\n" (epsilon-closure->string epsilon-closure))
      (check-true (set-mutable? final-nodes))
      (check-equal? 1 (set-count final-nodes))
      )
    )
   (test-case
    "Test one-step! for machine without epsilon moves, going to blank"
    (let* ([tm (trial-tm10)]
           [tape (make-tape "0" "B")]
           [initial-config (configurationstruct 0 tape)]
           [delta-map (tm->delta-map tm)]
           [epsilon-map (machinestruct-epsilonmap tm)]
           [all-states (all-states-get delta-map epsilon-map)]
           [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
           [history-root (history-create initial-config)]
           [final-nodes (one-step! history-root delta-map epsilon-closure)]
           )
      ;(printf "tm=~a\n" (tm->string tm))
      ;(printf "delta-map=~a\n" (delta-map->string delta-map))
      ;(printf "epsilon-map=~a\n" (epsilon-map->string epsilon-map))
      ;(printf "epsilon-closure=~a\n" (epsilon-closure->string epsilon-closure))
      (check-true (set-mutable? final-nodes))
      (check-equal? 1 (set-count final-nodes))
      ; (printf "final node: ~s\n" (set-first final-nodes))
      (check-equal? (get-tape-current
                     (configurationstruct-tape (history-node-config
                                                (set-first final-nodes))))
                    BLANK)
      (check-equal? (configurationstruct-state (history-node-config
                                                 (set-first final-nodes)))
                    1)
      )
    )
   (test-case
    "Test one-step! for machine without epsilon moves, at a halt state"
    (let* ([tm (trial-tm10)]
           [tape (make-tape "B" "0" "B")]
           [initial-config (configurationstruct 1 tape)]
           [delta-map (tm->delta-map tm)]
           [epsilon-map (machinestruct-epsilonmap tm)]
           [all-states (all-states-get delta-map epsilon-map)]
           [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
           [history-root (history-create initial-config)]
           [final-nodes (one-step! history-root delta-map epsilon-closure)]
           )
      ;(printf "tm=~a\n" (tm->string tm))
      ;(printf "delta-map=~a\n" (delta-map->string delta-map))
      ;(printf "epsilon-map=~a\n" (epsilon-map->string epsilon-map))
      ;(printf "epsilon-closure=~a\n" (epsilon-closure->string epsilon-closure))
      (check-equal? 0 (set-count final-nodes))
      )
    )
   (test-case
    "Test one-step! for machine with epsilon moves"
    (let* ([tm (trial-tm3)]
           [tape (make-tape "0" "B")]
           [initial-config (configurationstruct 1 tape)]
           [delta-map (tm->delta-map tm)]
           [epsilon-map (machinestruct-epsilonmap tm)]
           [all-states (all-states-get delta-map epsilon-map)]
           [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
           [history-root (history-create initial-config)]
           [final-nodes (one-step! history-root delta-map epsilon-closure)]
           )
      ;(printf "tm=~a\n" (tm->string tm))
      ;(printf "delta-map=~a\n" (delta-map->string delta-map))
      ;(printf "epsilon-map=~a\n" (epsilon-map->string epsilon-map))
      ;(printf "epsilon-closure=~a\n" (epsilon-closure->string epsilon-closure))
      (check-equal? 2 (set-count final-nodes))
      (for ([n final-nodes])
        (let ([cfg (history-node-config n)])
          ; (printf "final node=~s\n" (configuration->string cfg))
          (check-not-false (or (equal? cfg (configurationstruct
                                            0
                                            (make-tape "1" "B")))
                               (equal? cfg (configurationstruct
                                            1
                                            (make-tape "1" "B"))))
                               )))
      )
    )
  
   )) ;; end one-step suite and tests


;; ===== computation history tests
;; Sample Turing machine for tests
(define (trial-tm20)
  (let* ([tm (tm-create)]
         )
    (tm-add-instruction tm (instructionstruct 0 "a" "b" 1))
    (tm-add-instruction tm (instructionstruct 0 "b" "b" 1))
    (tm-add-instruction tm (instructionstruct 1 "a" "a" 0))
    (tm-add-instruction tm (instructionstruct 1 "b" "a" 0))
    tm))
(define (trial-tm21) ; move left and right
  (let* ([tm (tm-create)]
         )
    (tm-add-instruction tm (instructionstruct 0 "a" "R" 0))
    (tm-add-instruction tm (instructionstruct 0 "b" "L" 0))
    tm))
(define (trial-tm22) ;; nondeterminstic
  (let* ([tm (tm-create)]
         )
    (tm-add-instruction tm (instructionstruct 0 "a" "b" 1))
    (tm-add-instruction tm (instructionstruct 0 "a" "a" 1))
    (tm-add-instruction tm (instructionstruct 0 "b" "b" 1))
    ; (tm-add-instruction tm (instructionstruct 1 "a" "a" 0))
    (tm-add-instruction tm (instructionstruct 1 "b" "a" 0))
    tm))
(define (trial-tm23)  ; epsilon moves
  (let* ([tm (tm-create)]
         )
    (tm-add-instruction tm (instructionstruct 0 "0" "1" 1))
    (tm-add-instruction tm (instructionstruct 0 "1" "0" 0))
    (tm-add-instruction tm (instructionstruct 1 "0" "1" 0))
    (tm-add-instruction tm (instructionstruct 1 "1" "0" 1))
    (tm-add-epsilon tm 0 1)
    tm))

(define computation-history-tests
  (test-suite
   "Tests of computation-history-make"

   (test-case
    "Test computation-history-make for simple machine without epsilon moves"
    (let* ([tm (trial-tm20)]
           [tape (make-tape "a" "B")]
           [initial-config (configurationstruct 0 tape)]
           [delta-map (tm->delta-map tm)]
           [epsilon-map (machinestruct-epsilonmap tm)]
           [all-states (all-states-get delta-map epsilon-map)]
           [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
           [history-root '()]
           )
      (printf "tm=~a\n" (tm->string tm))
      (printf "delta-map=~a\n" (delta-map->string delta-map))
      (printf "epsilon-map=~a\n" (epsilon-map->string epsilon-map))
      (printf "epsilon-closure=~a\n" (epsilon-closure->string epsilon-closure))
      (set! history-root
            (computation-history-make tm
                                      tape
                                      #:maximumrank 2))
      (printf "tree-root=\n~a\n" (history->string
                                  history-root
                                  #:configuration->string configuration->string))
      )
    )
  
   )) ;; end computation-history-make suite and tests




;; ===== Run the tests; comment out ones not being worked-on
;(run-tests instruction-tests)
;(run-tests configuration-tests)
; (run-tests parse-tests)
;(run-tests tm->string-tests)
;(run-tests tm-transition-tests)
; (run-tests history-tests)
;(run-tests yields-tests)
;(run-tests one-step-tests)
(run-tests computation-history-tests)
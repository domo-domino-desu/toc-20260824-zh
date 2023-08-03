#lang racket
(require rackunit
         "device.rkt")
(require rackunit/text-ui) ; to run the test suites

;; device-test.rkt
;;
;; Unit tests for device.rkt, from Jim Hefferon's _Theory of Computation_
;; License: GPL 3.0



;; ===== power map tests(define delta-tests
; return a power-map. Useful for test setups
(define (trial-power-map)
  (let ([power-map (power-map-make)])
    (power-map-set! power-map 0 "b")
    (power-map-set! power-map 1 "a")
    (power-map-set! power-map 1 "b") ;; one input has two outputs
    (power-map-set! power-map 2 "a")
    power-map))

(define power-map-tests
  (test-suite
   "initialize power maps"
  
   (test-case
    "Test making power-map"
    (check-true (hash? (power-map-make)))
    );; end test-case
   
   (test-case
    "Test adding to a power-map"
    (let ([pm (power-map-make)]
          [key 2]
          [value 4])
      (power-map-add-key! pm 12)
      (check-true (power-map-key? pm 12))
      (check-true (set-mutable? (power-map-get pm 12)))
      (check-true (set=? (power-map-get pm 12) (mutable-set))) ; empty set
      (power-map-set! pm key value)
      (check-true (power-map-key? pm key))
      (check-false (power-map-key? pm (- key 1)))
      (check-true (set-mutable? (power-map-get pm key)))
      (check-true (set-member? (power-map-get pm key) value))
      )
    );; end test-case
   
   (test-case
    "Test adding multiple values for a single key"
    (let ([pm (power-map-make)]
          [key 2]
          [value 4]
          [other-value 5])
      (power-map-set! pm key value)
      (check-true (set-mutable? (power-map-get pm key)))
      (check-true (set-member? (power-map-get pm key) value))
      (check-false (set-member? (power-map-get pm key) other-value))
      (power-map-set! pm key other-value)
      (check-true (set-member? (power-map-get pm key) value))
      (check-true (set-member? (power-map-get pm key) other-value))
      )
    );; end test-case

   (test-case
    "Test set->string"
    (let ([s (mutable-set 3 4)])
      (check-true (string? (set->string s)))
      ; (printf "set->string=~s\n" (set->string s))
      (check-true (if (member (set->string s) (list "{ 4 3 }"
                                                    "{ 3 4 }")) #t #f))
      )
    (let ([s (mutable-set 2)])
      (check-true (string? (set->string s)))
      ; (printf "set->string=~s\n" (set->string s))
      (check-true (string=? (set->string s) "{ 2 }"))
      )
    (let ([s (mutable-set)])
      (check-true (string? (set->string s)))
      ; (printf "set->string=~s\n" (set->string s))
      (check-true (string=? (set->string s) "{  }"))
      )
    );; end test-case

   (test-case
    "Test power-map->string"
    (let ([pm (trial-power-map)])
      ; (printf "power-map->string=~s\n" (power-map->string pm))
      (check-true (string? (power-map->string pm)))
      (check-true (if (member (power-map->string pm)
                              (list "0 -> { b }\n1 -> { b a }\n2 -> { a }\n"
                                    "0 -> { b }\n1 -> { a b }\n2 -> { a }\n"))
                      #t
                      #f))
      )
    (let ([pm (trial-power-map)])
      (power-map-add-key! pm 3)  ; empty value
      ; (printf "power-map->string=~s\n" (power-map->string pm))
      (check-true (if (member
                       (power-map->string pm)
                       (list "0 -> { b }\n1 -> { b a }\n2 -> { a }\n3 -> {  }\n"
                             "0 -> { b }\n1 -> { a b }\n2 -> { a }\n3 -> {  }\n"))
                      #t
                      #f))
      )
    (let ([pm (power-map-make)])  ; empty power map
      ; (printf "power-map->string=~s\n" (power-map->string pm))
      (check-true (if (string=? (power-map->string pm) "") #t #f))
      )
    );; end test-case

   (test-case
    "Test power-multimap-keys?"
    (let ([power-map (trial-power-map)]
          [input-set (mutable-set 0 2)]) ; 
      (check-true (power-multimap-keys? power-map input-set))
      (check-true (power-multimap-keys? power-map (mutable-set))) ; no bad keys in empty set
      (check-false (power-multimap-keys? power-map (mutable-set 3))) ;
      )
    );; end test-case

   (test-case
    "Test power-multimap"
    (let* ([power-map (trial-power-map)] ; generic case
           [input-set (mutable-set 0 1)]
           [output-set (power-multimap power-map input-set)])
      ; (printf "output set=~s\n" output-set)
      (check-true (set=? (mutable-set "a" "b")
                         output-set))
      )
    (let* ([power-map (trial-power-map)] ; one element input 
           [input-set (mutable-set 0)]
           [output-set (power-multimap power-map input-set)])
      ; (printf "output set=~s\n" output-set)
      (check-true (set=? (mutable-set "b")
                         output-set))
      )
    (let* ([power-map (trial-power-map)] ; empty set input 
           [input-set (mutable-set)]
           [output-set (power-multimap power-map input-set)])
      ; (printf "output set=~s\n" output-set)
      (check-true (set=? (mutable-set)
                         output-set))
      )
    (let* ([power-map (trial-power-map)] ; bad key
           [input-set (mutable-set 3)]
           [output (power-multimap power-map input-set)])
      ; (printf "output=~s\n" output)
      (check-true (equal? POWER-MAP-NOKEY
                          output))
      )
    );; end test-case
    

   )) ;; end power-map-tests suite and tests
  


;; ===== delta tests

; return a delta-map
; useful for test setups
(define (trial-delta-map)
  (let ([delta-map (delta-map-make)])
    (delta-map-set! delta-map '(0 "a") '("b" 0))
    (delta-map-set! delta-map '(0 "b") '("b" 1))
    (delta-map-set! delta-map '(1 "a") '("b" 1)) ;; one input has two outputs
    (delta-map-set! delta-map '(1 "a") '("b" 0))
    (delta-map-set! delta-map '(1 "b") '("a" 0))
    delta-map))

(define delta-tests
  (test-suite
   "initialize and manipulate delta-map and delta"
  
   (test-case
    "Test making delta-map"
    (let ([delta-map (delta-map-make)]
          [input (list 0 "a")]
          [other-input (list 3 "b")]
          [output (list 1)]
          [other-output (list 2)])
      (delta-map-set! delta-map input output)
      (check-true (set-member? (delta delta-map input) output))
      (delta-map-set! delta-map input other-output)
      (delta-map-set! delta-map other-input output)
      (check-true (set-member? (delta delta-map input) output))
      (check-true (set-member? (delta delta-map input) other-output))
      (check-true (set-member? (delta delta-map other-input) output))
      )
    (let ([delta-map (delta-map-make)] ; small delta map
          [input 42])
      (delta-map-add-key! delta-map input)
      (check-true (delta-map-key? delta-map input))
      (check-true (set=? (delta delta-map input) (mutable-set)))
      )
    );; end test-case
  
   (test-case
    "Test delta function"
    (let ([delta-map (delta-map-make)]
          [input (list 0 "a")]
          [other-input (list 3 "b")]
          [output (list 1)])
      (delta-map-set! delta-map input output)
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
    "Test delta-map-set!"
    (let ([delta-map (trial-delta-map)])
      (check-equal? (delta delta-map '(3 "a")) DELTA-NOKEY)
      (delta-map-set! delta-map '(3 "a") '("a" 3))
      (check-true (set-mutable? (delta delta-map '(3 "a"))))
      )
    );; end test-case
  
   (test-case
    "Test delta-map->string function"
    (let ([delta-map (delta-map-make)]
          [input (list 0 "a")]
          [other-input (list 3 "b")]
          [output (list 1 "z")]
          [other-output (list 1 "x")]
          )
      (delta-map-set! delta-map input output)
      (delta-map-set! delta-map input other-output)
      (delta-map-set! delta-map other-input other-output)
      (check-true (string? (delta-map->string delta-map)))
      ; (printf "delta map: ~s\n" (delta-map->string delta-map))
      (check-true (if (member
                       (delta-map->string delta-map)
                       (list "(0 a) -> { (1 z) (1 x) }\n(3 b) -> { (1 x) }\n"
                             "(0 a) -> { (1 x) (1 z) }\n(3 b) -> { (1 x) }\n"))
                      #t
                      #f))
      )
    );; end test-case

   (test-case
    "Test delta-multimap-keys?"
    (let ([delta-map (trial-delta-map)]
          [input-set (mutable-set (list 0 "a") (list 0 "b"))]) ; 
      (check-true (delta-multimap-keys? delta-map input-set))
      (check-true (delta-multimap-keys? delta-map (mutable-set))) ; no bad keys in empty set
      (check-false (delta-multimap-keys? delta-map (mutable-set '(0 "c")))) ;
      )
    );; end test-case

   (test-case
    "Test delta-multimap"
    (let* ([delta-map (trial-delta-map)]
           [input-set (mutable-set (list 0 "a") (list 0 "b"))]
           [output-set (delta-multimap delta-map input-set)])
      ; (printf "output set=~s\n" output-set)
      (check-true (set=? (mutable-set '("b" 0) '("b" 1))
                         output-set))
      )
    (let* ([delta-map (trial-delta-map)]
           [input-set (mutable-set (list 0 "a") (list 0 "b"))]
           [output-set (delta-multimap delta-map input-set)])
      ; (printf "output set=~s\n" output-set)
      (check-true (set=? (mutable-set '("b" 0) '("b" 1))
                         output-set))
      )
    );; end test-case
    
   )) ;; end DELTA-tests suite and tests


;; ===== epsilon-map tests

; return an epsilon-map
; useful for test setups
(define (trial-epsilon-map)
  (let ([epsilon-map (epsilon-map-make)])
    (epsilon-map-set! epsilon-map 0 0)
    (epsilon-map-set! epsilon-map 0 1)
    (epsilon-map-set! epsilon-map 1 1)
    (epsilon-map-set! epsilon-map 2 3)
    epsilon-map))

(define epsilon-tests
  (test-suite
   "initialize and manipulate epsilon-map and epsilon-closure"
  
   (test-case
    "Test making epsilon-map"
    (let ([epsilon-map (epsilon-map-make)]
          [input 0]
          [other-input 2]
          [output 1]
          [other-output 1])
      (epsilon-map-set! epsilon-map input output)
      (check-true (set-member? (epsilon-map-get epsilon-map input) output))
      (epsilon-map-set! epsilon-map input other-output)
      (epsilon-map-set! epsilon-map other-input output)
      (check-true (set-member? (epsilon-map-get epsilon-map input) output))
      (check-true (set-member? (epsilon-map-get epsilon-map input) other-output))
      (check-true (set-member? (epsilon-map-get epsilon-map other-input) output))
      )
    );; end test-case
  
   (test-case
    "Test epsilon function"
    (let ([epsilon-map (epsilon-map-make)]
          [input 0]
          [other-input 1]
          [output 2])
      (epsilon-map-set! epsilon-map input output)
      (check-true (set-member? (epsilon-map-get epsilon-map input) output))
      (check-equal? (epsilon-map-get epsilon-map other-input) EPSILON-NOKEY)
      )
    );; end test-case

   (test-case
    "Another test epsilon function"
    (let ([epsilon-map (trial-epsilon-map)])
      (check-true (set-member? (epsilon-map-get epsilon-map 0) 1))
      (check-equal? (epsilon-map-get epsilon-map 10) EPSILON-NOKEY)
      )
    );; end test-case

   (test-case
    "Test epsilon-map-set!"
    (let ([epsilon-map (trial-epsilon-map)])
      (check-equal? (epsilon-map-get epsilon-map 10) EPSILON-NOKEY)
      (epsilon-map-set! epsilon-map 10 11)
      (check-true (set-mutable? (epsilon-map-get epsilon-map 10)))
      (check-true (set-member? (epsilon-map-get epsilon-map 10) 11))
      )
    );; end test-case
  
   (test-case
    "Test epsilon-map->string function"
    (let ([epsilon-map (epsilon-map-make)]
          [input 0]
          [other-input 1]
          [output 1]
          [other-output 2]
          )
      (epsilon-map-set! epsilon-map input output)
      (epsilon-map-set! epsilon-map input other-output)
      (epsilon-map-set! epsilon-map other-input other-output)
      ; (printf "epsilon: ~s\n" (epsilon-map->string epsilon-map))
      (check-true (string? (epsilon-map->string epsilon-map)))
      )
    );; end test-case
  
  
   (test-case
    "Test epsilon-closure-make"
    ; No iteration needed
    (let ([epsilon-map (epsilon-map-make)])
      (epsilon-map-set! epsilon-map 0 1)  
      (epsilon-map-set! epsilon-map 2 1)
      ; (printf "epsilon-map: ~s\n" (epsilon-map->string epsilon-map))
      (let ([e (epsilon-closure-make epsilon-map '(0 1 2))])
        ; (printf "epsilon-closure: ~s\n" (epsilon-closure->string e))
        (check-true (set-mutable? (power-map-get e 0)))
        (check-true (set-mutable? (power-map-get e 1)))
        (check-true (set-mutable? (power-map-get e 2)))
        (check-true (set-member? (power-map-get e 0) 0))
        (check-true (set-member? (power-map-get e 0) 1))
        (check-true (set-member? (power-map-get e 1) 1))
        (check-true (set-member? (power-map-get e 2) 1))
        (check-true (set-member? (power-map-get e 2) 2))
        )
      )
    ; Iteration needed
    (let ([epsilon-map (epsilon-map-make)])
      (epsilon-map-set! epsilon-map 0 1)  
      (epsilon-map-set! epsilon-map 1 2)
      ; (printf "epsilon-map: ~s\n" (epsilon-map->string epsilon-map))
      (let ([e (epsilon-closure-make epsilon-map '(0 1 2))])
        ; (printf "epsilon-closure: ~s\n" (epsilon-closure->string e))
        (check-true (set-mutable? (power-map-get e 0)))
        (check-true (set-mutable? (power-map-get e 1)))
        (check-true (set-mutable? (power-map-get e 2)))
        (check-true (set-member? (power-map-get e 0) 0))
        (check-true (set-member? (power-map-get e 0) 1))
        (check-true (set-member? (power-map-get e 0) 2))
        (check-true (set-member? (power-map-get e 1) 1))
        (check-true (set-member? (power-map-get e 2) 2))
        )
      )
    );; end test-case

   )) ;; end epsilon-map suite and tests


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
    "Test tape->string"
    (let ([tape (make-tape "a" "b" "B")])
      (check-true (string? (tape->string tape)))
      ; (printf "tape: ~s\n" (tape->string tape))
      (check-equal? (tape->string tape) "*a*bB")
      )
    (let ([tape (make-tape)])
      (check-true (string? (tape->string tape)))
      ; (printf "tape: ~s\n" (tape->string tape))
      (check-equal? (tape->string tape) "*B*")
      )
    (let ([tape (make-tape "a")])
      (check-true (string? (tape->string tape)))
      ; (printf "tape: ~s\n" (tape->string tape))
      (check-equal? (tape->string tape) "*a*"))
    (let* ([tape (make-tape)]
           [tape (set-tape! tape '("a" " " "b") " " '("c" " "))])
      (check-true (string? (tape->string tape)))
      (check-equal? (tape->string tape) "a b* *c ")
      (check-equal? (tape->string tape #:show-current-blank #t) "a b*B*c ")      
      (check-equal? (tape->string tape #:show-all-blank #t) "aBb*B*cB"))
    (let* ([tape (make-tape)]
           [tape (set-tape! tape '() " " '("c" " "))])
      (check-true (string? (tape->string tape)))
      (check-equal? (tape->string tape) "* *c ")
      (check-equal? (tape->string tape #:show-current-blank #t) "*B*c ")      
      (check-equal? (tape->string tape #:show-all-blank #t) "*B*cB"))
    (let* ([tape (make-tape)]
           [tape (set-tape! tape '("a" " " "b") " " '())])
      (check-true (string? (tape->string tape)))
      (check-equal? (tape->string tape) "a b* *")
      (check-equal? (tape->string tape #:show-current-blank #t) "a b*B*")      
      (check-equal? (tape->string tape #:show-all-blank #t) "aBb*B*"))
    (let* ([tape (make-tape)]
           [tape (set-tape! tape '() " " '())])
      (check-true (string? (tape->string tape)))
      (check-equal? (tape->string tape) "* *")
      (check-equal? (tape->string tape #:show-current-blank #t) "*B*")      
      (check-equal? (tape->string tape #:show-all-blank #t) "*B*"))
    (let* ([tape (make-tape)]
           [tape (set-tape! tape '("a" " " "b") "d" '("c" " "))])
      (check-true (string? (tape->string tape)))
      (check-equal? (tape->string tape) "a b*d*c ")
      (check-equal? (tape->string tape #:show-current-blank #t) "a b*d*c ")      
      (check-equal? (tape->string tape #:show-all-blank #t) "aBb*d*cB"))
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
      (set! tape (move-head-right tape))
      (check-equal? (get-tape-left tape) (list "a"))
      (check-equal? (get-tape-right tape) (list "B"))
      (check-equal? (get-tape-current tape) "b")
      (set! tape (move-head-left tape))
      (check-equal? (get-tape-left tape) '())
      (check-equal? (get-tape-right tape) (list "b" "B"))
      (check-equal? (get-tape-current tape) "a"))
    (let ([tape (make-tape)])
      (check-equal? (get-tape-right tape) '())
      (check-equal? (get-tape-left tape) '())
      (check-true (or (equal? (get-tape-current tape) " ")
                      (equal? (get-tape-current tape) BLANK)))
      (set! tape (trim-tape (move-head-right tape)))
      (check-equal? (get-tape-left tape) '())
      (check-equal? (get-tape-right tape) '())
      (check-true (or (equal? (get-tape-current tape) " ")
                      (equal? (get-tape-current tape) BLANK)))
      (set! tape (trim-tape (move-head-left tape)))
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
    "Test creating an empty machine"
    (let ([m (machine-create)])
      (check-true (list? (machinestruct-instructions m)))
      (check-true (null? (machinestruct-instructions m)))
      (check-true (set-mutable? (machinestruct-acceptingstates m)))
      (check-true (set-empty? (machinestruct-acceptingstates m)))
      (check-true (hash? (machinestruct-epsilonmap m)))
      (check-true (hash-empty? (machinestruct-epsilonmap m)))
      ))

   (test-case
    "Test machine operations"
    (let ([m (machine-create)]
          [dummy-instruction (list 0 "a" "b" 0)]
          [dummy-accepting-state 0])
      (machine-add-instruction m dummy-instruction)
      (check-equal? (machinestruct-instructions m) (list dummy-instruction))
      (machine-add-accepting-state m dummy-accepting-state)
      (check-true (set-member? (machinestruct-acceptingstates m) dummy-accepting-state))
      ))
      
   (test-case
    "Test machine->string"
    (let ([m (machine-create)]
          [dummy-instruction (list 0 "a" "b" 0)]
          [dummy-accepting-state 0]
          )
      (machine-add-instruction m dummy-instruction)
      (machine-add-accepting-state m dummy-accepting-state)
      (machine-add-epsilon m 0 1)
      (machine-add-epsilon m 0 2)
      (printf "~a\n" (machine->string m))
      ))
   )) ;; end machine-making suite and tests


;; ===== History making
(define (string-pad n)
  (apply string-append (build-list n (lambda (x) "  "))))

; Make a simple sample history
; q0
;   | q1
;   | q2
(define (history-make-test0)
  (let* ([config (list "q0")]
         [history (history-create config)]
         [config1 (list "q1")]
         [node1 (child-node-add! history config1)]
         [config2 (list "q2")]
         [node2 (child-node-add! history config2)])
  history))

; Make a deeper sample history
; q0
;   | q1
;   | q2
;   |   | q3
(define (history-make-test1)
  (let* ([config (list "q0")]
         [history (history-create config)]
         [config1 (list "q1")]
         [node1 (child-node-add! history config1)]
         [config2 (list "q2")]
         [node2 (child-node-add! history config2)]
         [config3 (list "q3")]
         [node5 (child-node-add! node2 config3)])
  history))

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

; Make a big sample history
(define (history-make-test4)
  (let* ([config (list "q0")]
         [history (history-create config)]
         ; rank 1
         [node-1 (history-node-add! history (history-node-make '("q1")))]
         [node-2 (history-node-add! history (history-node-make '("q2")))]
         ; rank 2
         [node-3 (history-node-add! node-1 (history-node-make '("q3")))]
         [node-4 (history-node-add! node-1 (history-node-make '("q4")))]
         [node-5 (history-node-add! node-1 (history-node-make '("q5")))]
         [node-6 (history-node-add! node-2 (history-node-make '("q6")))]
         ; rank 3
         [node-7 (history-node-add! node-3 (history-node-make '("q7")))]
         [node-8 (history-node-add! node-3 (history-node-make '("q8")))]
         [node-9 (history-node-add! node-4 (history-node-make '("q9")))]
         [node-10 (history-node-add! node-5 (history-node-make '("q10")))]
         [node-11 (history-node-add! node-6 (history-node-make '("q11")))]
         [node-12 (history-node-add! node-6 (history-node-make '("q12")))]
         ; rank 4
         [node-13 (history-node-add! node-10 (history-node-make '("q13")))]
         [node-14 (history-node-add! node-12 (history-node-make '("q14")))]
         )
    history))

; Make a deterministic history
(define (history-make-test5)
  (let* ([config (list "q0")]
         [history (history-create config)]
         ; rank 1
         [node-1 (history-node-add! history (history-node-make '("q0a")))]
         ; rank 2
         [node-2 (history-node-add! node-1 (history-node-make '("q1")))]
         ; rank 3
         [node-3 (history-node-add! node-2 (history-node-make '("q1a")))]
         ; rank 4
         [node-4 (history-node-add! node-3 (history-node-make '("q2")))]
         ; rank 5
         [node-5 (history-node-add! node-4 (history-node-make '("q2a")))]
         )
    history))

; Test function for history->string
(define (c->s c)
  (string-append "K" (car c))) ; The K is just testable

(define history-tests
  (test-suite
   "history tests"

   (test-case
    "Test building a simple history"
    (let ([history (history-make-test0)])
      ; (printf "~s\n" history)
      (check-equal? (history-node-config history) (list "q0"))
      (let* ([kids (history-node-get-children history)]
             [kids-configs (for/list ([i kids])
                             (history-node-config i))])
        (for ([c kids-configs])
          ; (printf "c=~s\n" c)
          (check-true (or (equal? c (list "q0"))
                          (equal? c (list "q1"))
                          (equal? c (list "q2")))))
      ))
    )
   
   (test-case
    "Test building a deeper history"
    (let ([history (history-make-test1)])
      ; (printf "~s\n" history)
      (check-equal? (history-node-config history) (list "q0"))
      (let* ([kids1 (history-node-get-children history)]
             [kids1-configs (for/list ([i kids1])
                             (history-node-config i))])
        (for ([c kids1-configs])
          ; (printf "c=~s\n" c)
          (check-true (or (equal? c (list "q1"))
                          (equal? c (list "q2")))))
        (for ([k1 kids1])
          (let* ([k1-children (history-node-get-children k1)])
            (for ([k2 k1-children])
              (when (equal? (history-node-config k1) '("q1"))
                (check-equal? (history-node-config k2) '("q3"))))))
        ))
    )

   (test-case
    "Test depth first traversal"
    (let* ([acc ""] ; accumulator
           [tack-fcn (lambda (x y) (set!
                                    acc
                                    (string-append
                                     acc
                                     (~a (car (history-node-config x))))))])
      ; side effect: change acc
      (history-traverse-dfs (history-make-test0)
                            0
                            tack-fcn) ; side effect: change acc
      (check-true (if (member acc '("q0q1q2" "q0q2q1")) #t #f))
      ; side effect: change acc
      (set! acc "")
      (history-traverse-dfs (history-make-test1)
                            0
                            tack-fcn) ; side effect: change acc
      ; (printf "~s\n" acc)
      (check-true (if (member acc '("q0q1q2q3" "q0q2q3q1")) #t #f))
      ; side effect: change acc
      (set! acc "")
      (history-traverse-dfs (history-make-test2)
                            0
                            tack-fcn) ; side effect: change acc
      ; (printf "~s\n" acc)
      (check-true (if (member acc '("q0q1q3q5q4q6q2"
                                    "q0q1q3q4q6q5q2"
                                    "q0q2q1q3q4q6q5"
                                    "q0q2q1q3q5q4q6")) #t #f))
      ))

   (test-case
    "Test breadth first traversal"
    (let* ([acc ""] ; accumulator
           [tack-fcn (lambda (x y) (set!
                                    acc
                                    (string-append
                                     acc
                                     (~a (car (history-node-config x))))))])
      ; side effect: change acc
      (history-traverse-bfs (history-make-test0)
                            tack-fcn)
      ; (printf "~s\n" acc)
      (check-true (if (member acc '("q0q1q2" "q0q2q1")) #t #f))
      ; side effect: change acc
      (set! acc "")
      (history-traverse-bfs (history-make-test1)
                            tack-fcn)
      ; (printf "~s\n" acc)
      (check-true (if (member acc '("q0q1q2q3" "q0q2q1q3")) #t #f))
      ; side effect: change acc
      (set! acc "")
      (history-traverse-bfs (history-make-test2)
                            tack-fcn)
      ; (printf "~s\n" acc)
      (check-true (if (member acc '("q0q1q2q3q4q5q6"
                                    "q0q1q2q3q5q4q6"
                                    "q0q2q1q3q4q5q6"
                                    "q0q2q1q3q5q4q6")) #t #f))
      ))

   (test-case
    "Test history->string"
    ; simple sample history tree
    (let ([s (history->string (history-make-test0))])
      ; (printf "~s\n" s)
      (check-true (if (member s '("(\"q0\")\n +--(\"q1\")\n +--(\"q2\")"
                                  "(\"q0\")\n +--(\"q2\")\n +--(\"q1\")"))
                      #t #f))
      )
    ; deeper sample history tree
    (let ([s (history->string (history-make-test1))])
      ; (printf "~s\n" s)
      (check-true (if (member s '("(\"q0\")\n +--(\"q1\")\n +--(\"q2\")\n |   +--(\"q3\")"
                                  "(\"q0\")\n +--(\"q2\")\n |   +--(\"q3\")\n +--(\"q1\")"))
                      #t #f))      
      )
;    (let ([s (history->string (history-make-test2))])
;      (printf "~s\n" s)
;      )
    ; determinstic sample history tree, deterministic flag on
    (let ([s (history->string (history-make-test5) #:deterministic #t)])
      ; (printf "~s\n" s)
      (check-true (if (member s '("(\"q0\")\n(\"q1\")\n(\"q2\")"
                                  ))
                      #t #f))      
      )
    ; change the configuation->string function
    (let ([s (history->string (history-make-test0) #:configuration->string c->s)])
      ; (printf "~s\n" s)
      (check-true (if (member s '("Kq0\n +--Kq1\n +--Kq2"
                                  "Kq0\n +--Kq2\n +--Kq1"))
                      #t #f))
      )
    )
   
   
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
    (let* ([line "FINAL 3 4"]) 
      (check-equal? (length (parse-final-states line)) 2)
      (check-equal? (first (parse-final-states line)) 3)
      (check-equal? (second (parse-final-states line)) 4))
    (let* ([line "FINAL 3 4  # test with comment"]) 
      (check-equal? (length (parse-final-states line)) 2)
      (check-equal? (first (parse-final-states line)) 3)
      (check-equal? (second (parse-final-states line)) 4))
    (let* ([line "ACCEPTING 3 4"]) 
      (check-equal? (length (parse-final-states line)) 2)
      (check-equal? (first (parse-final-states line)) 3)
      (check-equal? (second (parse-final-states line)) 4))
    (let* ([line "FINAL 3"]) 
      (check-equal? (length (parse-final-states line)) 1)
      (check-equal? (first (parse-final-states line)) 3))
    (let* ([line "FINAL"]) 
      (check-equal? (length (parse-final-states line)) 0))
    )
   
   (test-case
    "parse-epsilon-transition test"
    (let* ([line "EPSILON 0 1"]
           [m (regexp-match* EPSILON-REGEXP line #:match-select cdr)])
      (check-equal? (length (parse-epsilon-transition line)) 2)
      (check-equal? (first (parse-epsilon-transition line)) 0)
      (check-equal? (second (parse-epsilon-transition line)) 1)
      )
    )

   )) ;; end parse suite and tests


;; ===== Run the tests; comment out ones not being worked-on
(run-tests power-map-tests)
(run-tests delta-tests)
;(run-tests epsilon-tests)
;(run-tests tape-tests)
;(run-tests stack-tests)
;(run-tests history-tests)
;(run-tests machine-tests)
;(run-tests parse-tests)
#lang racket
(require rackunit
         "device.rkt")
(require rackunit/text-ui) ; to run the test suites

;; device-test.rkt
;;
;; Unit tests for device.rkt, from Jim Hefferon's _Theory of Computation_
;; License: GPL 3.0


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
(define stack-making-tests
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



;; ===== Run the tests; comment out ones not being worked-on
; (run-tests delta-tests)
(run-tests tape-tests)
; (run-tests stack-making-tests)
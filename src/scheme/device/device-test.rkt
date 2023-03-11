#lang racket
(require rackunit
         "device.rkt")
(require rackunit/text-ui) ; to run the test suites

;; device-test.rkt
;;
;; Unit tests for device.rkt, from Jim Hefferon's _Theory of Computation_
;; License: GPL 3.0


;; ===== DELTA tests
(define DELTA-tests
  (test-suite
   "initialize and manipulate DELTA"
  
   (test-case
    "Test making DELTA"
    ; (printf "DELTA=~s\n" DELTA)
    (let ([input (list 0 "a")]
          [other-input (list 3 "b")]
          [output (list 1)]
          [other-output (list 2)])
      (make-DELTA)
      (DELTA-set! input output)
      ; (printf "DELTA=~s\n" DELTA)
      (DELTA-set! input other-output)
      ; (printf "DELTA=~s\n" DELTA)
      (DELTA-set! other-input output)
      ; (printf "DELTA=~s\n" DELTA)
      (check-true (set-member? (delta input) output))
      (check-true (set-member? (delta input) other-output))
      (check-true (set-member? (delta other-input) output))
      )
    );; end test-case

   (test-case
    "Test delta function"
    (let ([input (list 0 "a")]
          [other-input (list 3 "b")]
          [output (list 1)])
      (reset-DELTA)
      (DELTA-set! input output)
      (check-true (set-member? (delta input) output))
      (check-equal? (delta other-input) DELTA-NOKEY)
      )
    );; end test-case

   )) ;; end DELTA-tests suite and tests


;; ===== tapestruct tests
(define TAPE-tests
  (test-suite
   "initialize and manipulate TAPE"
  
;   (test-case
;    "Test making TAPE"
;    ; (make-TAPE)
;    ; (printf "TAPE=~s\n" TAPE)
;    (make-tape)
;    (check-equal? (get-tape-right) '())
;    (check-equal? (get-tape-current) " ")
;    (make-tape "a" "b" "B")
;    (check-equal? (get-tape-right) (list "b" "B"))
;    (check-equal? (get-tape-current) "a")
;    ; (printf "TAPE=~s\n" TAPE)
;    );; end test-case
  
;   (test-case
;    "Test trimming tape"
;    (let ([left-tape '(" " " " "b")]
;          [right-tape '("a" " ")])
;      (check-equal? (trim-left-tape left-tape) '("b"))
;      (check-equal? (trim-right-tape right-tape) '("a"))
;      )
;    (let ([left-tape '("B" " " "b")]
;          [right-tape '("a" "B")])
;      (check-equal? (trim-left-tape left-tape) '("b"))
;      (check-equal? (trim-right-tape right-tape) '("a"))
;      )
;    (let ([left-tape '(" " " ")]
;          [right-tape '(" " "B")])
;      (check-equal? (trim-left-tape left-tape) '())
;      (check-equal? (trim-right-tape right-tape) '())
;      )
;    (let ([left-tape '("a" " " "b" " ")]
;          [right-tape '(" " "a" " " "b")])
;      (check-equal? (trim-left-tape left-tape) left-tape)
;      (check-equal? (trim-right-tape right-tape) right-tape)
;      )
;    (make-TAPE)
;    (set-TAPE! '(" " "B" "z") " " '(" "))
;    (trim-tape)
;    (check-equal? (get-tape-left) '("z"))
;    (check-equal? (get-tape-right) '())
;    (check-equal? (get-tape-current) " ")
;    );; end test-case

   (test-case
    "Test moving head against TAPE"
    (make-tape "a" "b" "B")
    (move-head-right)
    (check-equal? (get-tape-left) (list "a"))
    (check-equal? (get-tape-right) (list "B"))
    (check-equal? (get-tape-current) "b")
    (move-head-left)
    (check-equal? (get-tape-left) '())
    (check-equal? (get-tape-right) (list "b" "B"))
    (check-equal? (get-tape-current) "a")
    (make-tape)
    (check-equal? (get-tape-right) '())
    (check-equal? (get-tape-left) '())
    (check-equal? (get-tape-current) " ")
    (move-head-right)
    (trim-tape)
    (check-equal? (get-tape-left) '())
    (check-equal? (get-tape-right) '())
    (check-equal? (get-tape-current) " ")
    (move-head-left)
    (trim-tape)
    (check-equal? (get-tape-left) '())
    (check-equal? (get-tape-right) '())
    (check-equal? (get-tape-current) " ")
    
    ; (printf "TAPE=~s\n" TAPE)
    );; end test-case


   
   )) ;; end TAPE-tests suite and tests




;; ===== Run the tests; comment out ones not being worked-on
; (run-tests DELTA-tests)
(run-tests TAPE-tests)

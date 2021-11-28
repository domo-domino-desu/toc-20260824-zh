;;;; Tests of the code in tm-encoding
#lang racket/base
(require "../prologue/turing-machine.rkt")
(require rackunit
         "tm-encoding.rkt")

;; ============== Some Turing machines
(define TM0 (list (list 2 #\0 #\1 4) (list 1 #\2 LEFT 0)))  ; generic TM
(define TM1 (list (list 2 #\A #\C 4) ))  ; One-instruction TM
(define TM2 '())  ; Empty TM

;; ==== unary strings ====
(test-case
 "unary-string?"
 (check-true (unary-string? "1111") "test generic unary string")
 (check-false (unary-string? "101") "test non-unary string")
 (check-true (unary-string? "1") "test unary string of length one")
 (check-true (unary-string? "") "test unary string of length zero")
 (check-false (unary-string? 3) "argument not a string")
 )

(test-case
 "natural->unary-string"
 (check-equal? (natural->unary-string 3) "111" "generic natural number")
 (check-equal? (natural->unary-string 1) "1" "natural number is 1")
 (check-equal? (natural->unary-string 0) "" "natural number is 0, so get empty string")
)

(test-case
 "unary-string->natural"
 (check-eqv? (unary-string->natural "111") 3 "generic unary string")
 (check-equal? (unary-string->natural "1") 1 "unary string represents 1")
 (check-equal? (unary-string->natural "") 0 "unary string is empty, so represents 0")
 )


;; ======= tests for parts of TM
(test-case
  "state?"
  (check-true (state? 5) "Generic integer is state?")
  (check-true (state? 0) "0 is state?")
  (check-false (state? -1) "-1 is not state?")
  (check-false (state? #\2) "Character is not state?")
 )

(test-case
  "present-symbol?"
  (check-true (present-symbol? #\C) "Generic character is symbol?")
  (check-false (present-symbol? LEFT) "L is not an allowed symbol")
  (check-false (present-symbol? RIGHT) "R is not an allowed symbol")
  (check-false (present-symbol? 0) "integer is not an allowed symbol")
)

(test-case
  "next-action?"
  (check-true (next-action? #\C) "Generic character is a next action")
  (check-true (next-action? LEFT) "L is an allowed next action")
  (check-true (next-action? RIGHT) "R is an allowed next action")
  (check-false (next-action? 0) "integer is not an allowed next action")
)

(test-case
 "instruction?"
 (check-true (instruction? (list 3 #\a LEFT 4)) "Generic instruction")
 (check-false (instruction? (list 3 LEFT #\a 4)) "If present symbol is LEFT, then not an instruction")
 (check-false (instruction? '()) "Null list is not an instruction")
 )

(test-case
  "and-of-list"
  (check-equal? #t (and-of-list '(#t #t)) "All true's gives true?")
  (check-equal? #f (and-of-list '(#t #t #f)) "Any false results in a false?")
  (check-equal? #t (and-of-list '()) "Null list gives true?")
  (check-equal? #t (and-of-list '(#t)) "Length one list gives the value t?")
  (check-equal? #f (and-of-list '(#f)) "Length one list gives the value f?")
 )

(test-case
  "Turing machine"
  (check-pred TM? (list (list 5 #\a LEFT 5)) "Generic Turing machine OK?")
  (check-pred TM? TM0 "Generic Turing TM0 machine OK?")
  (check-pred TM? TM1 "One-instruction Turing machine OK?")
  (check-pred TM? TM2 "Empty Turing machine OK?")
 )



;; ==== encoding and decoding ====

;; encode-present-state and decode-present-state

(test-case
 "encode-present-state, decode-present-state"
 (check-pred string? (encode-present-state 42) "Is result on generic state number a string?")
 (check-pred string? (encode-present-state 1) "Is result on state number 1 a string?")
 (check-pred unary-string? (encode-present-state 2) "Is the result a unary string?")
 (check-equal? 42 (decode-present-state (encode-present-state 42)) "Does decoding undo encoding on an generic state?")
 (check-equal? 1 (decode-present-state (encode-present-state 1)) "Does decoding undo encoding on state 1?")
 (check-equal? 0 (decode-present-state (encode-present-state 0)) "Does decoding undo encoding on state 0?")
)

;; encode-next-state and decode-next-state
(test-case
 "encode-next-state, decode-next-state"
 (check-pred string? (encode-next-state 42) "Is result on generic state number a string?")
 (check-pred string? (encode-next-state 1) "Is result on state number 1 a string?")
 (check-pred string? (encode-next-state 0) "Is result on state number 0 a string?")
 (check-pred unary-string? (encode-next-state 2) "Is the result a unary string?")
 (check-equal? 42 (decode-next-state (encode-next-state 42)) "Does decoding undo encoding on an generic state?")
 (check-equal? 1 (decode-next-state (encode-next-state 1)) "Does decoding undo encoding on state 1?")
 (check-equal? 0 (decode-next-state (encode-next-state 0)) "Does decoding undo encoding on state 0?")
)

;; encode-present-symbol and decode-present-symbol
(test-case
 "encode-present-symbol, decode-present-symbol"
 (check-pred string? (encode-present-symbol #\A) "Is result on generic symbol a string?")
 (check-pred string? (encode-present-symbol #\a) "Is result on lower case letter symbol a string?")
 (check-pred string? (encode-present-symbol #\B) "Is result on symbol for blank a string?")
 (check-pred string? (encode-present-symbol #\0) "Is result on symbol for a digit a string?")
 (check-pred unary-string? (encode-present-symbol #\A) "Is result a unary string?")
 (check-equal? #f (decode-present-symbol "Z") "Encoding of a symbol should be an integer, so decode should reject others")
 (check-equal? #\A (decode-present-symbol (encode-present-symbol #\A)) "Does decoding undo encoding on an generic char?")
 (check-equal? #\a (decode-present-symbol (encode-present-symbol #\a)) "Does decoding undo encoding on a lower case letter?")
 (check-equal? #\B (decode-present-symbol (encode-present-symbol #\B)) "Does decoding undo encoding on the char for blank?")
 (check-equal? #\0 (decode-present-symbol (encode-present-symbol #\0)) "Does decoding undo encoding on the char for a digit?")
)


;; ======= encode-next-action and decode-next-action
(test-case
 "encode-next-action, decode-next-action"
 (check-pred string? (encode-next-action #\A) "Is result on generic symbol a character?")
 (check-pred string? (encode-next-action #\B) "Is result on symbol for blank a string?")
 (check-pred string? (encode-next-action LEFT) "Is result of encoding LEFT a string?")
 (check-pred string? (encode-next-action RIGHT) "Is result of encoding RIGHT a string?")
 (check-pred unary-string? (encode-next-action #\a) "Is result of encoding a lower-case letter a unary string?")
 (check-pred unary-string? (encode-next-action RIGHT) "Is result of encoding RIGHT a unary string?")
 (check-false (decode-next-action "Z") "Encoding of next-action must be a string, so decode should reject others")
 (check-equal? #\A (decode-next-action (encode-next-action #\A)) "Does decoding undo encoding on an generic char?")
 (check-equal? #\B (decode-next-action (encode-next-action #\B)) "Does decoding undo encoding on the char for blank?")
 (check-equal? LEFT (decode-next-action (encode-next-action LEFT)) "Does decoding undo encoding on the char for LEFT?")
 (check-equal? RIGHT (decode-next-action (encode-next-action RIGHT)) "Does decoding undo encoding on the char for RIGHT?")
)



;; encode-TM-instruction, decode-TM-instruction
(test-case
 "encode-TM-instruction, decode-TM-instruction"
 (check-pred string? (encode-TM-instruction '(2 #\A #\C 4)) "Is the result on a generic instruction a string?")
 (check-pred string? (encode-TM-instruction (list 2 #\A LEFT 4)) "Is the result on an instruction using LEFT a string?")
 (check-pred string? (encode-TM-instruction (list 2 #\A RIGHT 4)) "Is the result on an instruction using RIGHT a string?")
 (check-equal? (list 2 #\A #\C 4) (decode-TM-instruction (encode-TM-instruction (list 2 #\A #\C 4))) "Does decoding undo encoding on a generic instruction?")
 (check-equal? (list 2 #\A LEFT 4) (decode-TM-instruction (encode-TM-instruction (list 2 #\A LEFT 4))) "Does decoding undo encoding on an instruction using LEFT?")
 (check-equal? (list 2 #\A LEFT 0) (decode-TM-instruction (encode-TM-instruction (list 2 #\A LEFT 0))) "Does decoding undo encoding on an instruction ending in state 0?")
)

#|

;; encode-TM and decode-TM
(encode-TM TM0) (newline)
;(decode-TM 0)
(test-case
 "encode-TM, decode-TM"
(check-pred string? (encode-TM TM0) "Is the result on a generic TM a string?")
(check-pred string? (encode-TM TM1) "Is the result on a single-instruction TM a string?")
(check-pred string? (encode-TM TM2) "Is the result on the empty TM a string?")
(check-equal? TM0 (decode-TM (encode-TM TM0)) "Does decoding undo encoding on a generic machine?")
(check-equal? TM1 (decode-TM (encode-TM TM1)) "Does decoding undo encoding on a one-instruction machine?")
(check-equal? TM2 (decode-TM (encode-TM TM2)) "Does decoding undo encoding on the empty machine?")
)

|#
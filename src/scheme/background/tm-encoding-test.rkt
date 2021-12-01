;;;; Tests of the code in tm-encoding
#lang racket/base
(require "../prologue/turing-machine.rkt")
(require rackunit
         "tm-encoding.rkt")

;; ============== Some Turing machines
(define TM0 (list (list 2 #\0 #\1 4) (list 1 #\2 LEFT 0)))  ; generic TM
(define TM1 (list (list 2 #\A #\C 4) ))  ; One-instruction TM
(define TM2 '())  ; Empty TM
(define TM3 (list (list 0 #\0 #\1 0) (list 0 #\2 LEFT 0)))  ; TM with state q0 a lot


;; ==== extra unary strings ====
(test-case
 "extra-unary-string?"
 (check-true (extra-unary-string? "1111") "test generic unary string")
 (check-false (extra-unary-string? "101") "test non-unary string")
 (check-true (extra-unary-string? "1") "test unary string of length one")
 (check-false (extra-unary-string? "") "test unary string of length zero")
 (check-false (extra-unary-string? 3) "argument not a string")
 )

(test-case
 "natural->extra-unary-string"
 (check-equal? (natural->extra-unary-string 3) "1111" "generic natural number")
 (check-equal? (natural->extra-unary-string 1) "11" "natural number is 1")
 (check-equal? (natural->extra-unary-string 0) "1" "natural number is 0")
)

(test-case
 "extra-unary-string->natural"
 (check-eqv? (extra-unary-string->natural "1114") 3 "generic unary string")
 (check-equal? (extra-unary-string->natural "11") 1 "unary string represents 1")
 (check-equal? (extra-unary-string->natural "1") 0 "unary string is empty, so represents 0")
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

;; encode-present-state-extra and decode-present-state-extra

(test-case
 "encode-present-state-extra, decode-present-state-extra"
 (check-pred string? (encode-present-state-extra 42) "Is result on generic state number a string?")
 (check-pred string? (encode-present-state-extra 1) "Is result on state number 1 a string?")
 (check-pred extra-unary-string? (encode-present-state-extra 2) "Is the result a unary string?")
 (check-equal? 42 (decode-present-state-extra (encode-present-state-extra 42)) "Does decoding undo encoding on an generic state?")
 (check-equal? 1 (decode-present-state-extra (encode-present-state-extra 1)) "Does decoding undo encoding on state 1?")
 (check-equal? 0 (decode-present-state-extra (encode-present-state-extra 0)) "Does decoding undo encoding on state 0?")
)

;; encode-next-state-extra and decode-next-state-extra
(test-case
 "encode-next-state-extra, decode-next-state-extra"
 (check-pred string? (encode-next-state-extra 42) "Is result on generic state number a string?")
 (check-pred string? (encode-next-state-extra 1) "Is result on state number 1 a string?")
 (check-pred string? (encode-next-state-extra 0) "Is result on state number 0 a string?")
 (check-pred extra-unary-string? (encode-next-state-extra 2) "Is the result a unary string?")
 (check-equal? 42 (decode-next-state-extra (encode-next-state-extra 42)) "Does decoding undo encoding on an generic state?")
 (check-equal? 1 (decode-next-state-extra (encode-next-state-extra 1)) "Does decoding undo encoding on state 1?")
 (check-equal? 0 (decode-next-state-extra (encode-next-state-extra 0)) "Does decoding undo encoding on state 0?")
)

;; encode-present-symbol-extra and decode-present-symbol-extra
(test-case
 "encode-present-symbol-extra, decode-present-symbol-extra"
 (check-pred string? (encode-present-symbol-extra #\A) "Is result on generic symbol a string?")
 (check-pred string? (encode-present-symbol-extra #\a) "Is result on lower case letter symbol a string?")
 (check-pred string? (encode-present-symbol-extra #\B) "Is result on symbol for blank a string?")
 (check-pred string? (encode-present-symbol-extra #\0) "Is result on symbol for a digit a string?")
 (check-pred extra-unary-string? (encode-present-symbol-extra #\A) "Is result a unary string?")
 (check-equal? #f (decode-present-symbol-extra "Z") "Encoding of a symbol should be an integer, so decode should reject others")
 (check-equal? #\A (decode-present-symbol-extra (encode-present-symbol-extra #\A)) "Does decoding undo encoding on an generic char?")
 (check-equal? #\a (decode-present-symbol-extra (encode-present-symbol-extra #\a)) "Does decoding undo encoding on a lower case letter?")
 (check-equal? #\B (decode-present-symbol-extra (encode-present-symbol-extra #\B)) "Does decoding undo encoding on the char for blank?")
 (check-equal? #\0 (decode-present-symbol-extra (encode-present-symbol-extra #\0)) "Does decoding undo encoding on the char for a digit?")
)


;; ======= encode-next-action-extra and decode-next-action-extra
(test-case
 "encode-next-action-extra, decode-next-action-extra"
 (check-pred string? (encode-next-action-extra #\A) "Is result on generic symbol a character?")
 (check-pred string? (encode-next-action-extra #\B) "Is result on symbol for blank a string?")
 (check-pred string? (encode-next-action-extra LEFT) "Is result of encoding LEFT a string?")
 (check-pred string? (encode-next-action-extra RIGHT) "Is result of encoding RIGHT a string?")
 (check-pred extra-unary-string? (encode-next-action-extra #\a) "Is result of encoding a lower-case letter a unary string?")
 (check-pred extra-unary-string? (encode-next-action-extra RIGHT) "Is result of encoding RIGHT a unary string?")
 (check-false (decode-next-action-extra "Z") "Encoding of next-action must be a string, so decode should reject others")
 (check-equal? #\A (decode-next-action-extra (encode-next-action-extra #\A)) "Does decoding undo encoding on an generic char?")
 (check-equal? #\B (decode-next-action-extra (encode-next-action-extra #\B)) "Does decoding undo encoding on the char for blank?")
 (check-equal? LEFT (decode-next-action-extra (encode-next-action-extra LEFT)) "Does decoding undo encoding on the char for LEFT?")
 (check-equal? RIGHT (decode-next-action-extra (encode-next-action-extra RIGHT)) "Does decoding undo encoding on the char for RIGHT?")
)



;; encode-TM-instruction-extra, decode-TM-instruction-extra
; (encode-TM-instruction-extra (list 0 #\A #\B 0))
(test-case
 "decode-TM-instruction-extra"  ; a problem is an instruction like <q2,a,b,q0> or <q0,a,b,q1> because it starts with B
 (check-equal? (list 2 #\A #\B 0) (decode-TM-instruction-extra "111B1111111111111111111B11111111111111111111B1") "Does <q2,A,B,q0> decode?")
 (check-equal? (list 0 #\A #\B 2) (decode-TM-instruction-extra "1B1111111111111111111B11111111111111111111B111") "Does <q0,A,B,q2> decode?")
 (check-equal? (list 0 #\A #\B 0) (decode-TM-instruction-extra "1B1111111111111111111B11111111111111111111B1") "Does <q0,A,B,q0> decode?")
 )

(test-case
 "encode-TM-instruction-extra, decode-TM-instruction-extra"
 (check-pred string? (encode-TM-instruction-extra '(2 #\A #\C 4)) "Is the result on a generic instruction a string?")
 (check-pred string? (encode-TM-instruction-extra (list 2 #\A LEFT 4)) "Is the result on an instruction using LEFT a string?")
 (check-pred string? (encode-TM-instruction-extra (list 2 #\A RIGHT 4)) "Is the result on an instruction using RIGHT a string?")
 (check-equal? (list 2 #\A #\C 4) (decode-TM-instruction-extra (encode-TM-instruction-extra (list 2 #\A #\C 4))) "Does decoding undo encoding on a generic instruction?")
 (check-equal? (list 2 #\A LEFT 4) (decode-TM-instruction-extra (encode-TM-instruction-extra (list 2 #\A LEFT 4))) "Instruction using LEFT?")
 (check-equal? (list 2 #\A LEFT 0) (decode-TM-instruction-extra (encode-TM-instruction-extra (list 2 #\A LEFT 0))) "Instruction ending in state 0?")
)


;; encode-TM-extra and decode-TM-extra
;(encode-TM-extra TM0) (newline)
;(decode-TM-extra 0)
(test-case
 "encode-TM-extra, decode-TM-extra"
(check-pred string? (encode-TM-extra TM0) "Is the result on a generic TM a string?")
(check-pred string? (encode-TM-extra TM1) "Is the result on a single-instruction TM a string?")
(check-pred string? (encode-TM-extra TM2) "Is the result on the empty TM a string?")
(check-equal? TM0 (decode-TM-extra (encode-TM-extra TM0)) "Does decoding undo encoding on a generic machine?")
(check-equal? TM1 (decode-TM-extra (encode-TM-extra TM1)) "Does decoding undo encoding on a one-instruction machine?")
(check-equal? TM2 (decode-TM-extra (encode-TM-extra TM2)) "Does decoding undo encoding on the empty machine?")
(check-equal? TM3 (decode-TM-extra (encode-TM-extra TM3)) "Does decoding undo encoding on machine with lots of q0's?")
)

#|

|#
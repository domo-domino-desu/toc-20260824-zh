;;;; Tests of the code in tm-encodinig
#lang racket/base
(require rackunit
         "tm-encoding.rkt")

;; ======= encode-present-state and decode-present-state
(test-case
 "present-state"
 (check-pred string? (encode-present-state 42) "Is result on generic state number a string?")
 (check-pred string? (encode-present-state 1) "Is result on state number 1 a string?")
 (check-pred string? (encode-present-state 0) "Is result on state number 0 a string?")
 (check-equal? 42 (decode-present-state (encode-present-state 42)) "Does decoding undo encoding on an generic state?")
 (check-equal? 1 (decode-present-state (encode-present-state 1)) "Does decoding undo encoding on state 1?")
 (check-equal? 0 (decode-present-state (encode-present-state 0)) "Does decoding undo encoding on state 0?")
)


;; ======= encode-next-state and decode-next-state
(test-case
 "next-state"
 (check-pred string? (encode-next-state 42) "Is result on generic state number a string?")
 (check-pred string? (encode-next-state 1) "Is result on state number 1 a string?")
 (check-pred string? (encode-next-state 0) "Is result on state number 0 a string?")
 (check-equal? 42 (decode-next-state (encode-next-state 42)) "Does decoding undo encoding on an generic state?")
 (check-equal? 1 (decode-next-state (encode-next-state 1)) "Does decoding undo encoding on state 1?")
 (check-equal? 0 (decode-next-state (encode-next-state 0)) "Does decoding undo encoding on state 0?")
)


;; ======= encode-present-symbol and decode-present-symbol
(test-case
 "present-symbol"
 (check-pred string? (encode-present-symbol #\A) "Is result on generic symbol a string?")
 (check-pred string? (encode-present-symbol #\B) "Is result on symbol for blank a string?")
 (check-pred string? (encode-present-symbol #\0) "Is result on symbol for a digit?")
 (check-equal? #\A (decode-present-symbol (encode-present-symbol #\A)) "Does decoding undo encoding on an generic char?")
 (check-equal? #\B (decode-present-symbol (encode-present-symbol #\B)) "Does decoding undo encoding on the char for blank?")
 (check-equal? #\0 (decode-present-symbol (encode-present-symbol #\0)) "Does decoding undo encoding on the char for a digit?")
)


;; ======= encode-next-action and decode-next-action
(test-case
 "next-action"
 (check-pred string? (encode-next-action #\A) "Is result on generic symbol a character?")
 (check-pred string? (encode-next-action #\B) "Is result on symbol for blank a string?")
 (check-pred string? (encode-next-action LEFT) "Is result of encoding LEFT a string?")
 (check-pred string? (encode-next-action #\B) "Is result of encoding RIGHT a string?")
 (check-equal? #\A (decode-next-action (encode-next-action #\A)) "Does decoding undo encoding on an generic char?")
 (check-equal? #\B (decode-next-action (encode-next-action #\B)) "Does decoding undo encoding on the char for blank?")
 (check-equal? LEFT (decode-next-action (encode-next-action LEFT)) "Does decoding undo encoding on the char for LEFT?")
 (check-equal? RIGHT (decode-next-action (encode-next-action RIGHT)) "Does decoding undo encoding on the char for RIGHT?")
)


;; ======= encode-TM-instruction and decode-TM-instruction
(test-case
 "TM-instruction"
 (check-pred string? (encode-TM-instruction '(2 #\A #\C 4)) "Is the result on a generic instruction a string?")
 (check-pred string? (encode-TM-instruction (list 2 #\A LEFT 4)) "Is the result on an instruction using LEFT a string?")
 (check-pred string? (encode-TM-instruction (list 2 #\A RIGHT 4)) "Is the result on an instruction using RIGHT a string?")
 (check-equal? '(2 #\A #\C 4) (decode-TM-instruction (encode-TM-instruction '(2 #\A #\C 4))) "Does decoding undo encoding on an generic instruction?")
 (check-equal? (list 2 #\A LEFT 4) (decode-TM-instruction (encode-TM-instruction (list 2 #\A LEFT 4))) "Does decoding undo encoding on an instruction using LEFT?")
)


;; ======= encode-TM and decode-TM
(define TM0 (list '(2 #\A #\C 4) (list 1 #\B LEFT 0)))
(encode-TM TM0)
(define TM1 '('(2 #\A #\C 4)) )
(define TM2 '())
(test-case
 "TM-instruction"
; (check-pred number? (encode-TM TM0) "Is the result on a generic TM an integer?")
 ; (check-pred string? (encode-TM TM1) "Is the result on a single-instruction TM an integer?")
; (check-pred string? (encode-TM-instruction (list 2 #\A RIGHT 4)) "Is the result on an instruction using RIGHT a string?")
; (check-equal? '(2 #\A #\C 4) (decode-TM-instruction (encode-TM-instruction '(2 #\A #\C 4))) "Does decoding undo encoding on an generic instruction?")
; (check-equal? (list 2 #\A LEFT 4) (decode-TM-instruction (encode-TM-instruction (list 2 #\A LEFT 4))) "Does decoding undo encoding on an instruction using LEFT?")
)

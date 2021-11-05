#lang racket
(define SEPARATOR "9")  ; inside of an instruction's representation
(define INTER-INSTRUCTION-SEPARATOR "99")  ; between instructions

(provide SEPARATOR
         INTER-INSTRUCTION-SEPARATOR)

(define LEFT #\L)
(define RIGHT #\R)

(provide LEFT
         RIGHT)

(define BASE-FOR-NUM-ENCODING 2) ; must be 2, 3, 4, ... 8
(define BASE-FOR-CHAR-ENCODING 8) ; must be 2, 3, 4, ... 8

(provide BASE-FOR-NUM-ENCODING
         BASE-FOR-CHAR-ENCODING)

;; encode-present-state  input positive integer, output encoding as string
(define (encode-present-state q)
  (number->string q BASE-FOR-NUM-ENCODING))

(define (decode-present-state s)
  (string->number s BASE-FOR-NUM-ENCODING))

(provide encode-present-state
         decode-present-state)

;; encode-next-state  input positive integer, output encoding as string
(define (encode-next-state q)
  (number->string q BASE-FOR-NUM-ENCODING))

(define (decode-next-state s)
  (string->number s BASE-FOR-NUM-ENCODING))

(provide encode-next-state
         decode-next-state)

;; encode-present-symbol  input character, output encoding as string
(define (encode-present-symbol s)
  (number->string (char->integer s) BASE-FOR-CHAR-ENCODING))

(define (decode-present-symbol s)
  (integer->char (string->number s BASE-FOR-CHAR-ENCODING)))

(provide encode-present-symbol
         decode-present-symbol)

;; encode-next-action  input a character, output encoding as string representation of a number
;;   (note that the number avoids the digit 9, as it is the separator)
(define (encode-next-action s)
  (number->string (char->integer s) BASE-FOR-CHAR-ENCODING)) 

;; decode-next-action  input string representation of a number, output a character
(define (decode-next-action s)
  (integer->char (string->number s BASE-FOR-CHAR-ENCODING)))

(provide encode-next-action
         decode-next-action)

;; encode-TM-instruction  input list of four, output encoding as string
;; todo: ensure no leading 0's
(define (encode-TM-instruction inst)
  (let([present-state (first inst)]
       [present-symbol (second inst)]
       [next-action (third inst)]
       [next-state (fourth inst)])
    (string-append SEPARATOR (encode-present-state present-state)  ; leading sep so no leading 0
                   SEPARATOR (encode-present-symbol present-symbol)
                   SEPARATOR (encode-next-action next-action)
                   SEPARATOR (encode-next-state next-state))))

;; decode-TM-instruction  input string encoding instruction, return instruction (or empyty list if syntax doesn't match)
(define (decode-TM-instruction s)
  (let([split-string (string-split s SEPARATOR)])
    (if (not (= 4 (length split-string)))
        '()
        (list (decode-present-state (first split-string))
              (decode-present-symbol (second split-string))
              (decode-next-action (third split-string))
              (decode-next-state (fourth split-string))))))

(provide encode-TM-instruction
         decode-TM-instruction)

;; encode-TM  input list of instructions, return integer encoding
;; TODO: case of null machine
(define (encode-TM tm)
  (display tm) (newline)
  (display (map encode-TM-instruction tm)) (newline)
  (string->number (string-join (map encode-TM-instruction tm))))

;; decode-TM  input integer encoding of a Turing machine, return list representing that machine
(define (decode-TM s)
  (let ([encoded-instructions (string-split (number->string s) INTER-INSTRUCTION-SEPARATOR)])
    ; (display encoded-instructions)
    (append (map decode-TM-instruction encoded-instructions))))

(provide encode-TM
         decode-TM)
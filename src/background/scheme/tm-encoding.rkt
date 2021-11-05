#lang racket
(define SEPARATOR "9")
(define INTER-INSTRUCTION-SEPARATOR "99")
;; (define BLANK-CODE "8")  ; looks a bit like a B
;; (define LEFT "7")
;; (define RIGHT "6")

(define BASE-FOR-NUM-ENCODING 2) ; must be 2, 3, 4, ... 8
(define BASE-FOR-CHAR-ENCODING 8) ; must be 2, 3, 4, ... 8

;; encode-present-state  input positive integer, output encoding as string
(define (encode-present-state q)
  (number->string q BASE-FOR-NUM-ENCODING))

(define (decode-present-state s)
  (string->number s BASE-FOR-NUM-ENCODING))

;; encode-next-state  input positive integer, output encoding as string
(define (encode-next-state q)
  (number->string q BASE-FOR-NUM-ENCODING))

(define (decode-next-state s)
  (string->number s BASE-FOR-NUM-ENCODING))

;; encode-present-symbol  input character, output encoding as string
(define (encode-present-symbol s)
  (number->string (char->integer s) BASE-FOR-CHAR-ENCODING))

(define (decode-present-symbol s)
  (integer->char (string->number s BASE-FOR-CHAR-ENCODING)))

;; encode-next-action  input character or L or R, output encoding as string
(define (encode-next-action s)
  (number->string (char->integer s) BASE-FOR-CHAR-ENCODING))

(define (decode-next-action s)
  (integer->char (string->number s BASE-FOR-CHAR-ENCODING)))

;; encode-TM-instruction  input list of four, output encoding as string
(define (encode-TM-instruction inst)
  (let([present-state (first inst)]
       [present-symbol (second inst)]
       [next-action (third inst)]
       [next-state (fourth inst)])
    (display present-state)
    (string-append (encode-present-state present-state)
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

;; encode-TM  input list of instructions, return string encoding
;; TODO: case of null machine
(define (encode-TM tm)
  (string-join (map encode-TM-instruction tm)))

;; decode-TM  input string encoding of a Turing machine, return list representing that machine
(define (decode-TM s)
  (let ([encoded-instructions (string-split s INTER-INSTRUCTION-SEPARATOR)])
    (append (map decode-TM-instruction encoded-instructions))))
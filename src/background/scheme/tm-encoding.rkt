#lang racket
(define SEPARATOR "9")
;; (define BLANK-CODE "8")  ; looks a bit like a B
;; (define LEFT "7")
;; (define RIGHT "6")

(define BASE-FOR-NUM-ENCODING 2) ; must be 2, 3, 4, ... 8
(define BASE-FOR-CHAR-ENCODING 2) ; must be 2, 3, 4, ... 8

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

;; encode-TM-instruction input list of four, output encoding as string
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


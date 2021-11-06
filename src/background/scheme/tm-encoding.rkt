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

;; test for parts of instructions, for instructions, and for TM
(define (state? v)
  (exact-nonnegative-integer? v))
(define (present-symbol? v)
  (if (not (char? v))
      #f
      (and (not (eqv? v LEFT))
           (not (eqv? v RIGHT)))))
(define (next-action? v)
  (char? v))

(define (instruction? v)
  (and (list? v)
       (= 4 (length v))
       (state? (first v))
       (present-symbol? (second v))
       (next-action? (third v))
       (state? (fourth v))))

;; and-of-list  apply and to the list v
;;   (for some reason, (apply + '(1 2))) works but (apply and '(#t #f)) does not.  A wart, for sure.
(define (and-of-list v)
  (if (null? v)
      #t
      (and (car v)
           (and-of-list (cdr v)))))

(define (TM? v)
  (if (not (list? v))
      #f
      (let ([instruction-results (map instruction? v)])
        (display "instruction first?") (display (instruction? (first v))) (newline)
        (display "instruction first first?") (display (first (first v))) (display (state? (first (first v)))) (newline)
        (display "instruction first second?") (display (second (first v))) (display (present-symbol? (second (first v)))) (newline)
        (display "instruction first third?") (display (third (first v))) (display (next-action? (third (first v)))) (newline)
        (display "instruction-results") (display instruction-results) (newline) 
        (and-of-list instruction-results))))

(provide state?
         present-symbol?
         next-action?
         instruction?
         TM?
         and-of-list)

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
(define (encode-TM tm)
  (if (null? tm)
      0 
      (string->number (string-join (map encode-TM-instruction tm) INTER-INSTRUCTION-SEPARATOR))))

;; decode-TM  input integer encoding of a Turing machine, return list representing that machine
(define (decode-TM s)
  (let ([encoded-instructions (string-split (number->string s) INTER-INSTRUCTION-SEPARATOR)])
    ;(display "encoded-instructions ")(display (string-join encoded-instructions)) (newline)
    ;(display "map decode-TM-instruction: ")(display (map decode-TM-instruction encoded-instructions))(newline)
    (with-handlers ([exn?
                     (lambda (exn) "MMM")])
      (append (map decode-TM-instruction encoded-instructions)))))

(provide encode-TM
         decode-TM)

;;;; TODO: every number that does not work for decode-TM must return the null machine.
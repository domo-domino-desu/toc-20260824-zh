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

(define EMPTY-TURING_MACHINE '())

(provide EMPTY-TURING_MACHINE)

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
  (display "TM? call ")(display v)(newline)
  (if (not (list? v))
      #f
      (let ([instruction-results (map instruction? v)])
        (display "TM? instruction first first?") (display (first (first v))) (display (state? (first (first v)))) (newline)
        (display "TM? instruction first second?") (display (second (first v))) (display (present-symbol? (second (first v)))) (newline)
        (display "TM? instruction first third?") (display (third (first v))) (display (next-action? (third (first v)))) (newline)
        (display "TM? instruction first fourth?") (display (fourth (first v))) (display (state? (fourth (first v)))) (newline)
        (display "TM? net: instruction first?") (display (instruction? (first v))) (newline)
        (display "TM? net: instruction-results") (display instruction-results) (newline) 
        (display "TM? result ") (display (and-of-list instruction-results)) (newline)
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

;; decode-present-state input a string, output natural number
;;  (if string is not suitable, output #f)
(define (decode-present-state s)
  (string->number s BASE-FOR-NUM-ENCODING))

(provide encode-present-state
         decode-present-state)

;; encode-next-state  input positive integer, output encoding as string
(define (encode-next-state q)
  (number->string q BASE-FOR-NUM-ENCODING))

;; decode-next-state input a string, output natural number
;;  (if string is not suitable, output #f)
(define (decode-next-state s)
  (string->number s BASE-FOR-NUM-ENCODING))

(provide encode-next-state
         decode-next-state)

;; encode-present-symbol  input character, output encoding as string
(define (encode-present-symbol s)
  (number->string (char->integer s) BASE-FOR-CHAR-ENCODING))

;; decode-present-symbol input a string, output character
;;  (if string is not suitable, output #f, but no check to avoid L or R)
(define (decode-present-symbol s)
  (if (= 0 (string-length s))
      #f
      (let ([char-code (string->number s BASE-FOR-CHAR-ENCODING)])
        (if (or (false? char-code)
                (>= 0 char-code))
            #f
            (integer->char char-code)))))

(provide encode-present-symbol
         decode-present-symbol)

;; encode-next-action  input a character, output encoding as string representation of a number
;;   (note that the number avoids the digit 9, as it is the separator)
(define (encode-next-action s)
  (number->string (char->integer s) BASE-FOR-CHAR-ENCODING)) 

;; decode-next-action  input a string, output character
;;  (if string is not suitable, output #f)
(define (decode-next-action s)
  (if (= 0 (string-length s))
      #f
      (let ([char-code (string->number s BASE-FOR-CHAR-ENCODING)])
        (if (or (false? char-code)
                (>= 0 char-code))
            #f
            (integer->char char-code)))))

(provide encode-next-action
         decode-next-action)

;; encode-TM-instruction  input list of four, output encoding as string
;;   Ensures no leading 0's, so full number is retained
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
  (let([split-string (string-split s SEPARATOR)])  ; split-string consists of four strings
    (if (not (= 4 (length split-string)))
        #f
        (let ([this-state (decode-present-state (first split-string))]
              [this-input (decode-present-symbol (second split-string))]
              [next-action (decode-next-action (third split-string))]
              [next-state (decode-next-state (fourth split-string))])
          (if (not (and this-state this-input next-action next-state)) ; any fail to decode?
              #f
              (list this-state this-input next-action next-state))))))

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
    (let ([list-of-instructions (map decode-TM-instruction encoded-instructions)])
      (if (not (and-of-list list-of-instructions))
          EMPTY-TURING_MACHINE                                 ;
          (append list-of-instructions)))))

(provide encode-TM
         decode-TM)

#lang racket
(require "../prologue/turing-machine.rkt")

(define SEPARATOR BLANK)            ; inside of an instruction's representation
(define INTER-INSTRUCTION-SEPARATOR (string BLANK BLANK))  ; between instructions

(provide SEPARATOR
         INTER-INSTRUCTION-SEPARATOR)

;; Characters in the alphabet are represented with a unary string.  If we used their
;; Unicode char point, that would be very hard to read.  Instead, we find the difference
;; between character point of some lowest character and the one we want.  So basically,
;; use a characer here that is strictly below anything you will use.
(define CHAR-POINT-OF-LOWEST-CHAR
  (char->integer #\/))   ; note that / is one below #\0, so we can use digits, upper case letters, or lower case

(provide CHAR-POINT-OF-LOWEST-CHAR)

(define EMPTY-TURING_MACHINE '())

(provide EMPTY-TURING_MACHINE)


;; == unary strings ====================

;; unary-string?  Test whether a string is the unary representation of a number
(define (unary-string? s)
  (define (unary-string-helper? charlist)
    (if (null? charlist)
        #t
        (and (eqv? STROKE (car charlist))
             (unary-string-helper? (cdr charlist)))))
  (cond [(not (string? s)) #f]
        [(null? s) #t]
        [else (unary-string-helper? (string->list s))]))

;; natural->unary-string  Convert a natural number to unary encoded string
;;  n  Natural number (n=0 is OK)
(define (natural->unary-string n)
  (make-string n STROKE))

;; unary-string->natural  Convert a unary string to the natural number it represents 
(define (unary-string->natural s)
  (string-length s))

(provide unary-string?
         natural->unary-string
         unary-string->natural)


;; == test for parts of instructions, for instructions, and for TM  ===========

;; state?  Test whether the argument is a possible state
;;  Note that it does not check membership in the actual set of states for this machine
(define (state? v)
  (exact-nonnegative-integer? v))

;; present-symbol?  Test whether the argument is a possible present symbol
;;  Note that it does not check whether the argument is in the alphabet, but
;;  it does reject L or R
(define (present-symbol? v)  
  (if (not (char? v))
      #f
      (and (not (eqv? v LEFT))
           (not (eqv? v RIGHT)))))

;; next-action?  Test whether the argument is a possible next-action (a char)
(define (next-action? v)
  (char? v))

;; instruction? Test whether the argument is a possible instruction, a four-tuple
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

;; TM?  Test whether the argument is a Turing machine, a list of instructions
(define (TM? v [verbose #f])
  (if (not (list? v))
      #f
      (let ([instruction-results (map instruction? v)])
        (when verbose
            (begin
              (display "TM? instruction first first?") (display (first (first v))) (display (state? (first (first v)))) (newline)
              (display "TM? instruction first second?") (display (second (first v))) (display (present-symbol? (second (first v)))) (newline)
              (display "TM? instruction first third?") (display (third (first v))) (display (next-action? (third (first v)))) (newline)
              (display "TM? instruction first fourth?") (display (fourth (first v))) (display (state? (fourth (first v)))) (newline)
              (display "TM? net: instruction first?") (display (instruction? (first v))) (newline)
              (display "TM? net: instruction-results") (display instruction-results) (newline) 
              (display "TM? result ") (display (and-of-list instruction-results)) (newline)))
        (and-of-list instruction-results))))

(provide state?
         present-symbol?
         next-action?
         instruction?
         TM?
         and-of-list)


;; ==== encodings and decodings ====

;; encode-present-state  input natural number, output encoding as string
(define (encode-present-state q)
  (natural->unary-string q))

;; decode-present-state input a unary-string, output natural number
;;  (if string is not suitable, output #f)
(define (decode-present-state s)
  (if (not (unary-string? s))
      #f
      (unary-string->natural s)))

(provide encode-present-state
         decode-present-state)

;; encode-next-state  input positive integer, output encoding as string
(define (encode-next-state q)
  (natural->unary-string q))

;; decode-next-state input a string, output natural number
;;  (if string is not suitable, output #f)
(define (decode-next-state s)
  (if (not (unary-string? s))
      #f
      (unary-string->natural s)))

(provide encode-next-state
         decode-next-state)

;; encode-present-symbol  input a present-symbol, output encoding as unary-string
(define (encode-present-symbol ch)
  (natural->unary-string (- (char->integer ch)
                            CHAR-POINT-OF-LOWEST-CHAR)))

;; decode-present-symbol input a unary-string, output a present symbol
;;  (if string is not suitable, output #f)
(define (decode-present-symbol s)
  (if (not (unary-string? s))
      #f
      (let* ([char-point (+ (unary-string->natural s)
                            CHAR-POINT-OF-LOWEST-CHAR)]
             [ch (integer->char char-point)])
        (if (not (present-symbol? ch))
            #f
            ch))))

(provide encode-present-symbol
         decode-present-symbol)

;; encode-next-action  Input a character, output encoding as unary string
(define (encode-next-action s)
  (natural->unary-string (- (char->integer s)
                            CHAR-POINT-OF-LOWEST-CHAR)))

;; decode-next-action  input a unary string, output next-action
;;   If input string not suitable, return #f
(define (decode-next-action s)
  (if (not (unary-string? s))
      #f
      (let* ([char-point (+ (unary-string->natural s)
                            CHAR-POINT-OF-LOWEST-CHAR)]
             [ch (integer->char char-point)])
        (if (not (next-action? ch))
            #f
            ch))))

(provide encode-next-action
         decode-next-action)

;; encode-TM-instruction  Input instruction, output encoding as string
(define (encode-TM-instruction inst)
  (let([present-state (first inst)]
       [present-symbol (second inst)]
       [next-action (third inst)]
       [next-state (fourth inst)]
       [separator-string (string SEPARATOR)])
    (string-append (encode-present-state present-state)
                   separator-string (encode-present-symbol present-symbol)
                   separator-string (encode-next-action next-action)
                   separator-string (encode-next-state next-state))))

;; decode-TM-instruction  input string encoding instruction, return instruction
;;   Returns #f if the parsing does not work.
(define (decode-TM-instruction s)  
  (let([split-string (string-split s (string SEPARATOR))])  ; break into four strings
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
      (natural->unary-string 0)
      (string-join (map encode-TM-instruction tm) INTER-INSTRUCTION-SEPARATOR)))

;; decode-TM  input integer encoding of a Turing machine, return list representing that machine
(define (decode-TM s)
  (let ([encoded-instructions (string-split s INTER-INSTRUCTION-SEPARATOR)])
    (let ([list-of-instructions (map decode-TM-instruction encoded-instructions)])
      (display "list of instructions")(display list-of-instructions)(newline)
      (if (not (and-of-list list-of-instructions))
          EMPTY-TURING_MACHINE                                 ;
          (append list-of-instructions)))))

(provide encode-TM
         decode-TM)

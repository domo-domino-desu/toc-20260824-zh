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


;; and-of-list  apply and to the list v
;;   For some reason, (apply + '(1 2))) works but (apply and '(#t #f)) does not.  A wart, for sure.
(define (and-of-list v)
  (if (null? v)
      #t
      (and (car v)
           (and-of-list (cdr v)))))


;; == unary strings ====================
;; Note that the string representing 0 is "1", that representing 1 is "11", etc.

;; unary-string?  Test whether a string is the unary representation of a number
(define (unary-string? s)
  (if (not (string? s))
      #f
      (let ([lst (string->list s)])
        (and-of-list (map
                      (lambda (x) (eqv? x STROKE))
                      lst)))))


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

;; TM?  Test whether the argument is a Turing machine, a list of instructions
(define (TM? v [verbose #f])
  (if (not (list? v))
      #f
      (let ([instruction-results (map instruction? v)])
        (when verbose  ; debugging
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

;; decode-TM  input string encoding instruction, return instruction
;;   Returns #f if the parsing does not work.
(define INSTRUCTION-REGEX (string-append "(" INTER-INSTRUCTION-SEPARATOR ")?"
                                         "(([^" (string SEPARATOR) "]*)"
                                         (string SEPARATOR) "([^" (string SEPARATOR) "]*)"
                                         (string SEPARATOR) "([^" (string SEPARATOR) "]*)"
                                         (string SEPARATOR) "([^" (string SEPARATOR) "]*))"
                                         "(.*)"))

(define (decode-TM-instruction instruction-str [verbose #f])
  (let ([m (regexp-match (pregexp INSTRUCTION-REGEX) instruction-str)])
    (if (not m)
        #f
        (let ([inter-instruction-separator (second m)]
              [new-encoded-instruction (third m)]
              [new-encoded-present-state (fourth m)]  ; part of new-encoded-instruction
              [new-encoded-present-symbol (fifth m)]
              [new-encoded-next-action (sixth m)]
              [new-encoded-next-state (seventh m)]
              [new-str (eighth m)])
          (when verbose ; debugging
            (display "inter-instruction-separator: ")(display inter-instruction-separator)(newline)
            (display "new encoded instruction: ")(display new-encoded-instruction)(newline)
            (display "new-encoded-present-state: ")(display new-encoded-present-state)(newline)
            (display "new-encoded-present-symbol: ")(display new-encoded-present-symbol)(newline)
            (display "new-encoded-next-action: ")(display new-encoded-next-action)(newline)
            (display "new-encoded-next-state: ")(display new-encoded-next-state)(newline)
            (display "new-str: ")(display new-str)(newline))
          (let ([instruction (list (decode-present-state new-encoded-present-state)
                                   (decode-present-symbol new-encoded-present-symbol)
                                   (decode-next-action new-encoded-next-action)
                                   (decode-next-state new-encoded-next-state))])
            (if (not (and-of-list instruction))
                #f
                instruction))))))

(define (decode-TM TM-str [verbose #f])
  (define (decode-TM-helper str instr-list)
    (if (= 0 (string-length str))
        instr-list
        (let ([m (regexp-match (pregexp INSTRUCTION-REGEX) str)])
          (if (not m)
              #f      ; failed to parse
              (let ([inter-instruction-separator (second m)]
                    [new-encoded-instruction (third m)]
                    [new-encoded-present-state (fourth m)] 
                    [new-encoded-present-symbol (fifth m)]
                    [new-encoded-next-action (sixth m)]
                    [new-encoded-next-state (seventh m)]
                    [new-str (eighth m)])
                (when verbose
                  (display "inter-instruction-separator: ")(display inter-instruction-separator)(newline)
                  (display "new encoded instruction: ")(display new-encoded-instruction)(newline)
                  (display "new-encoded-present-state: ")(display new-encoded-present-state)(newline)
                  (display "new-encoded-present-symbol: ")(display new-encoded-present-symbol)(newline)
                  (display "new-encoded-next-action: ")(display new-encoded-next-action)(newline)
                  (display "new-encoded-next-state: ")(display new-encoded-next-state)(newline)
                  (display "new-str: ")(display new-str)(newline))
                (decode-TM-helper new-str (cons (decode-TM-instruction new-encoded-instruction) instr-list)))))
        ))
  
  (if (not (string? TM-str))
      #f
      (let ([TM (decode-TM-helper TM-str '())])
        (if (not (and-of-list TM))
            #f
            (reverse TM)))))

(provide encode-TM-instruction
         decode-TM-instruction)

;; encode-TM  input list of instructions, return integer encoding
(define (encode-TM tm)
  (if (null? tm)
      (natural->unary-string 0)
      (string-join (map encode-TM-instruction tm) INTER-INSTRUCTION-SEPARATOR)))

#|
;; decode-TM  input integer encoding of a Turing machine, return list representing that machine
(define (decode-TM s)
  (let ([encoded-instructions (string-split s INTER-INSTRUCTION-SEPARATOR #:trim? #f)])
    (let ([list-of-instructions (map decode-TM-instruction encoded-instructions)])
      ; (display "list of instructions")(display list-of-instructions)(newline)
      (if (not (and-of-list list-of-instructions))
          EMPTY-TURING_MACHINE                                 ;
          (append list-of-instructions)))))
|#

(provide encode-TM
         decode-TM)



;; ============== ENCODING WITH EXTRA UNARY STRINGS ==================
;; An extra unary string has 0 represented by "1", has 1 represented by "11", etc.
;; (This makes that in the TM representation, "BBB" is easier to parse, since we can easily tell "B"concat"BB" from "BB"concat"B"?
;; It is not ambiguous, it is just more work to decode.

;; extra-unary-string?  Test whether a string is the unary representation of a number
(define (extra-unary-string? s)
  (if (not (string? s))
      #f
      (let ([lst (string->list s)])
        (if (null? lst)
            #f
            (and-of-list (map
                          (lambda (x) (eqv? x STROKE))
                          lst))))))

;; natural->extra-unary-string  Convert a natural number to unary encoded string
;;  n  Natural number (n=0 is OK)
(define (natural->extra-unary-string n)
  (make-string (+ n 1) STROKE))

;; extra-unary-string->natural  Convert a unary string to the natural number it represents 
(define (extra-unary-string->natural s)
  (- (string-length s) 1))

(provide extra-unary-string?
         natural->extra-unary-string
         extra-unary-string->natural)

;; ==== Encode parts of machine using extra unary strings ====

;; encode-present-state-extra  input natural number, output encoding as string
(define (encode-present-state-extra q)
  (natural->extra-unary-string q))

;; decode-present-state input a unary-string, output natural number
;;  (if string is not suitable, output #f)
(define (decode-present-state-extra s)
  (if (not (extra-unary-string? s))
      #f
      (extra-unary-string->natural s)))

(provide encode-present-state-extra
         decode-present-state-extra)

;; encode-next-state-extra  input positive integer, output encoding as string
(define (encode-next-state-extra q)
  (natural->extra-unary-string q))

;; decode-next-state-extra input a string, output natural number
;;  (if string is not suitable, output #f)
(define (decode-next-state-extra s)
  (if (not (extra-unary-string? s))
      #f
      (extra-unary-string->natural s)))

(provide encode-next-state-extra
         decode-next-state-extra)

;; encode-present-symbol-extra  input a present-symbol, output encoding as unary-string
(define (encode-present-symbol-extra ch)
  (natural->extra-unary-string (- (char->integer ch)
                                  CHAR-POINT-OF-LOWEST-CHAR)))

;; decode-present-symbol-extra input a unary-string, output a present symbol
;;  (if string is not suitable, output #f)
(define (decode-present-symbol-extra s)
  (if (not (extra-unary-string? s))
      #f
      (let* ([char-point (+ (extra-unary-string->natural s)
                            CHAR-POINT-OF-LOWEST-CHAR)]
             [ch (integer->char char-point)])
        (if (not (present-symbol? ch))
            #f
            ch))))

(provide encode-present-symbol-extra
         decode-present-symbol-extra)

;; encode-next-action-extra  Input a character, output encoding as unary string
(define (encode-next-action-extra s)
  (natural->extra-unary-string (- (char->integer s)
                                  CHAR-POINT-OF-LOWEST-CHAR)))

;; decode-next-action-extra  input a unary string, output next-action
;;   If input string not suitable, return #f
(define (decode-next-action-extra s)
  (if (not (extra-unary-string? s))
      #f
      (let* ([char-point (+ (extra-unary-string->natural s)
                            CHAR-POINT-OF-LOWEST-CHAR)]
             [ch (integer->char char-point)])
        (if (not (next-action? ch))
            #f
            ch))))

(provide encode-next-action-extra
         decode-next-action-extra)

;; encode-TM-instruction-extra  Input instruction, output encoding as string
(define (encode-TM-instruction-extra inst)
  (let([present-state (first inst)]
       [present-symbol (second inst)]
       [next-action (third inst)]
       [next-state (fourth inst)]
       [separator-string (string SEPARATOR)])
    (string-append (encode-present-state-extra present-state)
                   separator-string (encode-present-symbol-extra present-symbol)
                   separator-string (encode-next-action-extra next-action)
                   separator-string (encode-next-state-extra next-state))))

;; decode-TM-instruction-extra  input string encoding instruction, return instruction
;;   Returns #f if the parsing does not work.
(define (decode-TM-instruction-extra s)  
  (let* ([split-string (string-split s (string SEPARATOR) #:trim? #f)])  ; break into four strings
    ; (display "list of four")(display split-string)(newline)
    (if (not (= 4 (length split-string)))
        #f
        (let ([this-state (decode-present-state-extra (first split-string))]
              [this-input (decode-present-symbol-extra (second split-string))]
              [next-action (decode-next-action-extra (third split-string))]
              [next-state (decode-next-state-extra (fourth split-string))])
          (if (not (and this-state this-input next-action next-state)) ; any fail to decode?
              #f
              (list this-state this-input next-action next-state))))))

(provide encode-TM-instruction-extra
         decode-TM-instruction-extra)

;; encode-TM-extra  input list of instructions, return integer encoding
(define (encode-TM-extra tm)
  (if (null? tm)
      (natural->extra-unary-string 0)
      (string-join (map encode-TM-instruction-extra tm) INTER-INSTRUCTION-SEPARATOR)))

;; decode-TM-extra  input integer encoding of a Turing machine, return list representing that machine
(define (decode-TM-extra s)
  (let ([encoded-instructions (string-split s INTER-INSTRUCTION-SEPARATOR #:trim? #f)])
    (let ([list-of-instructions (map decode-TM-instruction-extra encoded-instructions)])
      ; (display "list of instructions")(display list-of-instructions)(newline)
      (if (not (and-of-list list-of-instructions))
          EMPTY-TURING_MACHINE                                 ;
          (append list-of-instructions)))))

(provide encode-TM-extra
         decode-TM-extra)

#! /usr/bin/env racket
#lang racket

;; pushdown-machine.rkt
;; A simulator for deterministic Pushdown machines, for Theory of Computation by Hefferon
;; Author: Jim Hefferon  License: GPL
;;
;; These routines are adapted from the ones for Finite State machines.

;; Input format: One line per instruction.  Instruction is a space-separated list of five elements:
;; natural number for current state, present character on the tape, present character on the stack,
;; natural number for the next state, and sequence of characters to push onto the stack (first in
;; the sequence will end on top of the stack).
;; Best is to use lower-case letters for alphabet.
;; After each step, the machine prints out a picture of the tape and the stack.
;; 
;; At this moment, there is no utility elsewhere in this repo that converts these pictures for
;; use in Asymptote.

(define A "a")  ;; Most common tape characters
(define B "b")  ;; 
(define ZERO "0")  ;;
(define ONE "1")  ;;
(define EPSILON "epsilon")  ;; For instructions that only manipulate the stack
(provide A B ZERO ONE EPSILON)
(define INPUTEND "END") ;; Mark end of input
(provide INPUTEND)

(define G0 "g0")  ;; Most common stack tokens; strings are clearer than chars
(define G1 "g1")
(define G2 "g2")
(define G3 "g3")
(define BOT "BOT")  ;; Stack bottom
(provide BOT G0 G1 G2 G3)

;; Return codes
(define LIMIT-REACHED -3) ;; more steps than allowed 
(define ERROR -2) ;; some problem with computation
(define HALT -1) ;; machine halted
(provide HALT ERROR LIMIT-REACHED)


;; ======== Tape and stack =================
;; A tape and stack are lists

; list of strings  ->  tape-list
; Make a tape list, ending with an input end marker
(define (make-tape . tape-characters)
  (append tape-characters (list INPUTEND)))

; list of strings  ->  character or ERROR
; Get the first character on the tape.  Return ERROR if no such character.
(define (tape-char tape-list)
  (if (null? tape-list)
      ERROR
      (first tape-list)))

; list of strings  ->  list of strings
; Return the tape with the read head moved to the right.
(define (tape-shift tape-list)
  (cdr tape-list))

(provide make-tape
         tape-char
         tape-shift)

; list of strings -> stack-list
; Make a stack, ending with a bottom marker
(define (make-stack . stack-characters)
  (append stack-characters (list BOT)))

; stack-list ->  stack-list or ERROR
; Pop the top token off the stack.  Return ERROR if stack is empty.
(define (stack-pop stack-list)
  (if (null? stack-list)
      ERROR
      (cdr stack-list)))

; stack-list ->  string or ERROR
; Name top token on the stack, without popping.  Return ERROR if stack is empty.
(define (stack-top stack-list)
  (if (null? stack-list)
      ERROR
      (first stack-list)))

; string stack-list ->  stack-list
; Push a new top token onto the stack.
(define (stack-push ch stack-list)
  (cons ch stack-list))

; string-list stack-list ->  stack-list
; Push the tokens onto the stack.
(define (stack-push-list ch-list stack-list)
  (append ch-list stack-list))

; stack-list -> bool
; Decide if the stack's top token is BOT, that is, whether the stack is exhausted.
(define (stack-bot? stack-list)
  (equal? BOT (car stack-list)))

(provide make-stack
         stack-pop
         stack-top
         stack-push
         stack-push-list
         stack-bot?)


;; ================= Configuration making and reading ==============
;; A configuration is a list of three things:
;;  the current state, as a natural number
;;  the contents of the tape under and to the right of the head, as a list of tape tokens
;;  the contents of the stack, from the top down, including the BOT token.
;; Here, "tokens" means strings.

; natural-number string-list string-list -> list
; Make a configuration (no test performed, say that tape tokens are as declared)
(define (make-config state tape-list stack-list)
  (list state tape-list stack-list))

; configuration ->  natural number
; Get the state number
(define (get-current-state config) (first config))

; configuration -> list of strings
; Get the tape
(define (get-tape-list config) (second config))

; configuration -> list of strings
; Get the stack
(define (get-stack-list config) (third config))

; configuration -> boolean
; Return True iff tape is empty, including that there is no INPUTEND
(define (tape-empty? config)
  (null? (get-tape-list config)))

; configuration -> string  or ERROR
; Get the token pointed to by the read head
(define (get-current-symbol config)
  (tape-char (get-tape-list config)))

; configuration -> string or ERROR
(define (get-stack-top config)
  (stack-top (get-stack-list config)))

(provide make-config
         get-current-state
         get-tape-list
         get-stack-list
         get-current-symbol
         get-stack-top)

;; configuration-> string
;; Return a string representing the tape, for output and debugging
(define (configuration->string config)
  (if (not (list? config))
      (cond
        [(equal? config HALT) "Halt"]
        [(equal? config ERROR) "Error"]
        [else "unknown config"])
      (let* ([state-number (get-current-state config)]
             [state-string (string-append "q" (number->string state-number))]
             [tape-string (string-join (get-tape-list config))]
             [stack-string (string-join (get-stack-list config))])
        (string-append state-string ", tape= " tape-string ", stack= " stack-string))))

(provide make-config
         get-current-state
         get-tape-list
         get-stack-list
         get-current-symbol
         get-stack-top
         configuration->string)

;; ======== Pushdown machine ======================
;; A pushdown machine is a list of instructions.
;; An instruction is a list of length five
;;   (natural-number nonempty-string nonempty-string natural-number list-of-nonempty-strings)
;; representing
;;   (present state, present tape token, present stack token, next state,
;;                                                            list of tokens to push onto stack)

; natural-number string string natural-number list-of-strings  ->  list of five
; Create one instruction 
(define (make-instruction present-state tape-char stack-char next-state stack-char-list)
  (list present-state tape-char stack-char next-state stack-char-list))

(define (get-present-state inst)
  (first inst))
(define (get-present-tape-char inst)
  (second inst))
(define (get-present-stack-char inst)
  (third inst))
(define (get-next-state inst)
  (fourth inst))
(define (get-push-stack-list inst)
  (fifth inst))

;; instruction (list of five) -> string
;; Return string that is printable depiction of an instruction, for display or debugging
(define (instruction->string inst)
  (string-join (list (number->string (get-present-state inst))
                     (get-present-tape-char inst)
                     (get-present-stack-char inst)
                     (number->string (get-next-state inst))
                     (string-join (list "(" (string-join (get-push-stack-list inst)) ")")))))


;; structure
;; A pushdownmachine is a structure consisting of instructions and accepting states.
(struct pushdownmachine (instructions acceptingstates) #:transparent #:mutable)

; no input  ->  pushdownmachine
; Create an empty pushdown machine.
(define (pdm-create)
  (pushdownmachine '() (mutable-set)))

; pushdown-machine natural-number  ->  pushdown-machine
; Add the accepting state to the machine 
(define (pdm-add-accepting-state pdm accepting-state)
  (set-pushdownmachine-acceptingstates! pdm
                                        (set-add!  (pushdownmachine-acceptingstates pdm) accepting-state)))

; pushdown-machine instruction  ->  pushdown-machine
; Add the instruction to the machine
(define (pdm-add-instruction pdm instruction)
  (set-pushdownmachine-instructions! pdm
                                     (reverse (cons instruction (reverse (pushdownmachine-instructions pdm))))))

;; pushdownmachine -> string
;; Return string of the instructions, for display or debugging
(define (pdm->string pdm)
  (string-join (map instruction->string (pushdownmachine-instructions pdm)) "\n"))


(provide make-instruction
         get-present-state
         get-present-tape-char
         get-present-stack-char
         get-next-state
         get-push-stack-list
         instruction->string
         pushdownmachine?
         pushdownmachine-instructions
         pushdownmachine-acceptingstates
         pdm->string
         pdm-create
         pdm-add-accepting-state
         pdm-add-instruction)


;; =============================
; pushdownmachine natural-number string  ->  (natural-number string-list), or ERROR
; Find the applicable instruction, return output pair
(define (delta pdm current-state current-symbol stack-top)
  (define (delta-test inst)
    (and (= current-state (first inst))
         (equal? current-symbol (second inst))
         (equal? stack-top (third inst))))
  
  (let ([inst (findf delta-test (pushdownmachine-instructions pdm))])
    (if (not inst)
        ERROR     
        (list (fourth inst) (fifth inst)))))

(provide delta)



;; ===================================================
;; Take one step
;; step  Do one step; from a config and the pdm, yield the next config
(define (step pdm config)
  ;(printf "starting step: config is: ")
  ;(write config)
  ;(writeln "")
  (if (tape-empty? config)
      HALT
      (let* ([current-state (get-current-state config)]
             [current-symbol (get-current-symbol config)]
             [stack-top (get-stack-top config)]
             [output-pair (delta pdm current-state current-symbol stack-top)])
        ;(printf "  current-state: ~a, current-symbol: ~a, stack-top: ~a\n" current-state current-symbol stack-top)
        (if (equal? output-pair ERROR)
            ERROR
            (let* ([next-state (first output-pair)]
                   [push-stack-list (second output-pair)]
                   [tape-list (get-tape-list config)]
                   [popped-stack (stack-pop (get-stack-list config))]
                   [stack-list (stack-push-list push-stack-list popped-stack)])
              ;(printf "  next-state: ~a, push-stack-list: ~a\n" next-state push-stack-list)
              ;(printf "    now the stack is stack-list: ~a\n" stack-list)
              ;(printf "    next the tape will be: ~a\n" (tape-shift tape-list))
              ;(printf "    equal? current-symbol EPSILON ~a\n" (equal? current-symbol EPSILON))
              (if (equal? current-symbol EPSILON)
                  (make-config next-state tape-list stack-list)
                  (make-config next-state (tape-shift tape-list) stack-list)))
            ))))

(provide step)


;;; ===================================================
;;; Run a computation
;

;; number configuration -> void
;; Print one line with state and current configuration information
(define (show-step-config s c)
  (printf "Step ~a: ~a\n" (number->string s)
          (configuration->string c))
  )

; string  ->  list of strings
; convert characters in a list of characters into strings
(define (string->string-list s)
  (map string (string->list s)))

(define (yield-star pdm tau [limit 500])
  (do
      ([s 0 (add1 s)]
       [config (make-config 0
                            (apply make-tape (string->string-list tau))
                            (make-stack))
               (step pdm config)]
       [history '() (cons config history)])
    ((or
      (= s limit)
      (equal? config HALT)
      (equal? config ERROR)) (if (= s limit)
                                 (cons LIMIT-REACHED history)
                                 (cons config history))
                               (reverse history)))
    ; (printf "next config ~a\n" config)
    ; (printf "  history ~a\n" history)
    )

(define (show-yield-star pdm tau)
  (let ([strs (map configuration->string (yield-star pdm tau))])
    (map (lambda (x) (printf "~s\n" x)) strs)))

; pushdown-machine string  ->  integer
; Run the steps in the computation of the pushdown machine
(define (run pdm sigma)
  ;(writeln "starting run-do")
  (do
      ([lagging-config '() config]
       [config (make-config 0
                            (apply make-tape (string->string-list sigma))
                            (make-stack))
               (step pdm config)]
       [step-no 0 (+ 1 step-no)])
    ((or (equal? HALT config)
         (equal? ERROR config))
     (if (equal? config HALT)
         (printf "done: final state=~a\n" (get-current-state lagging-config))
         (printf "done: error\n")))
    ; (set! lagging-config config)
    ;(writeln "lagging-config is ")(write lagging-config)(writeln "")
    ;(writeln "config is ")(write config)(writeln "")
    ;(printf "equal? lagging-config config) ~a\n" (equal? lagging-config config))
    (show-step-config step-no config))
    )
;
;
;(define (decide pdm F sigma)
;  (if (member (run pdm sigma) F)
;      "accept"
;      "reject"))
;
(provide run
         yield-star
         show-yield-star)
;         decide)

;; ===== Parse file containing a machine

;; Regular expressions used to parse the lines

; ; Allow # as a comment character
(define EMPTY-LINE-REGEXP #px"^\\s*(\\#.*)?$")

; The defn says Delta maps Q x (Sigma union {B, epsilon}) x (Gamma union BOT) to Q x Gamma^*
; I interpret members of Q as natural numbers,
;             members of Sigma union {B, epsilon} as strings with at least one a-zA-Z or ] or [ or ) or (
;             members of Gamma union BOT as strings with at least one a-z, A-Z, 0-9, or _
;             members of Gamma * as a list "( ... )" where the ... is a space-separated list of members of Gamma 
; (define LINE-REGEXP #px"^\\s*([\\d]+)\\s*([a-zA-Z\\]\\[\\)\\(]+)\\s*([\\w]+)\\s*([\\d]+)\\s*\\((.*?)\\)\\s*(\\#.*)?$")
(define LINE-REGEXP #px"^\\s*([\\d]+)\\s*([a-zA-Z\\]\\[\\)\\(]+)\\s*([a-zA-Z0-9\\]\\[]+)\\s*([\\d]+)\\s*\\(([a-zA-Z0-9 \\]\\[]*)\\)\\s*(\\#.*)?$")

; Need a way to describe some states as final, or accepting.
;(define FINAL-STATES-REGEXP #px"^\\s*((FINAL)|(ACCEPTING))[:]?\\s*([\\s*\\d+,?]*)\\s*(\\#.*)?$")
(define FINAL-STATES-REGEXP #px"\\s*((FINAL)|(ACCEPTING))[:]?\\s*([\\s*\\d+,?]*)\\s*(\\#.*)?$")

; list of five strings -> instruction
; Turn the list of strings m into an instruction
(define (parse-make-instruction m)
  (let ([present-state (string->number (first (car m)))]
        [present-tape-token (second (car m))]
        [present-stack-token (third (car m))]
        [next-state (string->number (fourth (car m)))]
        [next-stack-list (string-split (fifth (car m)))])
    (make-instruction present-state present-tape-token present-stack-token next-state next-stack-list)))

;; string -> list of numbers
;; Return the numbers given as a space-separated list in the string
;; (An initial comma is allowed between numbers, as in "3, 4")
(define FINAL-STATES-PARSE-REGEXP #px"(,\\s*)|(\\s+)")
(define (parse-final-states m)
  (let* ([token-list (car m)]
         [digit-string (fourth token-list)])
    (printf "parse-final-states token-list=~s\n    digit-string=~s\n" token-list digit-string)
    (map string->number (string-split (string-trim digit-string) FINAL-STATES-PARSE-REGEXP))))

;; string -> list of two lists
;;  Return either an instruction or a list of integers, not both.  It can be that both lists are empty.
(define (parse-one-line lne)
  (let ([inst '()]
        [final-states '()])
    (printf "parse-one-line: lne=~s\n" lne)
    (cond
      [(regexp-match? EMPTY-LINE-REGEXP lne)
       (begin
         (printf "    matches empty line\n")
         (list inst final-states))]
      [(regexp-match? LINE-REGEXP lne)
       (let ([m (regexp-match* LINE-REGEXP lne #:match-select cdr)])
         (list (parse-make-instruction m) final-states))]
      [(regexp-match? FINAL-STATES-REGEXP lne)
       (let ([m (regexp-match* FINAL-STATES-REGEXP lne #:match-select cdr)])
         (list inst (parse-final-states m)))]
      [else
       (begin
         (printf "ERROR! line does not parse: ~s" lne)
         (list inst final-states))]
      )))
  
;; list of strings -> list of instructions
(define (parse file-contents)
  (let ([pdm (pdm-create)])
    ; (printf "  parse: pdm=~s\n" pdm)
    (for* ([line file-contents])
      (printf "parse: line=~s\n" line)
      ; (printf "    parse-one-line=~s\n" (parse-one-line line))
       (let* ([inst-and-states (parse-one-line line)]
              [inst (first inst-and-states)]
              [state-list (second inst-and-states)])
        (printf "    parse: inst-and-states=~s\n" inst-and-states)
        (printf "    parse: (first inst-and-states)=~s\n" (first inst-and-states))
        (printf "    parse: inst=~s  state-list=~s\n" inst state-list)
        (if (not (null? inst))
            (pdm-add-instruction pdm inst)
            (for ([accepting-state state-list])
              (pdm-add-accepting-state pdm accepting-state)))
        ; (printf "  parse: pdm=~s\n" pdm)))
    )) pdm)
  )


(provide EMPTY-LINE-REGEXP
         LINE-REGEXP
         FINAL-STATES-REGEXP
         FINAL-STATES-PARSE-REGEXP
         parse-make-instruction
         parse-final-states
         parse-one-line
         parse)

;
;; ============= Running from the command line =========
;; Gratitude to https://jackwarren.info/posts/guides/racket/racket-command-line/

;; Parameters with defaults

;; Name of file containing the program
(define filename (make-parameter null))

;; At each step show the registers, if true
(define show-steps? (make-parameter #f))

;; Input tape, list of instruction strings
(define tape (make-parameter null))

;; Talk a lot, if true
(define verbose? (make-parameter #f))

(provide tape)


;; string -> list of strings
(define (split-input-tape t)
  (let* ([lines (string-split t "\n")]
         [trimmed-lines (map string-trim lines)])
    trimmed-lines))

(provide split-input-tape)

;; For running from the command line; the "module+ main" is the Racket construct to execute code
;; when running from the command line but not from an importing module
(module+ main

  (define command-line-parser
    (command-line
     #:usage-help 
     "Simulate a Pushdown machine."
     "Put instructions on separate lines.  You can indent, and also use # as comment character."
     "An instruction is a five-tuple: natural number, tape symbol or B or epsilon, stack symbol or BOT, natural number, list of stack symbols in parens.  Typical: 0 a G0 1 (G0 G1)."
     #:once-each
     [("-f" "--filename") program-fn "Name of file with the program, as in \"machines/simple.pdm\""
                          (filename program-fn)]
     [("-s" "--show-steps") "Show the registers for each step"
                                (show-steps? #t)]
     [("-t" "--tape") tapelist "Input tape, string of space-separated tokens"
                          (tape (split-input-tape tapelist))]
     [("-v" "--verbose") "Verbose mode" (verbose? #t)]
     #:args  () (void)))

  (when (verbose?)
    (begin
      (show-steps? #t)
      ))
  
  ;; Read the file with the program
  (define PDM-LINES '())  ;; list of file lines, one string per instruction
  ; (printf "filename=~s\n" filename)
  (if (null? (filename))
    (set! PDM-LINES "") ;; should instead fail?
    (set! PDM-LINES
          (port->string (open-input-file (filename)) #:close? #t)))

  (printf "~a\n" (run (parse PDM-LINES) (tape)))  ; print the result to stdout
)

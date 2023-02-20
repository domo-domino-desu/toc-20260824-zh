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

(define G0 "g0")  ;; Most common stack characters; strings are clearer than chars
(define G1 "g1")
(define G2 "g2")
(define G3 "g3")
(define BOT "BOT")  ;; Stack bottom
(provide BOT G0 G1 G2 G3)

(define LIMIT-REACHED -3) ;; more steps than allowed 
(define ERROR -2) ;; some problem with computation
(define HALT -1) ;; machine halted
(provide HALT ERROR LIMIT-REACHED)


;; ======== Tape and stack =================
;; A tape and stack are lists

; list of characters  ->  tape-list
; Make a tape list, ending with an input end marker
(define (make-tape . tape-characters)
  (append tape-characters (list INPUTEND)))

; list of characters  ->  character or ERROR
; Get the first character on the tape.  Return ERROR if no such character.
(define (tape-char tape-list)
  (if (null? tape-list)
      ERROR
      (first tape-list)))

; list of characters  ->  list of characters
; Return the tape with the read head moved.
(define (tape-shift tape-list)
  (cdr tape-list))

(provide make-tape
         tape-char
         tape-shift)

; list of characters -> stack-list
; Make a stack, ending with a bottom marker
(define (make-stack . stack-characters)
  (append stack-characters (list BOT)))

; stack-list ->  stack-list or ERROR
; Pop the top character off the stack.  Return ERROR if stack is empty.
(define (stack-pop stack-list)
  (if (null? stack-list)
      ERROR
      (cdr stack-list)))

; stack-list ->  character or ERROR
; Name top character on the stack, without popping.  Return ERROR if stack is empty.
(define (stack-top stack-list)
  (if (null? stack-list)
      ERROR
      (first stack-list)))

; character stack-list ->  stack-list
; Push a new top character onto the stack.
(define (stack-push ch stack-list)
  (cons ch stack-list))

; character-list stack-list ->  stack-list
; Push the characters onto the stack.
(define (stack-push-list ch-list stack-list)
  (append ch-list stack-list))

; stack-list -> bool
; Decide if the stack's top character is the bottom character.
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
;;  the contents of the tape under and to the right of the head, as a list of tape characters
;;  the contents of the stack, from the top down, including the BOT character.

; natural-number character-list character-list -> list
; Make a configuration (no test performed, say that tape characters are as declared)
(define (make-config state tape-list stack-list)
  (list state tape-list stack-list))

; configuration  ->  natural number
; Get the state number
(define (get-current-state config) (first config))

; configuration  -> list of characters
; Get the tape
(define (get-tape-list config) (second config))

; configuration  ->  list of characters
; Get the stack
(define (get-stack-list config) (third config))

; configuration -> boolean
; Return True iff tape is empty, including that there is no INPUTEND
(define (tape-empty? config)
  (null? (get-tape-list config)))

; configuration -> character or ERROR
; Get the character pointed to by the read head
(define (get-current-symbol config)
  (tape-char (get-tape-list config)))

; configuration -> character or ERROR
(define (get-stack-top config)
  (stack-top (get-stack-list config)))

(provide make-config
         get-current-state
         get-tape-list
         get-stack-list
         get-current-symbol
         get-stack-top)

;; configuration-> string  Return a string representing the tape
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
        (string-append state-string ", tape=" tape-string ", stack=" stack-string))))

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
;;   (natural-number character character natural-number character-list)
;; representing
;;   (present state, present tape character, present stack character, next state,
;;                                                            list of chars to push onto stack)

; natural-number character character natural-number character-list  ->  list of five
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

; no input  ->  list
; Create an empty pushdown machine
(define (pdm-create)
  (list))

; pushdown-machine instruction  ->  pushdown-machine
; Add the instruction to the machine 
(define (pdm-add-to pdm instruction)
  (reverse (cons instruction (reverse pdm)))) ; convenient for debugging to retain order

(provide make-instruction
         get-present-state
         get-present-tape-char
         get-present-stack-char
         get-next-state
         get-push-stack-list
         pdm-create
         pdm-add-to)


;; =============================
; pushdown-machine natural-number character  ->  natural-number character-list, or ERROR
; Find the applicable instruction, return output pair
(define (delta pdm current-state current-symbol stack-top)
  (define (delta-test inst)
    (and (= current-state (first inst))
         (equal? current-symbol (second inst))
         (equal? stack-top (third inst))))
  
  (let ([inst (findf delta-test pdm)])
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
;; show-state-config  Print one line with state and current configuration information
(define (show-step-config s c)
  (printf "Step ~a: ~a\n" (number->string s)
          (configuration->string c))
  )

;; run  Run a computation

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
    strs))

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
;
;;; ======================================================
;;; Read machine from a file
;;; string->instruction  Convert a string, a line from the file, to a single instruction
;(define (current-state-string->number s)
;  (if (eq? #\( (string-ref s 0))   ;; allow instr to start with (
;      (string->number (substring s 1))
;      (string->number s)))
;(define (current-symbol-string->char s)
;  (string-ref s 0))
;(define (next-state-string->number s)
;  (if (eq? #\) (string-ref s (- (string-length s) 1))) ;; ends with )?
;      (string->number (substring s 0 (- (string-length s) 1)))
;      (string->number s)))
;(define (string->instruction s)
;  (let* ([instruction (string-split (string-trim s))]
;         [current-state (current-state-string->number (first instruction))]
;         [current-symbol (current-symbol-string->char (second instruction))]
;         [next-state (next-state-string->number (third instruction))])
;    (list current-state
;          current-symbol
;          next-state)))
;
;(provide string->instruction)
;
;;; ........................
;;; Command line to invoke this program
;
;(define verbose? (make-parameter #f))
;(define fsm-filename (make-parameter null))
;(define inputstring (make-parameter ""))  
;; (define statelimit (make-parameter "1000")) ;; max number of steps simulator runs
;
;(define command-line-parser
;  (command-line
;   #:usage-help 
;   "Simulate a Finite State machine."
;   "Put instructions like `state-number current-char next-state-number' on separate lines."
;   #:once-each
;   [("-v" "--verbose") "Verbose mode" (verbose? #t)]
;   [("-f" "--filename") fsmfn "Name of file with the Finite State machine" (fsm-filename fsmfn)]
;   [("-i" "--input-string") in-st "String giving nonblank tape contents" (inputstring in-st)]
;   ; [("-s" "--statelimit") slmt "Number of steps to run" (statelimit slmt)]
;   #:args  () (void)))
;
;(define FSM-LINES '())  ;; list of file lines, one string per instruction
;;; This is for allowing input from the command line
;(if (null? (fsm-filename))
;    (set! FSM-LINES '())
;    (set! FSM-LINES (file->lines (fsm-filename) #:mode 'text #:line-mode 'any)))
;
;;; for debugging:
;;FSM-LINES
;
;;; Return the list with the last element omitted
;(define (omit-last-element lst)
;  (reverse (cdr (reverse lst))))
;
;;; Note that empty lines give an error in the TM
;;(unless (non-empty-string? (last FSM-LINES))
;;  (fprintf (current-output-port)
;;           "File ~s: Trailing empty string will cause an error.  Delete it.\n"
;;           (fsm-filename)))
;
;;; Return a list of instructions
;(define FSM (for/list ([line FSM-LINES])
;                 (string->instruction line)))
;FSM
;
;
;(run FSM (inputstring))

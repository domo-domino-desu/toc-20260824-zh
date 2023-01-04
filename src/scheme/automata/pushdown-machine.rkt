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
;; At this moment, there is no a utility elsewhere in this repo that converts these pictures for
;; use in Asymptote.

(define A #\a)  ;; Most common tape characters
(define B #\b)  ;; 
(define ZERO #\0)  ;;
(define ONE #\1)  ;;
(provide A B ZERO ONE)
(define INPUTEND #\B) ;; Mark end of input
(provide INPUTEND)

(define BOT #\$)  ;; Most common stack characters
(define G0 #\Z)
(define G1 #\Y)
(define G2 #\X)
(define G3 #\W)
(provide BOT G0 G1 G2 G3)

(define HALT -1) ;; 
(define ERROR -1) ;; 
(provide HALT ERROR)


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

; stack-list -> bool
; Decide if the stack's top character is the bottom character.
(define (stack-bot? stack-list)
  (equal? BOT (car stack-list)))

(provide make-stack
         stack-pop
         stack-top
         stack-push
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

; configuration  ->  list of characeters
; Get the stack
(define (get-stack-list config) (third config))

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
      "--"
      (let* ([state-number (get-current-state config)]
             [state-string (string-append "q" (number->string state-number))]
             [tape-string (list->string (get-tape-list config))]
             [stack-string (list->string (get-stack-list config))])
        (string-append state-string ": " tape-string "; " stack-string))))

(provide make-config
         get-current-state
         get-tape-list
         get-stack-list
         get-current-symbol
         get-stack-top
         configuration->string)


;; =============================
;; delta  Find the applicable instruction, return next state
(define (delta pdm current-state current-symbol stack-top)
  (define (delta-test inst)
    (and (= current-state (first inst))
         (equal? current-symbol (second inst))
         (equal? stack-top third inst)))
  
  (let ([inst (findf delta-test pdm)])
    (if (not inst)
        ERROR     
        (list (fourth inst) (fifth inst)))))

(provide delta)



;; ===================================================
;; Take one step
;; step  Do one step; from a config and the fsm, yield the next config
(define (step pdm config)
  (let* ([current-state (get-current-state config)]
         [tape-list (get-tape-list config)]
         [stack-list (get-stack-list config)]
         [current-symbol (get-current-symbol config)]
         [stack-top (get-stack-top config)]
         [output-pair (delta pdm current-state current-symbol stack-top)]
         [next-state (first output-pair)]
         [popped-stack (stack-pop stack-list)]
         [new-stack (append (second output-pair) popped-stack)]
         )
    (make-config next-state
                 (cdr tape-list)
                 new-stack)))

(provide step)


;;; ===================================================
;;; Run a computation
;
;;; show-state-config  Print one line with state and current configuration information
;(define (show-step-config s c)
;  (printf "Step ~a: ~a\n" (number->string s)
;          (configuration->string c))
;  )
;
;;; run  Run a FSM computation
;;(define (run fsm sigma)
;;  (define (run-helper config step)
;;    (let ([tape-list (get-tape-list config)]
;;          [current-state (get-current-state config)])
;;      (if (null? tape-list)
;;                 current-state
;;                 (begin
;;                   (show-step-config step config)
;;                   (run-helper (make-config (delta fsm current-state (car tape-list))
;;                                          (cdr tape-list))
;;                               (+ 1 step))
;;                   ))))
;;  ;
;;  (run-helper (make-config 0
;;                           (string->list sigma))
;;              0))
;
;(define (run pdm sigma)
;  (let* ([config (make-config 0
;                              (string->list sigma)
;                              (list BOT))]
;         [step-no 0])
;    (show-step-config step-no config)
;    (for ([current-symbol (get-tape-list config)])
;      (set! step-no (+ 1 step-no))
;      (set! config (step pdm config))
;      (show-step-config step-no config))
;    (get-current-state config)))
;
;
;(define (decide pdm F sigma)
;  (if (member (run pdm sigma) F)
;      "accept"
;      "reject"))
;
;(provide run
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

#! /usr/bin/env racket
#lang racket

;; finite-state-machine.rkt
;; A simulation of Finite State machines, for Theory of Computation by Hefferon
;; Author: Jim Hefferon  License: GPL
;;
;; These routines are adapted from the ones for Turing machines.


;; Input format: One line per instruction.  Instruction is a space-separated list of three elements:
;; natural number for current state, character for what the input is, natural number for the next state.
;; Best is to use digits or lower-case letters for alphabet.
;; After each step, the machine prints out a picture of the tape.
;; 
;; There is a utility elsewhere in this repo that converts these pictures for use in Asymptote.

(define A #\a)  ;; Most common input characters
(define B #\b)  ;; 
(define ZERO #\0)  ;; Most common input characters
(define ONE #\1)  ;;  
(define HALT -1) ;; 
(define ERROR -1) ;; 
(provide  A B ZERO ONE
          HALT ERROR)

;; ================= Configuration making and reading ==============
;; A configuration is a list of two things:
;;  the current state, as a natural number
;;  the contents of the tape under and to the right of the head, as a list of characters
(define (make-config state tape-list)
  (list state tape-list))

(define (get-current-state config) (first config))
(define (get-tape-list config) (second config))
(define (get-current-symbol config) (first (get-tape-list config)))

(provide make-config
         get-current-state
         get-tape-list
         get-current-symbol)

;; configuration-> string  Return a string showing the tape
(define (configuration->string config)
  (let* ([state-number (get-current-state config)]
         [state-string (string-append "q" (number->string state-number))]
         [tape-string (list->string (get-tape-list config))])
    (string-append state-string ": " tape-string)))

(provide configuration->string)


;; =============================
;; delta  Find the applicable instruction, return next state
(define (delta fsm current-state current-symbol)
  (define (delta-test inst)
    (and (= current-state (first inst))
         (equal? current-symbol (second inst))))
  
  (let ([inst (findf delta-test fsm)])
    (if (not inst)
        ERROR     
        (third inst))))

(provide delta)


;; ===================================================
;; Take one step
;; step  Do one step; from a config and the fsm, yield the next config
(define (step config fsm)
  (let* ([current-state (get-current-state config)]
         [tape-list (get-tape-list config)]
         [current-symbol (get-current-symbol config)]
         [next-state (delta fsm current-state current-symbol)])
    (make-config next-state
                 (substring tape-list 1))))

(provide step)

;; ======================================================
;; Read machine from a file
;; string->instruction  Convert a string, a line from the file, to a single instruction
(define (current-state-string->number s)
  (if (eq? #\( (string-ref s 0))   ;; allow instr to start with (
      (string->number (substring s 1))
      (string->number s)))
(define (current-symbol-string->char s)
  (string-ref s 0))
(define (next-state-string->number s)
  (if (eq? #\) (string-ref s (- (string-length s) 1))) ;; ends with )?
      (string->number (substring s 0 (- (string-length s) 1)))
      (string->number s)))
(define (string->instruction s)
  (let* ([instruction (string-split (string-trim s))]
         [current-state (current-state-string->number (first instruction))]
         [current-symbol (current-symbol-string->char (second instruction))]
         [next-state (next-state-string->number (fourth instruction))])
    (list current-state
          current-symbol
          next-state)))

(provide string->instruction)

;; ........................
;; Command line to invoke this program

(define verbose? (make-parameter #f))
(define fsm-filename (make-parameter null))
(define inputstring (make-parameter ""))  
(define statelimit (make-parameter "1000")) ;; max number of steps simulator runs

(define command-line-parser
  (command-line
   #:usage-help 
   "Simulate a Finite State machine."
   "Put instructions like `state-number current-char next-state-number' on separate lines."
   #:once-each
   [("-v" "--verbose") "Verbose mode" (verbose? #t)]
   [("-f" "--filename") fsmfn "Name of file with the Finite State machine" (fsm-filename fsmfn)]
   [("-i" "--input-string") in-st "String giving nonblank tape contents" (inputstring in-st)]
   [("-s" "--statelimit") slmt "Number of steps to run" (statelimit slmt)]
   #:args  () (void)))

;; (tm-filename)

(define FSM-LINES '())  ;; list of file lines, one string per instruction
;; This is for allowing input from the command line
;;(if (null? (tm-filename))
;;    (set! TM-LINES (port->lines #:line-mode 'any #:close? #f))
;;    (set! TM-LINES (file->lines (tm-filename) #:mode 'text #:line-mode 'any)))
(if (null? (fsm-filename))
    (set! FSM-LINES '())
    (set! FSM-LINES (file->lines (fsm-filename) #:mode 'text #:line-mode 'any)))

;; for debugging:
FSM-LINES

;; Return the list with the last element omitted
(define (omit-last-element lst)
  (reverse (cdr (reverse lst))))

;; Note that empty lines give an error in the TM
;(unless (non-empty-string? (last FSM-LINES))
;  (fprintf (current-output-port)
;           "File ~s: Trailing empty string will cause an error.  Delete it.\n"
;           (fsm-filename)))

;; Return a list of instructions
(define FSM (for/list ([line FSM-LINES])
                 (string->instruction line)))
;; for debugging: TM

;(define INITIAL-CONFIG (make-config 0
;                                    (current-symbol-string->char (startchar))
;                                    (string->list (startleft))
;                                    (string->list (startright))))  ;; TODO need the position?
;; for debugging: INITIAL-CONFIG
;(execute-guarded TM INITIAL-CONFIG)
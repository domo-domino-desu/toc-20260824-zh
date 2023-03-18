#lang racket
(require racket/cmdline)

(require "device.rkt")

;; turing-machine.rkt
;; A Turing machine simulation, for Theory of Computation by Hefferon
;; Author: Jim Hefferon  License: GPL
;;
;; Input format: One line per instruction.  Instruction is a space-separated list of four elements:
;; natural number for current state, character for what the head is point to, character for the action (any alphabet
;; character and L or R), natural number for the next state.  Best is to use digits or lower-case letters for alphabet.
;; After each step, the machine prints out a picture of the tape with the current char between asterisks.
;; 
;; There is a utility elsewhere in this repo that converts these pictures for use in Asymptote.


;; TODO: Execute for a fixed number of steps

;; ===== Instruction
(struct instructionstruct (presentstate presenttoken nexttoken nextstate) #:transparent #:mutable)

;; instruction (list of four) -> string
;; Return string that is printable depiction of an instruction, for display or debugging
(define (instruction->string inst)
  (let* ([presentstate-number (instructionstruct-presentstate inst)]
         [presentstate-string (string-append "q" (number->string presentstate-number))]
         [presenttoken (instructionstruct-presenttoken inst)]
         [nexttoken (instructionstruct-nexttoken inst)]
         [nextstate-number (instructionstruct-nextstate inst)]
         [nextstate-string (string-append "q" (number->string nextstate-number))])
    (string-join (list presentstate-string presenttoken nexttoken nextstate-string))))

(provide instructionstruct
         instruction->string)

;; ===== Configuration
(struct configurationstruct (state tape) #:transparent #:mutable)

;; configuration-> string
;; Return a string representing the tape, for output and debugging
(define (configuration->string config)
  (if (not (configurationstruct? config))
      (cond
        [(equal? config HALT) "Halt"]
        [(equal? config ERROR) "Error"]
        [else "unknown config"])
      (let* ([state-number (configurationstruct-state config)]
             [state-string (string-append "q" (number->string state-number))]
             [tape (configurationstruct-tape config)]
             [left-tape (list->string (get-tape-left tape))]
             [current (string #\* (get-tape-current tape) #\*)]  ;; wrap *'s
             [right-tape (list->string (get-tape-right tape))])
        (string-append state-string ": " left-tape current right-tape))))

;; ===== Run

;; For Turing machines, Delta maps Q x Sigma -> (Sigma union {L,R}) x Q.
(define (tm->delta-map tm)
  (let ([delta-map (make-delta-map)]
        [instructions (machinestruct-instructions tm)])
    (for ([inst instructions])
      (let ([key (list (instructionstruct-presentstate inst) (instructionstruct-presenttoken inst))]
            [value (list (instructionstruct-nexttoken inst) (instructionstruct-nextstate inst))])
        (set-delta-map! delta-map key value)))
    delta-map))


;; history-node, delta-map -> configuration
;; Make one transition that is not an epsilon transition, or return DELTA-NOKEY if no applicable instruction
(define (transition-non-epsilon history-node delta-map)
  (let* ([config (car history-node)]
         [present-state (configurationstruct-state config)]
         [tape (configurationstruct-tape config)]
         [present-token (get-tape-current tape)]
         [next-action-and-state (delta delta-map (list present-state present-token))])
    (if (equal? next-action-and-state DELTA-NOKEY)
      DELTA-NOKEY
      (let ([next-action (first next-action-and-state)]
            [next-state (second next-action-and-state)])
        (cond
          [(equal? next-action LEFT)
           (configurationstruct next-state (move-head-right tape))]
          [(equal? next-action RIGHT)
           (configurationstruct next-state (move-head-left tape))] 
          [else
           (configurationstruct next-state (change-head-token tape next-action))])
          ))))

;;
;;
(define (one-step-one-node history-node delta-map epsilon-closure)
  (let* ([config (car history-node)]
         [current-state (configurationstruct-state config)]
         [tape (configurationstruct-tape config)]
         [current-token (get-tape-current tape)]
         [next-action-and-state (delta delta-map )])
    ; Apply delta-map to get single transition
    
  ; Take epsilon transitions
  ; add to the history a bunch of child nodes, one for each state in the epsilon-clousre
    (let ([eps-states (hash-ref epsilon-closure state)]
          [new-child-nodes '()])
)
    (for ([s eps-states])
      (cons (add-child-node! history-node (configurationstruct s tape))
            new-child-nodes))
    )
  )


;; ===== Parse
; The defn says Delta maps Q x (Sigma union {B, epsilon}) to  Q x Gamma^* (or Gamma for deterministic ones)
; I interpret members of Q as natural numbers,
;             members of Sigma union {B, epsilon} as strings with at least one a-z or ] or [ or ) or (,
;               or the string EPS (for epsilon) in the nondeterministic case
;             members of Gamma * as a list "( ... )" where the ... is a space-separated list of members of Gamma 
(define INSTRUCTION-LINE-REGEXP #px"^\\s*(\\d+)\\s*([a-zB0-9\\]\\[\\)\\(]+|EPS)\\s*([a-zBLR0-9\\]\\[\\)\\(]+)\\s*(\\d+)\\s*(\\#.*)?$")

; list of four strings -> instruction
; Turn the list of strings m into an instruction
(define (parse-make-instruction string-list  [instructionstruct instructionstruct])
  (let ([present-state (string->number (first string-list))]
        [present-tape-token (second string-list)]
        [next-token (third string-list)]
        [next-state (string->number (fourth string-list))])
    (instructionstruct present-state present-tape-token next-token next-state)))


(provide INSTRUCTION-LINE-REGEXP
         parse-make-instruction)

;; ========================================================
;; Read command line.

(define verbose? (make-parameter #f))
(define silent? (make-parameter #f))
(define filename (make-parameter null))
(define startchar (make-parameter (make-string 1 BLANK)))  ;; string with one char, head points to this char first
(define startleft (make-parameter ""))  ;; string giving tape left of the start char
(define startright (make-parameter ""))  ;; string giving tape right of start char
(define steplimit (make-parameter "-1")) ;; max number of steps simulator runs; a negative makes it run until done

;; Initial configuration; always start at state 0
(define INITIAL-TAPE  (tapestruct(string-split (startleft))
                                 (startchar)
                                 (string-split (startright))))
(define INITIAL-CONFIG (configurationstruct 0 INITIAL-TAPE))

;; For running from the command line; this is the Racket construct to execute code from
;; command line but not from an importing module
(module+ main
  ; (display "Running main\n")
  ;; Read command line arguments  
  (command-line
   #:usage-help 
   "Simulate a Turing machine."
   "Put instructions of the form `state-number current-char action-char next-state-number' on separate lines in the fil."
   #:once-each
   [("-v" "--verbose") "Verbose mode" (verbose? #t)]
   [("-f" "--filename") fn "Name of file with the Turing machine" (filename fn)]
   [("-c" "--char") sc "Character the head points to at start" (startchar sc)]
   [("-l" "--left") sl "String giving tape left of the start character" (startleft sl)]
   [("-r" "--right") sr "String giving tape right of the start character" (startright sr)]
   [("-s" "--steplimit") slmt "Number giving max number of steps to run" (steplimit slmt)]
   #:args  () (void))

  (when (verbose?)
    (begin
      (silent? #f)
      ))
  
  ;; Read the file with the program
  (define INPUT-LINES '())  ;; list of file lines, one string per instruction
  (if (null? (filename))
    (set! INPUT-LINES "") ;; should instead fail?
    (set! INPUT-LINES
          (string-split (port->string (open-input-file (filename)) #:close? #t) "\n")))
  ; (printf "INPUT-LINES=~s\n" INPUT-LINES)
  (let* ([tm (parse INPUT-LINES INSTRUCTION-LINE-REGEXP parse-make-instruction instructionstruct)])
;          [history (yield-star tm INITIAL-TAPE #:silent #t)])
;     (when (not (silent?))
;       (writeln (string-join (history->string-list history) "\n")))
;    (decide tm history)
    (printf "tm=~s\n" tm)
    )

  ; (printf "~a\n" (yield-star (parse PDM-LINES) (tape) #:silent (silent?)))  ; print the result to stdout
)

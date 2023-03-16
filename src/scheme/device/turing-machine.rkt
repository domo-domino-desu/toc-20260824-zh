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

(define (epsilon-closure I)
  (make-hash))

;; ===== Instruction
(struct instructionstruct (presentstate presenttoken nexttoken nextstate))


;; ===== Parse
; The defn says Delta maps Q x (Sigma union {B, epsilon}) to  Q x Gamma^* (or Gamma for deterministic ones)
; I interpret members of Q as natural numbers,
;             members of Sigma union {B, epsilon} as strings with at least one a-z or ] or [ or ) or (,
;               or the string EPS (for epsilon) in the nondeterministic case
;             members of Gamma * as a list "( ... )" where the ... is a space-separated list of members of Gamma 
(define INSTRUCTION-LINE-REGEXP #px"^\\s*(\\d+)\\s*([a-zB0-9\\]\\[\\)\\(]+|EPS)\\s*([a-zBLR0-9\\]\\[\\)\\(]+)\\s*(\\d+)\\s*(\\#.*)?$")

; list of four strings -> instruction
; Turn the list of strings m into an instruction
(define (parse-make-instruction string-list)
  (let ([present-state (string->number (first string-list))]
        [present-tape-token (second string-list)]
        [next-token (third string-list)]
        [next-state (string->number (fourth string-list))])
    (instructionstruct present-state present-tape-token next-token next-state)))

;; string -> list of two lists
;;  Return either an instruction or a list of integers, not both.  It can be that both lists are empty.
(define (parse-one-line lne)
    ;(printf "parse-one-line: lne=~s\n" lne)
    (cond
      [(regexp-match? EMPTY-LINE-REGEXP lne)
       (list inst final-states)]
      [(regexp-match? INSTRUCTION-LINE-REGEXP lne)
       (let ([m (regexp-match* INSTRUCTION-LINE-REGEXP lne #:match-select cdr)])
         (list (parse-make-instruction (car m)) '()))]
      [(regexp-match? FINAL-STATES-REGEXP lne)
       (let ([m (regexp-match* FINAL-STATES-REGEXP lne #:match-select cdr)])
         (list '() (parse-final-states (car m))))]
      [else
       (begin
         (printf "ERROR! line does not parse: ~s" lne)
         (list '() '()))]))
  
;;; list of strings -> Turing machine
;(define (parse file-lines)
;  (let ([tm (machine-create)])
;    ; (printf "  parse: pdm=~s\n" pdm)
;    (for* ([line file-lines])
;      ;(printf "parse: line=~s\n" line)
;      ; (printf "    parse-one-line=~s\n" (parse-one-line line))
;       (let* ([inst-and-states (parse-one-line line)]
;              [inst (first inst-and-states)]
;              [state-list (second inst-and-states)])
;        ;(printf "    parse: inst-and-states=~s\n" inst-and-states)
;        ;(printf "    parse: (first inst-and-states)=~s\n" (first inst-and-states))
;        ;(printf "    parse: inst=~s  state-list=~s\n" inst state-list)
;        (if (not (null? inst))
;            (machine-add-instruction tm inst)
;            (for ([accepting-state state-list])
;              (machine-add-accepting-state tm accepting-state)))
;        ; (printf "  parse: pdm=~s\n" pdm)))
;    )) tm)
;  )


;; ========================================================
;; Read command line.

(define verbose? (make-parameter #f))
(define filename (make-parameter null))
(define startchar (make-parameter (make-string 1 BLANK)))  ;; string with one char, head points to this char first
(define startleft (make-parameter ""))  ;; string giving tape left of the start char
(define startright (make-parameter ""))  ;; string giving tape right of start char
(define steplimit (make-parameter "-1")) ;; max number of steps simulator runs; a negative makes it run until done

(define command-line-parser
  (command-line
   #:usage-help 
   "Simulate a Turing machine."
   "Put instructions of the form `state-number current-char action-char next-state-number' on separate lines."
   #:once-each
   [("-v" "--verbose") "Verbose mode" (verbose? #t)]
   [("-f" "--filename") fn "Name of file with the Turing machine" (filename fn)]
   [("-c" "--char") sc "Character the head points to at start" (startchar sc)]
   [("-l" "--left") sl "String giving tape left of the start character" (startleft sl)]
   [("-r" "--right") sr "String giving tape right of the start character" (startright sr)]
   [("-s" "--steplimit") slmt "Number giving max number of steps to run (negative for run until halt)" (steplimit slmt)]
   #:args  () (void)))


;; Default initial configuration
(define INITIAL-CONFIG (make-config 0
                                    (current-symbol-string->char (startchar))
                                    (string->list (startleft))
                                    (string->list (startright))))  ;; TODO need the position?

;; For running from the command line; this is the Racket construct to execute code from
;; command line but not from an importing module
(module+ main
  ; (display "Running main\n")
  ;; Read command line arguments  
  (command-line
   #:usage-help 
   "Simulate a Turing machine."
   "Put instructions of the form `state-number current-char action-char next-state-number' on separate lines."
   #:once-each
   [("-v" "--verbose") "Verbose mode" (verbose? #t)]
   [("-f" "--filename") tmfn "Name of file with the Turing machine" (tm-filename tmfn)]
   [("-c" "--char") sc "Character the head points to at start" (startchar sc)]
   [("-l" "--left") sl "String giving tape left of the start character" (startleft sl)]
   [("-r" "--right") sr "String giving tape right of the start character" (startright sr)]
   [("-s" "--steplimit") slmt "Number giving max number of steps to run" (steplimit slmt)]
   #:args  () (void))

  ;; Read the file with the TM instructions
  (define TM-LINES '())  ;; list of file lines, one string per instruction
  (if (null? (tm-filename))
    (set! TM-LINES '())
    (set! TM-LINES (file->lines (tm-filename) #:mode 'text #:line-mode 'any)))

  ;; See if the line contains an instruction
  (define (nontrivial-line? line)
    (let ([trimmed-string (string-trim line #:repeat? #t)])
      (if (or (= 0 (string-length trimmed-string))
              (eqv? (string-ref trimmed-string 0) COMMENT-START))
          #f
          #t)))
  
  ;; Return a list of instructions
  (define TM (for/list ([line TM-LINES]
                        #:when (nontrivial-line? line))
               (string->instruction line)))
  
  ;;(display TM)  ; temp for debugging
  ;; Run the simulation
  (define initial-config
    (make-config 0
                 (string-ref (startchar) 0)
                 (string->list (startleft))
                 (string->list (startright))))
  
  (define STEPLIMIT (string->number (steplimit)))
  ; (display "STEPLIMIT is ")(display STEPLIMIT)(newline)
  ; (define VERBOSE (string->number (steplimit)))
  
  (if (>= STEPLIMIT 0)
      (execute-guarded TM initial-config STEPLIMIT)
      (execute TM initial-config))
)

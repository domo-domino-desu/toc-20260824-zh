#lang racket
(require racket/cmdline)

(require "device.rkt")

;; turing-machine.rkt
;; A Turing machine simulation, for Theory of Computation by Hefferon
;; Author: Jim Hefferon  License: GPL
;;
;; Input format: One line per instruction.  Instruction is a space-separated
;; list of four elements:
;;   0) natural number for current state,
;;   1) character for what the head is pointing to on the tape,
;;   2) character for the action (any lower case letter,
;;      or digit, or paren "[" or "]", or "L" or "R" or "EPS"),
;;   3) natural number for the next state.
;; The comment character is #.  You can have a line that is just a comment,
;; or you can end a valid line with a comment.  You can also indent lines
;; with whitespace.
;;
;; After each step, the machine prints out a picture of the tape with the
;; current char between asterisks.
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
         instructionstruct-presentstate
         instructionstruct-presenttoken
         instructionstruct-nexttoken
         instructionstruct-nextstate
         instruction->string)

;; ===== Configuration
(struct configurationstruct (state tape) #:transparent #:mutable)

;; configuration-> string
;; Return a string representing the configuration, for output and debugging
(define (configuration->string config
                               #:show-current-blank [show-current-blank #f] ; on tape if current is " " then show B
                               #:show-all-blank [show-all-blank #f])   ; on tape show all " "'s to B's
  (if (not (configurationstruct? config))
      (cond
        [(equal? config HALT) "Halt"]
        [(equal? config ERROR) "Error"]
        [else "unknown config"])
      (let* ([state-number (configurationstruct-state config)]
             [state-string (string-append "q" (number->string state-number))]
             [tape (configurationstruct-tape config)])
        (string-append state-string ": " (tape->string tape
                                                       #:show-current-blank show-current-blank
                                                       #:show-all-blank show-all-blank)))))

(provide configurationstruct
         configurationstruct-state
         configurationstruct-tape
         configuration->string)

;; ========= Turing machines

;; void  -> void
;; Create a new machine
(define (tm-create)
  (machine-create))

;; machinestruct, list  ->  void
;; Add an instruction to the list in the machine
(define (tm-add-instruction tm instruction)
  (machine-add-instruction tm instruction))

;; machinestruct, natural number  ->  void
;; Add an accepting state to the list inside the machine
(define (tm-add-accepting-state tm accepting-state)
  (machine-add-accepting-state tm accepting-state))

;; machinestruct, natural number, natural number
;; Add the epsilon move to the list inside the machine
(define (tm-add-epsilon tm key value)
  (machine-add-epsilon tm key value))

;; machinestruct -> string
;; Return a representation of the Turing machine
(define (tm->string tm)
  (machine->string tm instruction->string))

;; delta-map -> list of integers
;; From the delta map, get a list of all the machine's states.
;; On the list are states used only in the output.
(define (all-states-get delta-map epsilon-map)
  ; (printf "all-states-get delta-map=~s\n" (delta-map->string delta-map))
  (let ([input-states (map first (hash-keys delta-map))]
        [delta-range-sets (hash-values delta-map)]
        [epsilon-range-sets (hash-values epsilon-map)]
        [output-states (mutable-set)])
    (for* ([range-set delta-range-sets]
           [tuple range-set])
      (set-add! output-states (second tuple)))
    ; (printf "all-states-get output-states=~s\n" (set->string output-states))
    (for ([range-set epsilon-range-sets])
      ; (printf "    all-states range-set=~s\n" (set->string range-set))
      (set-union! output-states range-set))
      ; (printf "        now: output-states=~s\n" (set->string output-states))
    (sort (remove-duplicates (append input-states (set->list output-states))) <)))

;; For Turing machines, Delta maps Q x Sigma -> (Sigma union {L,R}) x Q.
(define (tm->delta-map tm)
  (let ([delta-map (delta-map-make)]
        [instructions (machinestruct-instructions tm)])
    (for ([inst instructions])
      (let ([key (list (instructionstruct-presentstate inst) (instructionstruct-presenttoken inst))]
            [value (list (instructionstruct-nexttoken inst) (instructionstruct-nextstate inst))])
        (delta-map-set! delta-map key value)))
    delta-map))

;; tapestruct, string, natural number -> configurationstruct
;; Perform one transition on the Turing machine
(define (tm-transition tape next-action next-state)
  (cond
    [(equal? next-action RIGHT)
     (configurationstruct next-state (move-head-right tape))]
    [(equal? next-action LEFT)
     (configurationstruct next-state (move-head-left tape))] 
    [else
     (configurationstruct next-state (change-head-token tape next-action))])
  )

;; hash, list  ->  list
;; Return list of next configurations related to the input config by `yields'
;; via the delta map (without epsilon)
(define (delta-yields delta-map config)
  (let* ([current-state (configurationstruct-state config)]
         [tape (configurationstruct-tape config)]
         [current-token (get-tape-current tape)]
         [next-set (delta
                    delta-map
                    (list current-state current-token))]) ; a set or DELTA-NOKEY
    (if (equal? next-set DELTA-NOKEY)
        (mutable-set)  ; nondeterministic can have no key, return empty set
        (for/mutable-set ([next-action-and-state next-set])
          (tm-transition tape
                         (first next-action-and-state)
                         (second next-action-and-state))))))

;; hash, list  ->  list
;; Return list of next configurations related to the input config by `yields'
;; via epsilon moves.
(define (epsilon-yields epsilon-closure config)
  (let* ([current-state (configurationstruct-state config)]
         [tape (configurationstruct-tape config)]
         [eps-states (epsilon-closure-get epsilon-closure current-state)])
    (for/mutable-set ([next-state eps-states])
      (configurationstruct next-state tape))))

; It is easier to follow if I connect parent and child
;(define (yields config delta-map epsilon-closure)
;  (let* ([delta-config-set (delta-yields delta-map config)]
;         [config-set (mutable-set)])
;    (for ([delta-config delta-config-set])
;      (set-union! config-set (epsilon-yields epsilon-closure delta-config)))
;    config-set))

;; history-node, hash, hash  ->  set of history-nodes
;; To the history node add children whose config is related 
;; by a yields relation using delta (no epsilons; this is a half-step)
;; followed by epsilon moves (this is a full-step).
;; Return the set of those full-step history nodes.
(define (one-step! history-node delta-map epsilon-closure)
  (let ([half-step-node-set (mutable-set)]  ; nodes after delta map
        [full-step-node-set (mutable-set)]) ; nodes after epsilon map
    ; First: apply delta-yields to history node's config, add each as child
    (let* ([config (history-node-config history-node)]
           [delta-config-set (delta-yields delta-map config)])
      (for ([delta-config delta-config-set])
        (set-add! half-step-node-set
                  (child-node-add! history-node delta-config))))
    ; Second: for each derived node apply epsilon-yields, add each as child
    (for ([half-step-node half-step-node-set])
      (let* ([config (history-node-config half-step-node)]
             [epsilon-yields-set (epsilon-yields epsilon-closure config)])
        (for ([epsilon-config epsilon-yields-set])
          (set-add! full-step-node-set
                    (child-node-add! half-step-node epsilon-config)))))
    full-step-node-set))


(provide tm-create
         tm-add-instruction
         tm-add-accepting-state
         tm-add-epsilon
         tm->string
         all-states-get
         tm->delta-map
         tm-transition
         delta-yields
         epsilon-yields
         ; yields
         one-step!
         )


;; ===== Run

(define MAXIMUM-TURING-MACHINE-RANK 100)

(define (computation-history-helper level-nodelist rank-number delta-map epsilon-closure #:maxrank [maximumrank MAXIMUM-TURING-MACHINE-RANK])
  (printf "******> calling computation-history-helper\n")
  (printf "  level-nodelist=~s\n  rank-number=~s\n" level-nodelist rank-number)
  (when (< rank-number maximumrank)
    (let ([next-level '()])
      (for ([node level-nodelist])
        (printf "     ** node is ~s\n" node)
        (set! next-level
              (append (one-step-one-node node delta-map epsilon-closure) next-level)) ; side-effect runs computations 
          )
      (printf "  next-level=~s\n" next-level)
      (when (not (null? next-level))
        (computation-history-helper next-level (+ 1 rank-number) delta-map epsilon-closure #:maxrank maximumrank)))))

(define (computation-history-make turing-machine initial-tape #:maximumrank [maximumrank MAXIMUM-RANK])
  (let* ([delta-map (tm->delta-map turing-machine)]
         [epsilon-map (machinestruct-epsilonmap turing-machine)]
         [all-states (all-states-get delta-map epsilon-map)]
         [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
         [current-state 0]
         [initial-config (configurationstruct current-state initial-tape)]
         [initial-history-node (history-create initial-config)])
    (computation-history-helper (list initial-history-node) 0  delta-map epsilon-closure #:maxrank maximumrank)
    initial-history-node))

(provide computation-history-make)

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
(define startchar (make-parameter BLANK))  ;; string with one char, head points to this char first
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
  (let* ([tm (parse INPUT-LINES INSTRUCTION-LINE-REGEXP parse-make-instruction instructionstruct)]
         [delta-map (tm->delta-map tm)]
         [epsilon-map (machinestruct-epsilonmap tm)]
         [epsilon-closure (epsilon-closure-make epsilon-map (all-states-get delta-map epsilon-map))])
;          [history (yield-star tm INITIAL-TAPE #:silent #t)])
;     (when (not (silent?))
;       (writeln (string-join (history->string-list history) "\n")))
;    (decide tm history)
    (printf "tm=~s\n" tm)
    )

  ; (printf "~a\n" (yield-star (parse PDM-LINES) (tape) #:silent (silent?)))  ; print the result to stdout
)

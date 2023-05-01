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
         instructionstruct-presentstate
         instructionstruct-presenttoken
         instructionstruct-nexttoken
         instructionstruct-nextstate
         instruction->string)

;; ===== Configuration
(struct configurationstruct (state tape) #:transparent #:mutable)

;; configuration-> string
;; Return a string representing the tape, for output and debugging
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

;; ===== History

;; history-node -> string
;; Generate string to show one history node.
;;  #:deterministic  Boolean  Do not show tree nesting  
(define (node->string node rank #:deterministic [deterministic #t])
  ; (printf "node->string  node=~s  rank=~s\n" node rank)
  (let* ([r (for/list ([i (in-range 2 (+ 1 rank))]) " |  ")]
         [prefix (if (= rank 0) "" " +--")]
         ; [test0 (printf "  node->string r=~s\n" r)]
         ; [test1 (printf "  node->string prefix=~s\n" prefix)]
         ; [test2 (printf "  node->string (append prefix (list r))=~s\n" (append r (list prefix)))]
         [nesting (if deterministic "" (apply string-append (append r (list prefix))))])
    ; (printf "    node->string nesting=~s\n" nesting)
    ; (printf "    (history-node-config node)=~s\n" (history-node-config node))
    ; (printf "    node->string (configuration->string (history-node-config node))=~s\n" (configuration->string (history-node-config node)))
    (apply string-append (list nesting (configuration->string (history-node-config node)))))
    )

;; history tree node -> string
;;  Return reasonable description of tree
;; #:maxrank  Integer  Don't go into any node deeper than this
;; #:fullstep-only  Boolean  Don't show the half steps from following epsilon maps
;; #:deterministic  Boolean  Don't show tree nesting
(define ACCUMULATOR '())  ; Store list of node strings (There must be a better way to do this)

(define (history->string history
                         #:maxrank [maximumrank MAXIMUM-RANK]  ; don't go deeper than this
                         #:fullstep-only [fullstep-only #f]  ; don't show odd-numbered ranks   
                         #:deterministic [deterministic #t])  ; don't show nesting and don't show odd-numbered ranks 
 (define (h->s node rank
               #:maxrank [maximumrank MAXIMUM-RANK]
               #:fullstep-only [fullstep-only #f]
               #:deterministic [deterministic #t])
    ; (printf "  h->s: node ~s  rank=~s\n"
    ;         (configuration->string (history-node-config node)) rank)
   (when deterministic
     (set! fullstep-only #t))
   (when (< rank maximumrank)
     (let ([children (history-node-get-children node)])
       (for ([child children])
         (when (or (and fullstep-only (even? rank))
                   (not fullstep-only))
           ; (printf "   h->s: child is ~s\n" (configuration->string (history-node-config child)))
           (set! ACCUMULATOR (cons (node->string child rank #:deterministic deterministic) ACCUMULATOR)))
         (h->s child (+ rank 1 ) #:maxrank maximumrank #:deterministic deterministic)))))
  
  (set! ACCUMULATOR (list (node->string history 0)))
  (h->s history 1 #:maxrank maximumrank #:fullstep-only fullstep-only #:deterministic deterministic)
  (string-join (reverse ACCUMULATOR) "\n"))
  
 
(provide node->string
         history->string)

  
;; ===== Run

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
        [output-states (mutable-seteq)])
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

;; history-node delta-map epsilon-closure -> list of nodes
;; From a history node, find all descendents via the delta-map, then take epsilon closure.  Return list of
;;   the grandchild nodes, the ones post-epsilon moves.
(define (one-step-one-node history-node delta-map epsilon-closure)
  (printf "======== one-step-one-node called\n")
  ;(printf "in one-step-one-node history=~a\n" (history->string history-node))
  ;(printf "                     delta-map=~s\n" (delta-map->string delta-map))
  (let* ([config (history-node-config history-node)]
         [current-state (configurationstruct-state config)]
         [tape (configurationstruct-tape config)]
         [current-token (get-tape-current tape)]
         [next (delta delta-map (list current-state current-token))] ; a set or DELTA-NOKEY
         [non-epsilon-nodes '()]
         [epsilon-nodes '()])
    (printf "                     (current-state current-token)=~s\n" (list current-state current-token))
    (printf "                     about to do delta map history-node=~a\n" (history->string history-node))
    ; Apply delta-map to get single transition
    (if (equal? next DELTA-NOKEY)
        '()
        (begin
          ; Take all delta transitions
          ; Add to the history-node a bunch of child nodes, one for each next state in the delta map
          (for ([next-action-and-state next])
            (printf "  delta transitions: next-action-and-state=~s\n" next-action-and-state)
            (printf "  delta transitions: about to let* history-node=\n~a\n" (history->string history-node))
            (let* ([next-action (first next-action-and-state)]
                   [next-state (second next-action-and-state)]
                   ; [kkk (printf "        about to define next-config history-node=~a\n" (history->string history-node))]
                   [next-config (tm-transition tape next-action next-state)]
                   ; [kkk (printf "        about to define next-node history-node=~a\n" (history->string history-node))]
                   [next-node (history-node-make next-config)])
              (printf "  delta transitions:next-config=~s\n" (configuration->string next-config))
              (printf "  delta transitions:about to do history-node-add! history-node=\n~a\n" (history->string history-node))
              (history-node-add! history-node next-node) 
              (set! non-epsilon-nodes (cons next-node non-epsilon-nodes))))
          (printf "   about to do epsilon transitions, history-node is \n~a\n" (history->string history-node #:deterministic #f))
          ; Take epsilon transitions
          ; add to the next-nodes from the prior step a bunch of child nodes, one for each state in the epsilon-clousre
          (printf "    taking epsilon transistions: non-epsilon-nodes=~s\n" (map (lambda (x) (configuration->string (history-node-config x))) non-epsilon-nodes))
          (for ([next-node non-epsilon-nodes])
            (printf "        taking epsilon transistions: next-node=~s\n" (configuration->string (history-node-config next-node)))
            (printf "        taking epsilon transistions: next-node as string=~s\n" (history->string next-node))
            (printf "        taking epsilon transistions: (set-member? (cdr history-node) next-node)=~s\n" (set-member? (cdr history-node) next-node))
            (let* ([config (history-node-config next-node)]
                   [current-state (configurationstruct-state config)]
                   [tape (configurationstruct-tape config)]
                   [eps-states (hash-ref epsilon-closure current-state)])
              (printf "        taking epsilon transistions: config=~s\n" (configuration->string config))
              (for ([s eps-states])
                (printf "            taking epsilon transistions: epsilon state s=~s\n" s)
                (let* ([epsilon-config (configurationstruct s tape)]
                       [epsilon-node (history-node-make epsilon-config)])
                  (printf "            taking epsilon transistions: before history-node-add! (set-member? (cdr history-node) next-node)=~s\n" (set-member? (cdr history-node) next-node))
                  (history-node-add! next-node epsilon-node)
                  ;(printf "            taking epsilon transistions: after history-node-add! (set-member? (cdr history-node) next-node)=~s\n" (set-member? (cdr history-node) next-node))
                  ;(printf "            taking epsilon transistions: after adding, next-node is \n~s\n" (history->string next-node #:deterministic #f))
                  ;(printf "            taking epsilon transistions: after adding, history-node is \n~s\n" (history->string history-node #:deterministic #f))
                  (set! epsilon-nodes (cons epsilon-node epsilon-nodes))
                  ))
              )
            )
        ))
    epsilon-nodes))


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

(define (computation-history-make turing-machine initial-tape #:maxrank [maximumrank MAXIMUM-RANK])
  (let* ([delta-map (tm->delta-map turing-machine)]
         [epsilon-map (machinestruct-epsilonmap turing-machine)]
         [all-states (all-states-get delta-map epsilon-map)]
         [epsilon-closure (epsilon-closure-make epsilon-map all-states)]
         [current-state 0]
         [initial-config (configurationstruct current-state initial-tape)]
         [initial-history-node (history-create initial-config)])
    (computation-history-helper (list initial-history-node) 0  delta-map epsilon-closure #:maxrank maximumrank)
    initial-history-node))



(provide all-states-get
         tm->delta-map
         tm->string
         tm-transition
         one-step-one-node
         computation-history-make)

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

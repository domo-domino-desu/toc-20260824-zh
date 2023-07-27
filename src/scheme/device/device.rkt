#! /usr/bin/env racket
#lang racket

;; device.rkt
;;
;; Simulation of devices for Jim Hefferon's _Theory of Computation_
;; License: GPL 3.0

;; Return codes
(define LIMIT-REACHED -3) ;; more steps taken than allowed 
(define ERROR -2) ;; some problem with computation
(define HALT -1) ;; machine halted
(provide HALT
         ERROR
         LIMIT-REACHED)

;; Convenient constants; strings are easier than characters
(define BLANK "B")  ;; Easier to read than space
(define STROKE "1")  ;;  
(define LEFT "L") ;; Move tape pointer left
(define RIGHT "R") ;; Move tape pointer right
(define EPSILON "EPS") ;; symbol for Epsilon on tape and delta-map

(provide BLANK
         STROKE
         LEFT
         RIGHT
         EPSILON)


;; set -> string
;; Show a set in a readable way
;; The optional argument allows you to format the elements 
(define (set->string s [elet->string (lambda (x) (format "~a" x))])
  (string-join (map elet->string (set->list s))
               #:before-first "{ "
               #:after-last " }"))


;; ===== POWER-MAP
;; All three of delta maps, epsilon maps, and epsilon closure maps send keys
;;   to sets of values.


;; void -> hash
;; Make a new finite function key -> set of values
(define (power-map-make)
  (make-hash))

;; list, list -> void
;; Add the value to the set that is power-map[k], or if no set there
;; create a new set containing v
(define (power-map-set! power-map k v)
  (if (member k (hash-keys power-map))
      (set-add! (hash-ref power-map k) v)
      (hash-set! power-map k (mutable-set v))))

;; Signifies that a power-map has no such key
(define POWER-MAP-NOKEY "No such key")

;; list -> list
;; Return value associated with k in the power-map, or POWER_MAP-NOKEY
(define (power-map-get power-map k [error POWER-MAP-NOKEY])
  (hash-ref power-map k (lambda () error)))

;; hash -> string
;; Show a power-map in a readable way
;; The optional arguments allow you to format the key and the value
(define (power-map->string power-map
                           [key->string (lambda (x) (format "~a" x))]
                           [value->string (lambda (x) (format "~a" x))])
  (let* ([keys (hash-keys power-map)])
    (apply string-append (for/list ([k keys])
                           (format "~a -> ~a\n"
                                   (key->string k)
                                   (set->string (hash-ref power-map k)
                                                value->string))))))

(provide power-map-make
         power-map-set!
         POWER-MAP-NOKEY
         power-map-get
         set->string
         power-map->string)


;; ===== DELTA
;; Finite function mapping lists to sets.  The lists are input tuples, the
;; sets contain output tuples 

;; void -> hash
;; Make a new delta be a new hash
(define (delta-map-make)
  (power-map-make))

;; list, list -> void
;; Add the value to the set that is delta-map[k], or create a new set if
;; none there
(define (delta-map-set! delta-map key value)
  (power-map-set! delta-map key value))

;; Signifies delta map has no such key
(define DELTA-NOKEY "No such key for delta map")

;; list -> list
;; Return value associated with k in DELTA, or DELTA-NOKEY
(define (delta delta-map k)
  (power-map-get delta-map k DELTA-NOKEY))

;; hash -> string
;; Show a delta-map in a readable way
(define (delta-map->string delta-map
                           [key->string (lambda (x) (format "~a" x))]
                           [value->string (lambda (x) (format "~a" x))])
  (power-map->string delta-map key->string value->string))


(provide delta-map-make
         delta-map-set!
         DELTA-NOKEY
         delta
         delta-map->string)


;; ===== EPSILON MAP
;; Finite function mapping a state numbers to sets of state numbers.  The
;; meaning is that there is an epsilon transision from the input state to
;; all states in the output set.  

;; void -> hash
;; Make a new epsilon map
(define (epsilon-map-make)
  (power-map-make))

;; list, list -> void
;; Add the value to the set that is epsilon-map[k], or create a new set if none is there
(define (epsilon-map-set! epsilon-map key value)
  (power-map-set! epsilon-map key value))

;; Signifies the epsilon map has no such key
(define EPSILON-NOKEY "No such key for epsilon map")

;; list -> list
;; Return value associated with k in DELTA, or DELTA-NOKEY
(define (epsilon-map-get epsilon-map key)
  (power-map-get epsilon-map key EPSILON-NOKEY))

;; hash -> string
;; Show a epsilon-map in a readable way
(define (epsilon-map->string epsilon-map)
  (power-map->string epsilon-map))

;; epsilon-map, list of natural numbers -> power-map
;; Find the epsilon closure of the epsilon map
(define (epsilon-closure-make epsilon-map all-states)
  (let ([epsilon-closure (power-map-make)])
    ; First start building E(q) with E(q,0)= { q }
    (for ([q all-states])
      (power-map-set! epsilon-closure q q))
    ; (printf "epsilon-closure-make epsilon-closure initial ~s\n" epsilon-closure)
    ; Now where E(q,i)={q_i0, .. q_ik}, set
    ;   E(q,i+1)= E(q,i) union Delta(q_i0,epsilon)
    ;                    union ... Delta(q_ik,epsilon)
    ; Keep it up until i is such that for all q we have E(q,i)=E(q,i+1)
    (let ([change-flag #t])
      (do ([i 1 (+ 1 i)])
        ((or (> i (length all-states)) (not change-flag))
         (when change-flag
           (printf "ERROR: Epsilon closure took too many steps ~a\n" i)))
        (set! change-flag #f)
        (for ([q all-states])
          ; (printf "epsilon-closure-make q=~s\n  (power-map-get epsilon-closure q)=~s\n" q (power-map-get epsilon-closure q))
          (let* ([E-q-i (power-map-get epsilon-closure q)]
                 [E-q-iplus1 E-q-i])
            (for ([s E-q-i])
              (when (set-mutable? (epsilon-map-get epsilon-map s))
                (set-union! E-q-iplus1 (epsilon-map-get epsilon-map s)))) 
            (when (not (set=? E-q-i E-q-iplus1))
              (set! change-flag #t))))))
      epsilon-closure))

;; epsilon-closure -> string
;; Give a reasonable representation
(define (epsilon-closure->string epsilon-closure)
  (power-map->string epsilon-closure))

(provide epsilon-map-make
         epsilon-map-set!
         EPSILON-NOKEY
         epsilon-map-get
         epsilon-map->string
         epsilon-closure-make
         epsilon-closure->string )

;; ===== tape

;; A tape is a struct.
(struct tapestruct (left current right) #:transparent #:mutable)

; list of strings  ->  tapestruct
; Make a tape structure. If there are tape tokens then the I/O head points
; to the first one while the rest are on the right tape.  Otherwise the
; I/O head points to BLANK.
(define (make-tape . tape-tokens)
  ; (printf "make-tape: tape-tokens are ~s\n" tape-tokens)
  (let ([tape (tapestruct '() BLANK '())])
    (when (not (null? tape-tokens))
      (set-tapestruct-current! tape (car tape-tokens))
      (set-tapestruct-right! tape (cdr tape-tokens)))
    tape))

;; tape structure, list of strings, string, list of strings -> tape structure
;; Change the tape to have the given left, current, and right
(define (set-tape! tape left current right)
  (set-tapestruct-left! tape left)
  (if (equal? current "")
        (set-tapestruct-current! tape BLANK)
        (set-tapestruct-current! tape current))
  (set-tapestruct-right! tape right)
  tape)

;; void -> void
;; Get the left tape, the current token, or the right tape 
(define (get-tape-left tape)
  (tapestruct-left tape))
(define (get-tape-current tape)
  (tapestruct-current tape))
(define (get-tape-right tape)
  (tapestruct-right tape))

;; list of strings -> list of strings
;; Omit leftmost " " or "B" tokens
(define (trim-left-tape t)
  (cond
    [(null? t) t]
    [(and
      (not (equal? (car t) " "))
      (not (equal? (car t) BLANK)))
     t]
    [else (trim-left-tape (cdr t))]))

;; list of strings -> list of strings
;; Omit rightmost " " or "B" tokens
(define (trim-right-tape t)
  (reverse (trim-left-tape (reverse t))))

;; tape -> tape
;; Trim any extra " " or "B" off the left tape or right tape 
(define (trim-tape tape)
  (let ([tape-left (get-tape-left tape)]
        [tape-current (get-tape-current tape)]
        [tape-right (get-tape-right tape)])
    (set-tape! tape
               (trim-left-tape tape-left)
               tape-current
               (trim-right-tape tape-right))))

;; tape -> tape
;; Return a new tape where the head has been moved right on the tape structure.  Same as moving the tape left.
(define (move-head-right tape)
  (let* ([tape-left (get-tape-left tape)]
         [tape-current (get-tape-current tape)]
         [tape-right (get-tape-right tape)]
         [new-tape-left (reverse (cons tape-current (reverse tape-left)))]
         [new-tape-current (if (null? tape-right) BLANK (car tape-right))]
         [new-tape-right (if (null? tape-right) '() (cdr tape-right))])
;    (printf "in move-head-right: tape-current=~s\n" tape-current)
;    (printf "in move-head-right: new-tape-left=~s\n" new-tape-left)
;    (printf "in move-head-right: new-tape-current=~s\n" new-tape-current)
;    (printf "in move-head-right: new-tape-right=~s\n" new-tape-right)
;    (when (not (null? tape-right))
;      (set! new-tape-current (car tape-right))
;      (set! new-tape-right (cdr tape-right)))
    (tapestruct new-tape-left new-tape-current new-tape-right)
    ))

;; tape -> tape
;; Return a new tape where the head has been moved left on the tape structure.  Same as moving the tape right.
(define (move-head-left tape)
  (let* ([tape-left (get-tape-left tape)]
         [tape-current (get-tape-current tape)]
         [tape-right (get-tape-right tape)]
         [new-tape-left '()]
         [new-tape-current BLANK]
         [new-tape-right (cons tape-current tape-right)])
    (when (not (null? tape-left))
        (let ([reversed-tape-left (reverse tape-left)])
          (set! new-tape-current (car reversed-tape-left))
          (set! new-tape-left (reverse (cdr reversed-tape-left)))))
    (tapestruct new-tape-left new-tape-current new-tape-right)
    ))

;; tape -> tape
;; Return a new tape where there is a new token being pointed to by the
;; I/O head
(define (change-head-token tape new-tape-current)
  (let* ([tape-left (get-tape-left tape)]
         [tape-right (get-tape-right tape)])
    (tapestruct tape-left new-tape-current tape-right)
    ))

; tapestruct -> string
; Show the tape with characters space-separated.  The I/O head's location
; is surrounded by *'s.
(define (tape->string tape
                      #:show-current-blank [show-current-blank #f] ; if current is " " then show B
                      #:show-all-blank [show-all-blank #f])   ; translate all " "'s to B's
  (let* ([left-string (apply string-append (tapestruct-left tape))]
         [right-string (apply string-append (tapestruct-right tape))]
         [current-string (tapestruct-current tape)])
    (cond
      [show-current-blank
       (when (equal? current-string " ")
         (set! current-string BLANK))]
      [show-all-blank
       (set! left-string (apply string-append
                                (map (lambda (x) (if (equal? x " ") BLANK x))
                                     (tapestruct-left tape))))
       (set! right-string (apply string-append
                                 (map (lambda (x) (if (equal? x " ") BLANK x))
                                      (tapestruct-right tape))))
       (when (equal? current-string " ")
         (set! current-string BLANK))])
    (string-append left-string
                   (string-append "*" current-string "*")
                   right-string)))

(provide tapestruct
         BLANK
         make-tape
         set-tape!
         get-tape-left
         get-tape-current
         get-tape-right
         trim-left-tape
         trim-right-tape
         trim-tape
         move-head-left
         move-head-right
         change-head-token
         tape->string)


;; ===== stack

;; A stack is a list of strings, where the car is the top of the stack

(define BOT "BOT")  ;; Stack bottom
(define STACK-EXHAUSTED "stack exhausted")  ;; Attempt to read an empty stack

; list of strings -> stack-list
; Make a stack, ending with a bottom marker
(define (make-stack . stack-tokens)
  (append stack-tokens (list BOT)))

; stack-list ->  stack-list or STACK-EXHAUSTED
; Pop the top token off the stack.  Return STACK-EXHAUSTED if stack is empty.
(define (stack-pop stack-list)
  (if (null? stack-list)
      STACK-EXHAUSTED
      (cdr stack-list)))

; stack-list ->  string or STACK-EXHAUSTED
; Name top token on the stack, without popping.  Return STACK-EXHAUSTED if
; stack is empty.
(define (stack-top stack-list)
  (if (null? stack-list)
      STACK-EXHAUSTED
      (first stack-list)))

; string stack-list ->  stack-list
; Push a new top token onto the stack.
(define (stack-push ch stack-list)
  (cons ch stack-list))

; string-list stack-list ->  stack-list
; Push the list of tokens onto the stack.
(define (stack-push-list token-list stack-list)
  (append token-list stack-list))

; stack-list -> bool
; Decide if the stack's top token is BOT, that is, whether the stack is
; exhausted.
(define (stack-bot? stack-list)
  (equal? BOT (car stack-list)))

(provide BOT
         STACK-EXHAUSTED
         make-stack
         stack-pop
         stack-top
         stack-push
         stack-push-list
         stack-bot?)


;; ===== Machine
;; A machine is a structure consisting of list of instructions and list of
;; accepting states.
(struct machinestruct (instructions acceptingstates epsilonmap)
  #:transparent #:mutable)

; no input  ->  machinestruct
; Create an empty machine.
(define (machine-create)
  (machinestruct '() (mutable-seteq) (epsilon-map-make)))

; machinestruct, instruction  ->  machinestruct
; Add the instruction to the machine
(define (machine-add-instruction machine instruction)
  (set-machinestruct-instructions!
   machine
   (reverse (cons instruction
                  (reverse (machinestruct-instructions machine))))))

; machinestruct, natural-number  ->  machinestruct
; Add the accepting state to the machine 
(define (machine-add-accepting-state machine accepting-state)
  (set-add! (machinestruct-acceptingstates machine) accepting-state))

; machinestruct, natural-number, natural-number  ->  machinestruct
; Add the key->value to the epsilon map 
(define (machine-add-epsilon machine key value)
  (epsilon-map-set! (machinestruct-epsilonmap machine) key value))

;; machinestruct -> string
;; Return string of the machine, for display or debugging
(define (machine->string machine
                         [instruction->string (lambda (x) (format "~a" x))])
  (let* ([instruction-string
          (string-join (map instruction->string
                            (machinestruct-instructions machine)) "\n")]
         [accepting-states-string
          (set->string (machinestruct-acceptingstates machine))]
         [epsilon-string
          (epsilon-map->string (machinestruct-epsilonmap machine))]
         [result
          (string-append "INSTRUCTIONS: " instruction-string)])  
    (when (not (set-empty? (machinestruct-acceptingstates machine)))
        (set! result
              (string-append result
                             "\nACCEPTING STATES: "
                             accepting-states-string)))
    (when (not (hash-empty? (machinestruct-epsilonmap machine))) 
        (set! result
              (string-append result
                             "\nEPSILON TRANSITIONS: "
                             epsilon-string)))
    result))

(provide machine-create
         machine-add-accepting-state
         machine-add-instruction
         machine-add-epsilon
         machinestruct?
         machinestruct-instructions
         machinestruct-acceptingstates
         machinestruct-epsilonmap
         machine->string)


;; ===== History
;; A history is a tree of nodes.  Each node is a configuration, along with a
;; collection of child nodes that is a set.

; config  ->  history node
; Make a new node
(define (history-node-make config)
  (cons config (mutable-seteq)))

; history node  ->  config
; Get the node's config
(define (history-node-config n)
  (car n))

; history node  ->  set of child nodes
; Get the node's children.  The set may be empty.
(define (history-node-get-children n)
  (cdr n))

; config  ->  root node of new history tree
; Make a node; the connotation is that it is at the top of a history tree
(define (history-create initialconfig)
  (history-node-make initialconfig))

; history node, history node  ->  history node
; To the first node, add the second node as a child
(define (history-node-add! existing-node new-node)
  (set-add! (cdr existing-node) new-node)
  new-node)

; history node, config  ->  history node
; Use the configuration to create a new node, then add it as a child
; of the first node
(define (child-node-add! existing-node new-child-config)
  (let ([child-node (history-node-make new-child-config)])
    (set-add! (cdr existing-node) child-node)
    child-node))

;; Default for the deepest a history traversal will go
(define MAXIMUM-RANK 100)

; list of nodes, natural number, function  ->  void 
; Helper for history-traverse-bfs
(define (history-traverse-bfs-helper level rank fcn
                                     #:maxrank [maximumrank MAXIMUM-RANK])
  (when (< rank maximumrank)
    (let ([next-level '()])
      (for ([node level])
        (fcn node rank)
        (for ([child-node (history-node-get-children node)])
          (cons child-node next-level)
          ))
      (when (not (null? next-level))
        (history-traverse-bfs next-level (+ 1 rank) fcn)))))

; history node, function  ->  void
; Do a breadth first traversal of the nodes below the given one, applying
; the function to each.  Optionally limit the depth of the traversal  
(define (history-traverse-bfs node fcn #:maxrank [maximumrank MAXIMUM-RANK])
  (history-traverse-bfs [node] 0 fcn #:maximumrank maximumrank))

; history node, natural number, function  ->  void
; Do a depth first traversal of the nodes below the given one (which has
; the given rank), applying the function to each.  Optionally limit the
; depth of the traversal  
(define (history-traverse-dfs node rank fcn
                              #:maxrank [maximumrank MAXIMUM-RANK])
  ; (printf "history-traverse-dfs: node ~s  rank=~s\n" node rank)
  (fcn node rank)
  (when (< rank maximumrank)
    (let ([children (history-node-get-children node)])
      (for ([child children])
        ; (printf "   child is ~s\n" child)
        (history-traverse-dfs child (+ rank 1) fcn #:maxrank maximumrank))
      )))


(provide history-node-make
         history-node-config
         history-node-get-children
         history-create
         history-node-add!
         child-node-add!
         MAXIMUM-RANK
         history-traverse-bfs
         history-traverse-dfs
 )

;; ===== Instruction
(struct dummyinstructionstruct (presentstate presenttoken nexttoken nextstate))


;; ===== Parsing

;; A line with only comment, using # as a comment character
(define EMPTY-LINE-REGEXP #px"^\\s*(\\#.*)?$")

; Need a way to describe epsilon transitions.
(define EPSILON-REGEXP
  #px"\\s*(EPSILON|EPS)[:]?\\s*(\\d+,?)\\s+(\\d+)(\\#.*)?$")

;; string -> list of two numbers
;; Return the numbers that were given as a space-separated list in the string
;; (You can use a comma between numbers, as in "3, 4")
(define (parse-epsilon-transition line)
  (let* ([m (regexp-match* EPSILON-REGEXP line #:match-select cdr)]
         [token-list (car m)]
         [state-from (string->number (second token-list))]
         [state-to (string->number (third token-list))])
    ; (printf "parse-epsilon-transition token-list=~s\n    state-from=~s  state-to=~s\n" token-list state-from state-to)
    (list state-from state-to)))

; Need a way to describe some states as final, or accepting.
(define FINAL-STATES-REGEXP
  #px"\\s*((FINAL)|(ACCEPTING))[:]?\\s*([\\s*\\d+,?]*)\\s*(\\#.*)?$")

; The regular expression used to split the space-separated tokens inside the final states string
(define FINAL-STATES-PARSE-REGEXP #px"(,\\s*)|(\\s+)")

;; string -> list of numbers
;; Return the numbers given as a space-separated list in the string
;; You can use a comma between numbers, as in "3, 4".
(define (parse-final-states line)
  (let* ([m (regexp-match* FINAL-STATES-REGEXP line #:match-select cdr)]
         [token-list (car m)]
         [digit-string (fourth token-list)])
    ;(printf "parse-final-states token-list=~s\n    digit-string=~s\n" token-list digit-string)
    (map string->number
         (string-split (string-trim digit-string)
                       FINAL-STATES-PARSE-REGEXP))))

;; 
(define DUMMY-INSTRUCTION-LINE-REGEXP
  #px"^\\s*(\\d+)\\s*([a-zB0-9\\]\\[\\)\\(]+|EPS)\\s*([a-zBLR0-9\\]\\[\\)\\(]+)\\s*(\\d+)\\s*(\\#.*)?$")

; list of four strings -> instruction
; Turn the list of strings m into an instruction
(define (dummy-parse-make-instruction
         string-list
         [instructionstruct dummyinstructionstruct])
  (let ([present-state (string->number (first string-list))]
        [present-tape-token (second string-list)]
        [next-token (third string-list)]
        [next-state (string->number (fourth string-list))])
    (instructionstruct present-state
                       present-tape-token
                       next-token
                       next-state)))

;; string -> list of three lists
;;  Return a list pertaining to an instruction, and a list of integers
;; that are accepting states, and a list pertaining to epsilon transition.
;; At most one of these lists is not null.  It can be that all lists are null.
(define (parse-one-line lne
                        [instruction-line-regexp DUMMY-INSTRUCTION-LINE-REGEXP]
                        [parse-make-instruction dummy-parse-make-instruction]
                        [instructionstruct dummyinstructionstruct])
    ;(printf "parse-one-line: lne=~s\n" lne)
    (cond
      [(regexp-match? EMPTY-LINE-REGEXP lne)
       (list '() '() '())]
      [(regexp-match? EPSILON-REGEXP lne)
       (list '() '() (parse-epsilon-transition lne))]
      [(regexp-match? instruction-line-regexp lne)
       (let ([m (regexp-match*
                 instruction-line-regexp lne #:match-select cdr)])
         (list (parse-make-instruction (car m) instructionstruct) '() '()))]
      [(regexp-match? FINAL-STATES-REGEXP lne)
         (list '() (parse-final-states lne) '())]
      [else
       (begin
         (printf "ERROR! line does not parse: ~s\n" lne)
         (list '() '()))]))

;; list of strings -> machine
(define (parse file-lines
               [instruction-line-regexp DUMMY-INSTRUCTION-LINE-REGEXP]
               [parse-make-instruction dummy-parse-make-instruction]
               [instructionstruct dummyinstructionstruct] )
  (let ([machine (machine-create)])
    ; (printf "  parse: pdm=~s\n" pdm)
    (for* ([line file-lines])
      ;(printf "parse: line=~s\n" line)
      ; (printf "    parse-one-line=~s\n" (parse-one-line line))
       (let* ([inst-states-eps (parse-one-line line
                                               instruction-line-regexp
                                               parse-make-instruction
                                               instructionstruct)]
              [inst (first inst-states-eps)]
              [state-list (second inst-states-eps)]
              [eps-pair (third inst-states-eps)])
        ;(printf "    parse: inst-and-states=~s\n" inst-and-states)
        ;(printf "    parse: (first inst-and-states)=~s\n" (first inst-and-states))
        ;(printf "    parse: inst=~s  state-list=~s\n" inst state-list)
        (cond
          [(not (null? inst))
            (machine-add-instruction machine inst)]
          [(not (null? state-list))
            (for ([accepting-state state-list])
              (machine-add-accepting-state machine accepting-state))]
          [(not (null? eps-pair))
           (machine-add-epsilon machine (first eps-pair) (second eps-pair))]
        ; (printf "  parse: pdm=~s\n" pdm)))
    ))) machine)
  )


(provide EMPTY-LINE-REGEXP
         EPSILON-REGEXP
         parse-epsilon-transition
         FINAL-STATES-REGEXP
         parse-final-states
         parse-one-line
         parse)
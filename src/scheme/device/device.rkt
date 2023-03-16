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

;; Convenient constants
(define BLANK #\B)  ;; Easier to read than space
(define STROKE #\1)  ;;  
(define LEFT #\L) ;; Move tape pointer left
(define RIGHT #\R) ;; Move tape pointer right
(define EPSILON "EPS") ;; symbol for Epsilon on tape and delta-map

(provide BLANK
         STROKE
         LEFT
         RIGHT
         EPSILON)

;; ===== DELTA
;; Finite function mapping lists to sets.  The lists are input tuples, the
;; sets contain output tuples 

;; void -> hash
;; Make a new delta be a new hash
(define (make-delta-map)
  (make-hash))

;; list, list -> void
;; Add the value to the set that is DELTA[k], or create a new set if none there
(define (set-delta-map! delta-map k v)
  (if (member k (hash-keys delta-map))
      (set-add! (hash-ref delta-map k) v)
      (hash-set! delta-map k (mutable-set v))))

;; Signifies DELTA has no such key
(define DELTA-NOKEY "No such key for delta map")

;; delta-map -> list of integers
;; From the delta map, get a list of all the machine's states
(define (get-states d)
  (sort (remove-duplicates (map first (hash-keys d))) <))

;; list -> list
;; Return value associated with k in DELTA, or DELTA-NOKEY
(define (delta delta-map k)
  (hash-ref delta-map k (lambda () DELTA-NOKEY)))

;; From the key to a delta-map, get the state number
(define (dummy-get-state-fcn k)
  (first k))
;; From the key to a delta-map, get the token
(define (dummy-get-token-fcn k)
  (second k))
;; From the value of a delta-map, get the state number
(define (dummy-get-value-state-fcn k)
  (first k))

;; hash -> hash
;; Return a map taking states from delta-map to their epsilon closure
;; Optional:
;;   get-state-fcn  key for delta-map -> state in that key
;;   get-token-fcn  key for delta-map -> token in that key
;;   get-value-state-fcn  value for delta-map -> state in that value
(define (make-epsilon-closure delta-map
                              [get-state-fcn dummy-get-state-fcn]
                              [get-token-fcn dummy-get-token-fcn]
                              [get-value-state-fcn dummy-get-value-state-fcn])
  (let ([epsilon-closure (make-hash)]  ; maps state number to set that is the epsilon closure
        [all-states (get-states delta-map)]
        [delta-keys (hash-keys delta-map)]
        [change-flag #t]) ; flags that sets changed during the iteration  
    ; Step 0: for all states s in the machine, define E-hat_0(s) = {s}
    (for ([s all-states])
      (hash-set! epsilon-closure s (mutable-set s)))
;    (printf "make-epsilon-closure: delta-map: ~s\n" delta-map)
;    (printf "   epsilon-closure initial: ~s\n" epsilon-closure)
;    (printf "   all-states=~s  delta-keys=~s\n" all-states delta-keys)
    ; Step 1: Besides that E-hat_0(s) subseteq E-hat_1(s), also throw all states t where s --EPS--> t in one hop
;      (printf "    iterating: i=~s  change-flag=~s\n" i change-flag)
    (for* ([key delta-keys]
           [value (delta delta-map key)])
      ;        (printf "    iterating: key=~s   value=~s\n" key value)
      (let* ([key-state (get-state-fcn key)]
             [key-token (get-token-fcn key)]
             [key-state-eps-cl (hash-ref epsilon-closure key-state)]
             [value-state (get-value-state-fcn value)])
        ;          (printf "    let*: key-state=~s   key-token=~s  key-state-eps-cl=~s  value-state=~s\n" key-state key-token key-state-eps-cl value-state)
        (when (and (equal? key-token EPSILON)
                   (not (set-member? key-state-eps-cl value-state)))
          ;            (printf "    not a member: key-state-eps-cl=~s   value-state=~s\n" key-state-eps-cl value-state)
          (set-add! key-state-eps-cl value-state)
          (set! change-flag #t)
          )))
    ; Step i+1: Besides that E-hat_i(a) subseteq E-hat_(i+1)(a), for all s in E-hat_i(a) look at any t that is
    ;         in E-hat_i(s) and add it to E-hat_{i+1}(a)
    (do ([i 0 (+ 1 i)])
      ((or (> i (length all-states)) (not change-flag))
       '())
      (set! change-flag #f)
      (for* ([a all-states]
             [s (hash-ref epsilon-closure a)]
             [t (hash-ref epsilon-closure s)])
        (when (not (set-member? (hash-ref epsilon-closure a) t))
          (set-add! (hash-ref epsilon-closure a) t)
          (set! change-flag #t))
        ))
    epsilon-closure))
  

(provide make-delta-map
         set-delta-map!
         DELTA-NOKEY
         get-states
         delta
         dummy-get-state-fcn
         dummy-get-token-fcn
         make-epsilon-closure)


;; ===== tape

;; A tape is a struct.
(struct tapestruct (left current right) #:transparent #:mutable)

; list of strings  ->  tape structure
; Make a tape structure. The I/O head points to the first token (or BLANK)
(define (make-tape . tape-tokens)
  ; (printf "make-tape: tape-tokens are ~s\n" tape-tokens)
  (let ([tape (tapestruct '() BLANK '())])
    (when (not (null? tape-tokens))
      (set-tapestruct-current! tape (car tape-tokens))
      (set-tapestruct-right! tape (cdr tape-tokens)))
    tape))

;; tape structure, list of strings, string, list of strings -> tape structure
;; Set the tape to have the given left, current, and right
(define (set-tape! tape left current right)
  (set-tapestruct-left! tape left)
  (set-tapestruct-current! tape current)
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
    (set-tape! tape (trim-left-tape tape-left) tape-current (trim-right-tape tape-right))))

;; tape -> string
;; Move the head right on the tape structure.  Same as moving the tape left.  Return the changed tape.
(define (move-head-right tape)
  (let* ([tape-left (get-tape-left tape)]
         [tape-current (get-tape-current tape)]
         [tape-right (get-tape-right tape)]
         [new-tape-left (reverse (cons tape-current (reverse tape-left)))]
         [new-tape-current BLANK]
         [new-tape-right '()])
    (when (not (null? tape-right))
      (set! new-tape-current (car tape-right))
      (set! new-tape-right (cdr tape-right)))
    (set-tape! tape new-tape-left new-tape-current new-tape-right)
    ))

;; tape -> string
;; Move the head left on the tape structure.  Same as moving the tape right.  Return the changed tape.
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
    (set-tape! tape new-tape-left new-tape-current new-tape-right)
    ))

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
         move-head-right)


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
; Name top token on the stack, without popping.  Return STACK-EXHAUSTED if stack is empty.
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
; Decide if the stack's top token is BOT, that is, whether the stack is exhausted.
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
;; A machine is a structure consisting of list of instructions and list of accepting states.
(struct machinestruct (instructions acceptingstates) #:transparent #:mutable)

; no input  ->  machinestruct
; Create an empty machine.
(define (machine-create)
  (machinestruct '() (mutable-set)))

; machinestruct, instruction  ->  machinestruct
; Add the instruction to the machine
(define (machine-add-instruction machine instruction)
  (set-machinestruct-instructions! machine
                                   (reverse (cons instruction (reverse (machinestruct-instructions machine))))))

; machinestruct, natural-number  ->  machinestruct
; Add the accepting state to the machine 
(define (machine-add-accepting-state machine accepting-state)
  (set-add! (machinestruct-acceptingstates machine) accepting-state))

;; Dummy function to be replaced in calling file
(define (instruction->string x)
  (format "~s" x))

;; machinestruct -> string
;; Return string of the machine, for display or debugging
(define (machine->string machine)
  (let* ([instruction-string
         (string-join (map instruction->string (machinestruct-instructions machine)) "\n")]
         [state-string
         (string-join (map number->string (sort (set->list (machinestruct-acceptingstates machine)) <=)))]
         [first-half-string
          (string-append "INSTRUCTIONS: " instruction-string)])
    (printf "first-half-string=~s\n" first-half-string)
    (if (set-empty? (machinestruct-acceptingstates machine))
        first-half-string
        (string-append first-half-string
                       "\nACCEPTING STATES: " state-string))))

(provide machine-create
         machine-add-accepting-state
         machine-add-instruction
         machinestruct?
         machinestruct-instructions
         machinestruct-acceptingstates
         machine->string)


;; ===== history

(define (make-history-node config)
  (cons config (mutable-set)))

(define (get-node-config n)
  (car n))

(define (get-child-nodes n)
  (cdr n))

(define (make-history initialconfig)
  (make-history-node initialconfig))

(define (add-history-node! existing-node new-node)
  (set-add! (cdr existing-node) new-node)
  new-node)

(define (add-child-node! existing-node new-child-config)
  (let ([child-node (make-history-node new-child-config)])
    (set-add! (cdr existing-node) child-node)
    child-node))

(define (traverse-history-bfs level level-no fcn)
  (let ([next-level '()])
    (for ([node level])
      fcn(node level-no)
      (for ([child-node (get-child-nodes node)])
        (cons child-node next-level)
        ))
    (when (not (null? next-level))
      (traverse-history-bfs next-level (+ 1 level-no) fcn))))

(define (traverse-history-dfs node rank fcn)
  (fcn node rank)
  (let ([children (get-child-nodes node)])
    (for ([child children])
      ;; (fcn child rank)
      (traverse-history-dfs child (+ rank 1) fcn))))

(provide make-history-node
         get-node-config
         get-child-nodes
         make-history
         add-history-node!
         add-child-node!
         traverse-history-bfs
         traverse-history-dfs
 )


;; ===== parsing

;; A line with only comment, using # as a comment character
(define EMPTY-LINE-REGEXP #px"^\\s*(\\#.*)?$")

; Need a way to describe some states as final, or accepting.
(define FINAL-STATES-REGEXP #px"\\s*((FINAL)|(ACCEPTING))[:]?\\s*([\\s*\\d+,?]*)\\s*(\\#.*)?$")

; The regular expression used to split the space-separated tokens inside the final states string
(define FINAL-STATES-PARSE-REGEXP #px"(,\\s*)|(\\s+)")

;; string -> list of numbers
;; Return the numbers given as a space-separated list in the string
;; (You can use a comma between numbers, as in "3, 4")
(define (parse-final-states m)
  (let* ([token-list (car m)]
         [digit-string (fourth token-list)])
    ;(printf "parse-final-states token-list=~s\n    digit-string=~s\n" token-list digit-string)
    (map string->number (string-split (string-trim digit-string) FINAL-STATES-PARSE-REGEXP))))


;; string -> list of two lists
;; Return either an instruction or a list of integers, not both.  It can be that both lists are empty.
;; This is a dummy function to be replaced in calling file
(define (parse-one-line lne)
  (list '() '()))

;; list of strings -> Turing machine
(define (parse file-lines)
  (let ([machine (machine-create)])
    ; (printf "  parse: pdm=~s\n" pdm)
    (for* ([line file-lines])
      ;(printf "parse: line=~s\n" line)
      ; (printf "    parse-one-line=~s\n" (parse-one-line line))
       (let* ([inst-and-states (parse-one-line line)]
              [inst (first inst-and-states)]
              [state-list (second inst-and-states)])
        ;(printf "    parse: inst-and-states=~s\n" inst-and-states)
        ;(printf "    parse: (first inst-and-states)=~s\n" (first inst-and-states))
        ;(printf "    parse: inst=~s  state-list=~s\n" inst state-list)
        (if (not (null? inst))
            (machine-add-instruction machine inst)
            (for ([accepting-state state-list])
              (machine-add-accepting-state machine accepting-state)))
        ; (printf "  parse: pdm=~s\n" pdm)))
    )) machine)
  )


(provide EMPTY-LINE-REGEXP
         FINAL-STATES-REGEXP
         parse-final-states
         parse)
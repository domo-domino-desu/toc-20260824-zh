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

;; list -> list
;; Return value associated with k in DELTA, or DELTA-NOKEY
(define (delta delta-map k)
  (hash-ref delta-map k (lambda () DELTA-NOKEY)))

(provide make-delta-map
         set-delta-map!
         DELTA-NOKEY
         delta)


;; ===== tape

;; A tape is a struct.
(struct tapestruct (left current right) #:transparent #:mutable)

;; Sometimes it is convenient to have a B instead of just a blank space
(define BLANK "B")

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


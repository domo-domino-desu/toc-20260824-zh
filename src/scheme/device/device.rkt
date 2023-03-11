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
(define DELTA '())

;; Make DELTA be a new hash
(define (make-DELTA)
  (set! DELTA (make-hash)))
;; Clear DELTA to the empty list, not a hash
(define (clear-DELTA)
  (set! DELTA '()))
;; Reset DELTA to an empty hash 
(define (reset-DELTA)
  (make-DELTA))

;; list, list -> void
;; Add the value to the set that is DELTA[k], or create a new set if none there
(define (DELTA-set! k v)
  (if (member k (hash-keys DELTA))
      (set-add! (hash-ref DELTA k) v)
      (hash-set! DELTA k (mutable-set v))))

;; Signifies DELTA has no such key
(define DELTA-NOKEY "No such key for Delta")

;; list -> list
;; Return value associated with k in DELTA, or DELTA-NOKEY
(define (delta k)
  (hash-ref DELTA k (lambda () DELTA-NOKEY)))

(provide DELTA
         make-DELTA
         clear-DELTA
         reset-DELTA
         DELTA-set!
         DELTA-NOKEY
         delta)


;; ===== tape
;; A tape is a struct.
(struct tapestruct (left current right) #:transparent #:mutable)

;; Sometimes it is convenient to have a B instead of just a blank space
(define BLANK "B")

;; We use TAPE as the global tape.  Here it has the initial value '() as a way
;; to tell that it is undefined
(define TAPE '())

;; -> void
;; Create a new tapestruct
(define (make-TAPE)
  (set! TAPE (tapestruct '() " " '())))

;; list of strings, string, list of strings -> void
;; Set the TAPE structure to have the given left, current, and right
(define (set-TAPE! left current right)
  (set-tapestruct-left! TAPE left)
  (set-tapestruct-current! TAPE current)
  (set-tapestruct-right! TAPE right))

;; Set TAPE to be a dummy value
(define (clear-TAPE)
  (set! TAPE '()))

; list of strings  ->  tape-list
; Make a tape list, with I/O head pointing to first token
(define (make-tape . tape-tokens)
  ; (printf "make-tape: tape-tokens are ~s\n" tape-tokens)
  (make-TAPE)
  (if (null? tape-tokens)
      (set-tapestruct-current! TAPE " ")
      (begin
        (set-tapestruct-current! TAPE (car tape-tokens))
        (set-tapestruct-right! TAPE (cdr tape-tokens)))))

;; -> void
;; Get the left tape, the current token, or the right tape 
(define (get-tape-left)
  (tapestruct-left TAPE))
(define (get-tape-current)
  (tapestruct-current TAPE))
(define (get-tape-right)
  (tapestruct-right TAPE))

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

;; -> void
;; From the TAPE, trim " " or "B" off the left tape or right tape 
(define (trim-tape)
  (let ([tape-left (get-tape-left)]
        [tape-current (get-tape-current)]
        [tape-right (get-tape-right)])
    (set-TAPE! (trim-left-tape tape-left) tape-current (trim-right-tape tape-right))))

;; -> string
;; Move the head right on the TAPE structure.  Same as moving the tape left.  Return the new
;; current token.
(define (move-head-right)
  (let ([tape-left (get-tape-left)]
        [tape-current (get-tape-current)]
        [tape-right (get-tape-right)]
        [new-tape-left '()]
        [new-tape-current " "]
        [new-tape-right '()])
    (set! new-tape-left (reverse (cons tape-current (reverse tape-left))))
    (if (null? tape-right)
        (set! new-tape-current " ")
        (begin
          (set! new-tape-current (car tape-right))
          (set! new-tape-right (cdr tape-right))))
    (set! TAPE (tapestruct new-tape-left new-tape-current new-tape-right))
    new-tape-current
    ))

;; -> string
;; Move the head left on the TAPE structure.  Same as moving the tape right.  Return the new
;; current token.
(define (move-head-left)
  (let ([tape-left (get-tape-left)]
        [tape-current (get-tape-current)]
        [tape-right (get-tape-right)]
        [new-tape-left '()]
        [new-tape-current " "]
        [new-tape-right '()])
    (set! new-tape-right (cons tape-current tape-right))
    (if (null? tape-left)
        (set! new-tape-current " ")
        (let ([reversed-tape-left (reverse tape-left)])
          (set! new-tape-current (car reversed-tape-left))
          (set! new-tape-left (reverse (cdr reversed-tape-left)))))
    (set! TAPE (tapestruct new-tape-left new-tape-current new-tape-right))
    new-tape-current
    ))

(provide tapestruct
         TAPE
         make-TAPE
         set-TAPE!
         make-tape
         get-tape-left
         get-tape-current
         get-tape-right
         trim-left-tape
         trim-right-tape
         trim-tape
         move-head-left
         move-head-right)

;; mod3-fsm.rkt
;;  Illustrate conversion of Finite State machine to code
#lang racket
(require rackunit)

;; string  -->  string
;; Decide if the input represents a multiple of three
(define (multiple-of-three-fsm input-string)
  (let ((state 0))
    (if (= 0 (multiple-of-three-fsm-helper state (string->list input-string)))
	"accept"
	"reject")))

(module+ test
  (check-equal? "accept" (multiple-of-three-fsm "1101"))
  (check-equal? "reject" (multiple-of-three-fsm "11011"))
  (check-equal? "accept" (multiple-of-three-fsm "00"))
  (check-equal? "accept" (multiple-of-three-fsm ""))
  )

;; natural, list of characters  -->  natural
;; Tail-recursive helper fcn
(define (multiple-of-three-fsm-helper state tau-list)
  (if (null? tau-list)
      state
      (multiple-of-three-fsm-helper (delta state (car tau-list))
				    (cdr tau-list))))

;; natural, character  -->  natural
;; Next-state function
(define (delta state ch)
  (cond
   [(= state 0)
    (cond
     ((memv ch '(#\0 #\3 #\6 #\9)) 0)
     ((memv ch '(#\1 #\4 #\7)) 1)
     (else 2))]
   [(= state 1)
    (cond
     ((memv ch '(#\0 #\3 #\6 #\9)) 1)
     ((memv ch '(#\1 #\4 #\7)) 2)
     (else 0))]
   [else
    (cond
     ((memv ch '(#\0 #\3 #\6 #\9)) 2)
     ((memv ch '(#\1 #\4 #\7)) 0)
     (else 1))]))
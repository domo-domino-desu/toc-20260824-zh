#lang racket
(require rackunit
         "finite-state-machine.rkt")

;; toggle switch
(define fsm0  
  (list
   (list 0 #\t 1)
   (list 1 #\t 0)
   ))

;; turnstyle
(define fsm1  
  (list
   (list 0 #\t 1)
   (list 0 #\p 0)
   (list 1 #\t 2)                     
   (list 1 #\p 1)
   (list 2 #\t 2)
   (list 2 #\p 0)                     
   ))


;; ============  configuration tests =================
;(test-case
;  "Test configuration getters and setters for minimal functionality"
;  (let ([config (make-config 1 (list #\x #\y))])
;    (check = 1 (get-current-state config))
;    (check equal? (list #\x #\y) (get-tape-list config))
;    (check char=? #\x (get-current-symbol config))
; ))
;(test-case
;  "Test configuration edge cases"
;  (let ([config (make-config 1 (string->list ""))])
;    (equal? '() (get-tape-list config))
; ))
;
;
;;;; ============  delta tests =========================
;(test-case
; "Test Delta, minimal functionality"
; ; does it run at all?
; (let* ([next-state (delta fsm0 0 #\t)])
;   ; (println action)
;   ; (println next-state)
;   (check = 1 next-state "Next state for toggle should be a 1")
;   ))
;
;(test-case
; "Test Delta, number of cases"
; (check = 1 (delta fsm0 0 #\t) "Toggle should change states")
; (check = 0 (delta fsm0 1 #\t) "Toggle should change to state 0")
; (check = 1 (delta fsm1 0 #\t) "Turnstile should change to state 1")
; (check = 0 (delta fsm1 0 #\p) "Turnstile should stay in state 0")
; )
;
;(test-case
; "Test Delta returns ERROR if a bad input"
; (check = ERROR (delta fsm0 2 #\t) "No such state")
; (check = ERROR (delta fsm0 0 #\s) "No such input")
; (check = ERROR (delta fsm0 2 #\s) "No such input or state")
;)
;
;
;;;; =================== step ======================
;(test-case
; "Test step, minimal functionality"
; (let* ([config (make-config 0 '(#\t #\p))]
;        [next-config (step fsm1 config)])
;   (printf "~a\n" (configuration->string next-config))
;   (check equal? (make-config 1 '(#\p)) next-config)))
;
;(test-case
; "Test step, emptying tape"
; (let* ([config (make-config 0 '(#\p))])
;   (check equal? (make-config 0 '()) (step fsm1 config fsm1))))
;
;(test-case
; "Test step, one following another"
; (let* ([config (make-config 1 '(#\t #\p))]
;        [second-config (step fsm1 config)])
;   (printf "\nfinished second-config")
;   (write second-config)
;   (check equal? (make-config 0 '()) (step fsm1 second-config))))
;
;;(printf "KKK: ~a\n" (configuration->string (make-config 0 '())))
;;(printf "LLL: ~a\n" (configuration->string (step (make-config 0 '(#\p)) fsm1)))
;(test-case
; "Test step, halting"
; (let* ([config (make-config 0 '())]
;        [next-config (step fsm1 config)])
;   (check = HALT next-config)))




;;; ======================== run =====================
(test-case
 "Test run, minimal functionality"
 (printf "\n===Doing run===")
 (let* ([F (list 2)]
        [sigma ""])
   (check = 0 (run fsm1 F sigma))))

(test-case
 "Test run, minimal functionality"
 (printf "\n===Doing run===")
 (let* ([F (list 2)]
        [sigma (string #\t #\p #\t)])
   (check = 2 (run fsm1 F sigma))))

; (let ([config (step c0 tm0)])
;   (check-eq? (get-current-state config) 0 "tm0 does not change state on this move-right")
;   (check-equal? (get-left-tape-list config) (make-tape-list "11011") "Move right adds a 1 to the left tape list")
;   (check char=? (get-current-symbol config) #\0 "Move right pulls char from right tape list")
;   (check-equal? (get-right-tape-list config) (make-tape-list "010") "Move right pops a char on right")
;   )
;)
;
;;; ======================== execute =====================
;(define config-unary-3
;  (make-config 0 (make-tape-list "") STROKE (make-tape-list "11") 0))
;
;
;(test-case
; "Test execute, minimal functionality"
; (execute tm0 config-unary-3)
; )
;
;#|
;|#
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
(test-case
  "Test configuration getters and setters for minimal functionality"
  (let ([config (make-config 1 (list #\x #\y))])
    (check = 1 (get-current-state config))
    (check equal? (list #\x #\y) (get-tape-list config))
    (check char=? #\x (get-current-symbol config))
 ))
(test-case
  "Test configuration edge cases"
  (let ([config (make-config 1 (string->list ""))])
    (equal? '() (get-tape-list config))
 ))

;;; ================ tape-right-char, tape-left-char ===============
;
;;; make-tape-list  make a tape list from a string
;(define (make-tape-list s)
;  (string->list s))
;(define tl0 (make-tape-list "1101"))
;(define tl1 (make-tape-list "0010"))
;(define tl-blank (make-tape-list ""))
;
;(define c0 (make-config 0
;                        STROKE
;                        (make-tape-list "1101")
;                        (make-tape-list "0010")
;                        0))
;(define c1 (make-config 2
;                        STROKE
;                        (make-tape-list "1")
;                        (make-tape-list "0")
;                        0))
;
;(test-case
; "Test tape-left-char and tape-right-char minimal functionality"
; (check char=? #\1 (tape-right-char tl0) "First char on the right tape is a 1")
; (check char=? #\0 (tape-right-char tl1) "First char on the right tape is a 0")
; (check char=? #\1 (tape-left-char tl0) "Leftmost char on this tape is a 1")
; (check char=? #\0 (tape-left-char tl1) "Leftmost char on the right tape is a 0")
; )
;(test-case
; "Test tape-left-char and tape-right-char return blank if tape is empty"
; (check char=? BLANK (tape-right-char tl-blank) "First char on right on empty tape is BLANK")
; (check char=? BLANK (tape-left-char tl-blank) "Leftmost char on empty tape is BLANK")
; )
;
;(test-case
; "Test configuration->string minimal functionality"
; (let ([s (configuration->string c0)])
;   (check-equal? "q0: 1101*1*0010 :0" s "Expected debugging output string")
;   )
; )
;
;(define c-blank-tape (make-config 222
;                                  STROKE
;                                  (make-tape-list "")
;                                  (make-tape-list "")
;                                  0))
;
;(test-case
; "Test configuration->string edge cases"
; (let ([s (configuration->string c-blank-tape)])
;   (check-equal? "q222: *1* :0" s "Expected debugging output string" )
;   )
; )
;
;
;;; ============  delta tests =========================
;(test-case
; "Test Delta, minimal functionality"
; ; (delta tm0 1 STROKE)  ;; does it run at all?
; (let* ([action-next-state (delta tm0 1 STROKE)]
;        [action (first action-next-state)]
;        [next-state (second action-next-state)])
;   ; (println action)
;   ; (println next-state)
;   (check char=? action BLANK "Action symbol in this instruction should be a blank")
;   (check = next-state 1 "Next state in this instruction should be 1")
;   ))
;
;(test-case
; "Test Delta, additional functionality"
; (let* ([action-next-state (delta tm1 3 BLANK)]
;        [action (first action-next-state)]
;        [next-state (second action-next-state)])
;   (check char=? action RIGHT "Action called for should be to go right")
;   (check = next-state 3 "Next state should be 3")
;   ))
;
;(test-case
; "Test Delta returns null if there is no such instruction"
; (check-pred null? (delta tm1 4 BLANK) "No such instruction")
; )
;
;
;;; ================ move-right, move-left ===============
;
;
;(test-case
; "Test move-right, move-left basic functionality"
; (move-left c0 10)  ; does it work at all?
; (let ([config (move-left c0 10)])
;   (check-eq? (get-current-state config) 10 "Use the given next state")
;   (check-equal? (get-left-tape-list config) (make-tape-list "110") "Move left cuts off leftmost char")
;   (check char=? (get-current-symbol config) #\1 "Move left pulls char from left tape list")
;   (check-equal? (get-right-tape-list config) (make-tape-list "10010") "Move left pushes a char on right")
;   )
; (move-right c0 22)  ; does it work at all?
; (let ([config (move-right c0 22)])
;   (check-eq? (get-current-state config) 22 "Use the given next state")
;   (check-equal? (get-left-tape-list config) (make-tape-list "11011") "Move right pushed old current-char onto left tape")
;   (check char=? (get-current-symbol config) #\0 "Move right pulls char from right tape list")
;   (check-equal? (get-right-tape-list config) (make-tape-list "010") "Move right strips char off right tape")
;   ))
;
;(define c2 (make-config 2
;                        STROKE
;                        (make-tape-list "")
;                        (make-tape-list "1100")
;                        0))
;(define c3 (make-config 2
;                        STROKE
;                        (make-tape-list "0110")
;                        (make-tape-list "")
;                        2))
;(define c4 (make-config 2
;                        STROKE
;                        (make-tape-list "")
;                        (make-tape-list "")
;                        -1))
;
;(test-case
; "Test move-left, move-right with blank tape"
; (let ([config (move-left c2 55)])
;   (check-eq? (get-current-state config) 55 "Use the given next state")
;   (check-equal? (get-left-tape-list config) (make-tape-list "") "Move left leaves the blank tape blank")
;   (check char=? (get-current-symbol config) BLANK "Move left tries to pulls char from left tape list, gets a blank")
;   (check-equal? (get-right-tape-list config) (make-tape-list "11100") "Move left pushes a char on right")
;   )
; (let ([config (move-left c3 55)])
;   (check-eq? (get-current-state config) 55 "Use the given next state")
;   (check-equal? (get-left-tape-list config) (make-tape-list "011") "Move left strips a char off the left")
;   (check char=? (get-current-symbol config) #\0 "Move left pulls char from left tape list")
;   (check-equal? (get-right-tape-list config) (make-tape-list "1") "Move left pushes a char on right")
;   )
; (let ([config (move-left c4 55)])
;   (check-eq? (get-current-state config) 55 "Use the given next state")
;   (check-equal? (get-left-tape-list config) (make-tape-list "") "Move left leaves the blank tape blank")
;   (check char=? (get-current-symbol config) BLANK "Move left tries to pulls char from left tape list, gets a blank")
;   (check-equal? (get-right-tape-list config) (make-tape-list "1") "Move left pushes a char on right")
;   )
; (let ([config (move-right c2 55)])
;   (check-eq? (get-current-state config) 55 "Use the given next state")
;   (check-equal? (get-left-tape-list config) (make-tape-list "1") "Move right pushes a char onto the left tape")
;   (check char=? (get-current-symbol config) #\1 "Move right pulls a char from right tape list")
;   (check-equal? (get-right-tape-list config) (make-tape-list "100") "Move right shortens right list")
;   )
; (let ([config (move-right c3 55)])
;   (check-eq? (get-current-state config) 55 "Use the given next state")
;   (check-equal? (get-left-tape-list config) (make-tape-list "01101") "Move right pushes a char on left tape")
;   (check char=? (get-current-symbol config) BLANK "Move right tries to pull a char from right tape, gets a blank")
;   (check-equal? (get-right-tape-list config) (make-tape-list "") "Move right leaves right tape empty")
;   )
; (let ([config (move-right c4 55)])
;   (check-eq? (get-current-state config) 55 "Use the given next state")
;   (check-equal? (get-left-tape-list config) (make-tape-list "1") "Move right pushes char on left tape")
;   (check char=? (get-current-symbol config) BLANK "Move right tries to pulls char from right tape list, gets a blank")
;   (check-equal? (get-right-tape-list config) (make-tape-list "") "Move right leaves empty right tape still empty")
;   )
; )
;
;;; ======================== step =====================
;(test-case
; "Test step, minimal functionality"
; ; (step c0 tm0)
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
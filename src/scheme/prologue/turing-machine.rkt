#lang racket

(define BLANK #\B)  ;; char used in tape data structure
(define STROKE #\1)  ;; char used to mark tape 
(define LEFT #\L) ;; Move tape pointer left
(define RIGHT #\R) ;; Move tape pointer right
(define HALT '())

(define tm
  (list
   '(0 BLANK LEFT 1)
   '(0 STROKE RIGHT 0)
   '(1 BLANK LEFT 2)                     
   '(1 STROKE BLANK 1)
   '(2 BLANK RIGHT 3)
   '(2 STROKE LEFT 2)                     
   ))

;; A configuration is a list of four things:
;;  the current state, as a natural number
;;  the contents of the tape to the left of the head, as a list of characters (in left-to-right order)
;;  the symbol being read
;;  the contents of the tape to the right of the head, as a list of characters
(define c-test
  (list 12 '(#\0 #\1 #\0 #\0) #\1 '(#\1 #\1 #\0)))

;; return a string for use in debugging
(define (configuration->string config)
  (let ([state (string-append "q" (number->string (first config)))]  ;; like "q0"
        [left (list->string (second config))]       ; like "0100"
        [current (string #\* (third config) #\*)]  ; surround with *'s 
        [right (list->string (fourth config))])
    (string-append state ": " left current right)))

;; return a string for use in Asymptote
(define (configuration->asy config filename tape-length)
  (let ([state (string-append "$q_{" (number->string (first config)) "}$")]  ;; like "q0"
        [left (list->string (second config))]       ; like "0100"
        [current (string (third config))]  ; convert character to string 
        [right (list->string (fourth config))])
    (string-join (list (string-append "\"" filename "\"")
                       (string-append "\"" left current right "\"")
                       (number->string (string-length left))
                       (string-append "\"" state "\"")
                       (number->string tape-length))
                 ","
                 #:before-first "tape_output("
                 #:after-last ");")))

;; =============================
;; Look in the machine to find the relevant instruction
(define (delta current-state tape-symbol)
  (define (delta-helper instruction-list)
    (if (empty? instruction-list)
        null
        (let ([instruction (first instruction-list)])
          (if (and (= current-state (first instruction))
                   (char=? tape-symbol (second instruction)))
              (list (third instruction) (fourth instruction))
              (delta-helper (cdr instruction-list))))))
  (delta-helper tm))
  
;; ====================
;; Changing the configuration

;; tape-char-right  Return the element nearest the head on the right side of the tape
(define (tape-char-right tape-list)
  (if (empty? tape-list)
      BLANK
      (car tape-list)))
;; tape-char-left  Return the element nearest the head on the right side of the tape
(define (tape-char-left tape-list)
  (tape-char-right (reverse tape-list)))
  
;; Respond to Left action
(define (move-left config next-state)
  (let ([left-tape (second config)]
        [current (third config)]
        [right-tape (fourth config)])
    (list next-state
          (reverse (cdr (reverse left-tape)))
          (tape-char-left left-tape)
          (cons current right-tape))))

;; Respond to Right action
(define (move-right config next-state)
  (let ([left-tape (second config)]
        [current (third config)]
        [right-tape (fourth config)])
    (list next-state
          (reverse (cons current (reverse left-tape)))
          (tape-char-right right-tape)
          (cdr right-tape))))

;; Take one step
;; Return a configuration
(define (step config)
  (let* ([current-state (first config)]
         [left-tape (second config)]
         [tape-symbol (third config)]
         [right-tape (fourth config)]
         [action-next-state (delta current-state tape-symbol)])
    (if (empty? action-next-state)
        HALT
        (let ([action (first action-next-state)]
              [next-state (second action-next-state)])
          (cond
            [(char=? LEFT action) (move-left config)]
            [(char=? RIGHT action) (move-right config)]
            [else (list next-state
                        left-tape
                        action
                        right-tape)])))))
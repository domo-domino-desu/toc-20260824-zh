#lang racket

(define BLANK #\B)  ;; char used in tape data structure
(define STROKE #\1)  ;; char used to mark tape 
(define LEFT #\L) ;; Move tape pointer left
(define RIGHT #\R) ;; Move tape pointer right
(define HALT '())
(provide  BLANK
          STROKE
          LEFT
          RIGHT
          HALT)

;; ================= Configuration making and reading ==============
;; A configuration is a list of four things:
;;  the current state, as a natural number
;;  the contents of the tape to the left of the head, as a list of characters (in left-to-right order)
;;  the symbol being read, a character
;;  the contents of the tape to the right of the head, as a list of characters
(define (make-config current-state left-tape-list action right-tape-list)
  (list current-state left-tape-list action right-tape-list))

(define (get-current-state config) (first config))
(define (get-left-tape-list config) (second config))
(define (get-current-symbol config) (third config))
(define (get-right-tape-list config) (fourth config))

(provide make-config
         get-current-state
         get-left-tape-list
         get-current-symbol
         get-right-tape-list)

;; tape-char-right  Return the element nearest the head on the right side of the tape
(define (tape-char-right right-tape-list)
    (if (empty? right-tape-list)
        BLANK
        (car right-tape-list)))

;; tape-char-left  Return the element nearest the head on the right side of the tape
(define (tape-char-left left-tape-list)
    (tape-char-right (reverse left-tape-list)))

(provide tape-char-right
         tape-char-left)

;; return a string for use in debugging
(define (configuration->string config)
  (let ([state (string-append "q" (number->string (get-current-state config)))]  ;; like "q0"
        [left-tape (list->string (get-left-tape-list config))]       ; like "0100"
        [current (string #\* (get-current-symbol config) #\*)]  ; surround with *'s 
        [right-tape (list->string (get-right-tape-list config))])
    (string-append state ": " left-tape current right-tape)))

;; return a string for use in Asymptote
(define (configuration->asy config filename tape-length)
  (let ([state (string-append "$q_{" (number->string (get-current-state config)) "}$")]  ;; like "q0"
        [left-tape (list->string (get-left-tape-list config))]       ; like "0100"
        [current (string (get-current-symbol config))]  ; convert character to string 
        [right-tape (list->string (get-right-tape-list config))])
    (string-join (list (string-append "\"" filename "\"")
                       (string-append "\"" left-tape current right-tape "\"")
                       (number->string (string-length left-tape))
                       (string-append "\"" state "\"")
                       (number->string tape-length))
                 ","
                 #:before-first "tape_output("
                 #:after-last ");")))

;; =============================
;; Look in the machine to find the relevant instruction
(define (delta tm current-state tape-symbol)
  (define (delta-helper instruction-list)
    (if (empty? instruction-list)
        null
        (let ([instruction (first instruction-list)])
          (if (and (= current-state (first instruction))
                   (char=? tape-symbol (second instruction)))
              (list (third instruction) (fourth instruction))
              (delta-helper (cdr instruction-list))))))
  (delta-helper tm))

(provide delta)

;; ====================
;; Changing the configuration

;; Respond to Left action
(define (move-left config next-state)
  (let ([left-tape-list (get-left-tape-list config)]
        [prior-current-symbol (get-current-symbol config)]
        [right-tape-list (get-right-tape-list config)])
    (make-config next-state
          (reverse (cdr (reverse left-tape-list))) ;; strip symbol off left
          (tape-char-left left-tape-list)          ;; new current symbol
          (cons prior-current-symbol right-tape-list)))) ;; push old current symbol onto right 

;; Respond to Right action
(define (move-right config next-state)
  (let ([left-tape-list (get-left-tape-list config)]
        [prior-current-symbol (get-current-symbol config)]
        [right-tape-list (get-right-tape-list config)])
    (list next-state
          (reverse (cons prior-current-symbol (reverse left-tape-list)))  ;; push old current symbol on left
          (tape-char-right right-tape-list) ;; new current symbol
          (cdr right-tape-list))))  ;; strip symbol off right

(provide move-left
         move-right)

;; Take one step
;; Return a configuration
(define (step config)
  (let* ([current-state (get-current-state config)]
         [left-tape-list (get-left-tape-list config)]
         [current-symbol (get-current-symbol config)]
         [right-tape-list (get-right-tape-list config)]
         [action-next-state (delta current-state current-symbol)])
    (if (empty? action-next-state)
        HALT
        (let ([action (first action-next-state)]
              [next-state (second action-next-state)])
          (cond
            [(char=? LEFT action) (move-left config next-state)]
            [(char=? RIGHT action) (move-right config next-state)]
            [else (list next-state
                        left-tape-list
                        action
                        right-tape-list)])))))


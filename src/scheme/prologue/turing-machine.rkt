#! /usr/bin/env racket
#lang racket
(require racket/cmdline)

;; turing-machine.rkt
;; A Turing machine simulation, for Theory of Computation by Hefferon
;; Author: Jim Hefferon  License: GPL
;; Input format: One line per instruction.  Instruction is a space-separated list of four elements:
;; natural number for current state, character for what the head is point to, character for the action (any alphabet
;; character and L or R), natural number for the next state.  Best is to use digits or lower-case letters for alphabet.
;; After each step, the machine prints out a picture of the tape with the current char between asterisks.
;; 
;; There is a utility elsewhere in this repo that converts these pictures for use in Asymptote.

(define BLANK #\B)  ;; Easier to read than space
(define STROKE #\1)  ;; 
(define LEFT #\L) ;; Move tape pointer left
(define RIGHT #\R) ;; Move tape pointer right
(define HALT-STATE -1) ;; Anything negative
(provide  BLANK
          STROKE
          LEFT
          RIGHT
          HALT-STATE)

;; ================= Configuration making and reading ==============
;; A configuration is a list of four things:
;;  the current state, as a natural number
;;  the symbol being read, a character
;;  the contents of the tape to the left of the head, as a list of characters
;;  the contents of the tape to the right of the head, as a list of characters
(define (make-config state  char left-tape-list right-tape-list)
  (list state char left-tape-list right-tape-list))

(define (get-current-state config) (first config))
(define (get-current-symbol config)
  (let ([cs (second config)])  ;; make horizontal whitespace like a B
    (if (char-blank? cs)
        #\B
        cs)))
(define (get-left-tape-list config) (third config))
(define (get-right-tape-list config) (fourth config))

(provide make-config
         get-current-state
         get-current-symbol
         get-left-tape-list
         get-right-tape-list)

;; configuration-> string  Return a string showing the tape
(define (configuration->string config)
  (let* ([state-number (get-current-state config)]
         [state-string (string-append "q" (number->string state-number))]
         [left-tape (list->string (get-left-tape-list config))]    
         [current (string #\* (get-current-symbol config) #\*)]  ;; wrap *'s
         [right-tape (list->string (get-right-tape-list config))])
    (string-append state-string ": " left-tape current right-tape)))

(provide configuration->string)

;; =============================
;; delta  Find the applicable instruction
(define (delta tm current-state tape-symbol)
  (define (delta-test inst)
    (and (= current-state (first inst))
         (equal? tape-symbol (second inst))))
  
  (let ([inst (findf delta-test tm)])
    (if (not inst)
        '()
        ;; (list #\X HALT-STATE)  ;; X is arbitrary placeholder char
        (list (third inst) (fourth inst)))))

(provide delta)

;; ====================
;; Changing the configuration

;; tape-right-char  Return the element nearest the head on the right side
(define (tape-right-char right-tape-list)
  (if (empty? right-tape-list)
      BLANK
      (car right-tape-list)))

;; tape-left-char  Return the element nearest the head on the left
(define (tape-left-char left-tape-list)
  (tape-right-char (reverse left-tape-list)))

;; tape-right-pop  Return the right tape list without char nearest the head
(define (tape-right-pop right-tape-list)
  (if (empty? right-tape-list)
      '()
      (cdr right-tape-list)))

;; tape-left-pop   Return the left tape list without char nearest the head
(define (tape-left-pop left-tape-list)
  (reverse (tape-right-pop (reverse left-tape-list))))

;; move-left  Respond to Left action
(define (move-left config next-state)
  (let ([left-tape-list (get-left-tape-list config)]
        [prior-current-symbol (get-current-symbol config)]
        [right-tape-list (get-right-tape-list config)])
    ;; push old tape head symbol onto the right tape list 
    (make-config next-state
                 (tape-left-char left-tape-list)    ;; new current symbol
                 (tape-left-pop left-tape-list)       ;; strip symbol off left
                 (cons prior-current-symbol right-tape-list)))) 

;; move-right Respond to Right action
(define (move-right config next-state)
  (let ([left-tape-list (get-left-tape-list config)]
        [prior-current-symbol (get-current-symbol config)]
        [right-tape-list (get-right-tape-list config)])
    ;; push old head symbol onto the left tape list
    (make-config next-state
                 (tape-right-char right-tape-list) ;; new current symbol
                 (reverse (cons prior-current-symbol (reverse left-tape-list))) 
                 (tape-right-pop right-tape-list)))) ;; strip symbol off right

(provide tape-right-char
         tape-left-char
         tape-right-pop
         tape-left-pop)

(provide move-left
         move-right)

;; ===================================================
;; Take one step
;; step  Do one step; from a config and the tm, yield the next config
;;   Returns null if machine halts.
(define (step config tm)
  (let* ([current-state (get-current-state config)]
         [left-tape-list (get-left-tape-list config)]
         [current-symbol (get-current-symbol config)]
         [right-tape-list (get-right-tape-list config)]
         [action-next-state (delta tm current-state current-symbol)])
    (if (null? action-next-state)
        '()                       ;; machine is halted
        (let ([action (first action-next-state)]
              [next-state (second action-next-state)])
          (cond
            [(char=? LEFT action) (move-left config next-state)]
            [(char=? RIGHT action) (move-right config next-state)]
            [else (make-config next-state
                               action  ;; not L or R so it is in tape alphabet
                               left-tape-list
                               right-tape-list)])))))

(provide step)

;; ===================================================
;; Execute a Turing machine
;; execute  Run a turing machine step-by-step until it halts
(define (execute tm initial-config [verbose #t])
  ;; execute-helper
  ;;   config  4-tuple configuration or '()
  ;;   stp  integer, step number
  ;;   history  list of 4-tuple configurations
  (define (execute-helper config stp history)
    (if (or (null? config)
            (= (get-current-state config) HALT-STATE))
        (begin
          (when verbose
              (fprintf (current-output-port)
                       "step ~s: HALT\n"
                       stp))
          (reverse history))
        (begin
          (when verbose
              (fprintf (current-output-port)
                       "step ~s: ~a\n"
                       stp
                       (configuration->string config)))
          (let ([next-config (step config tm)])
            (execute-helper next-config (add1 stp) (cons next-config history))))))
  
  (execute-helper initial-config 0 '()))

(provide execute)

;; =====================================
;; Execute for a limited number of states
(define (execute-guarded tm initial-config slmt [verbose #t])
  (define (execute-helper config stp history)
    (cond [(> stp slmt)
           (begin
             (when verbose
               (fprintf (current-output-port)
                    "step ~s: Simulation stopped\n"
                    stp))
             (reverse history))]
          [(or (null? config)
               (= (get-current-state config) HALT-STATE))
           (begin
             (when verbose
               (fprintf (current-output-port)
                    "step ~s: HALT\n"
                    stp))
             (reverse history))]
          [else (begin
                  (when verbose
                    (fprintf (current-output-port)
                           "step ~s: ~a\n"
                           stp
                           (configuration->string config)))
                  (let ([next-config (step config tm)])
                    (execute-helper next-config (add1 stp) (cons next-config history))))]))

  (execute-helper initial-config 0 '()))


;;========================================================
;; find-initial-strokes  Given a list, return number STROKE's that begin the list
(define (find-initial-strokes lst)
    (define (find-initial-strokes-helper lst k)
      (cond ([(null? lst) k]
             [(equal? STROKE (car lst)) k]
             [#t (find-initial-strokes-helper (cdr lst) (add1 k))])))
  
  (find-initial-strokes-helper lst 0))


;; computable-function Compute map f: N -> N 
;;  tm  Turing machine
;;  x   natural number
(define (computable-function tm x [verbose #f])
  (let* ([unary-input (if (= 0 x)
                          '()
                          (build-list x (lambda (y) STROKE)))]
         [initial-config (make-config 0 STROKE '() unary-input)]
         [history (execute tm initial-config verbose)]
         [final-config (list-ref history (length history))]
         [right-tape-list (get-right-tape-list final-config)])
    (find-initial-strokes right-tape-list)))



;; ========================================================
;; Read TM from a file
;; Read a string, interpret the characters
;;  Can write "(1 a L 3)"
(define s "1 a L 3")
(define s0 "(3 b b 4)")

(define (current-state-string->number s)
  (if (eq? #\( (string-ref s 0))   ;; allow instr to start with (
      (string->number (substring s 1))
      (string->number s)))
(define (current-symbol-string->char s)
  (string-ref s 0))
(define (action-symbol-string->char s)
  (string-ref s 0))
(define (next-state-string->number s)
  (if (eq? #\) (string-ref s (- (string-length s) 1))) ;; ends with )?
      (string->number (substring s 0 (- (string-length s) 1)))
      (string->number s)))
(define (string->instruction s)
  (let* ([instruction (string-split (string-trim s))]
         [current-state (current-state-string->number (first instruction))]
         [current-symbol (current-symbol-string->char (second instruction))]
         [action (action-symbol-string->char (third instruction))]
         [next-state (next-state-string->number (fourth instruction))])
    (list current-state
          current-symbol
          action
          next-state)))



;; ========================================================
;; Read command line.

(define verbose? (make-parameter #f))
(define tm-filename (make-parameter null))
(define startchar (make-parameter (make-string 1 BLANK)))  ;; string with one char, head points to this char first
(define startleft (make-parameter ""))  ;; string giving tape left of the start char
(define startright (make-parameter ""))  ;; string giving tape right of start char
(define steplimit (make-parameter "-1")) ;; max number of steps simulator runs; a negative makes it run until done

(define command-line-parser
  (command-line
   #:usage-help 
   "Simulate a Turing machine."
   "Put instructions of the form `state-number current-char action-char next-state-number' on separate lines."
   #:once-each
   [("-v" "--verbose") "Verbose mode" (verbose? #t)]
   [("-f" "--filename") tmfn "Name of file with the Turing machine" (tm-filename tmfn)]
   [("-c" "--char") sc "Character the head points to at start" (startchar sc)]
   [("-l" "--left") sl "String giving tape left of the start character" (startleft sl)]
   [("-r" "--right") sr "String giving tape right of the start character" (startright sr)]
   [("-s" "--steplimit") slmt "Number giving max number of steps to run (negative for run until halt)" (steplimit slmt)]
   #:args  () (void)))


;; Return the list with the last element omitted
;;(define (omit-last-element lst)
;;  (reverse (cdr (reverse lst))))

;; Default initial configuration
(define INITIAL-CONFIG (make-config 0
                                    (current-symbol-string->char (startchar))
                                    (string->list (startleft))
                                    (string->list (startright))))  ;; TODO need the position?

;; For running from the command line; this is the Racket construct to execute code from
;; command line but not from an importing module
(module+ main
  ; (display "Running main\n")
  ;; Read command line arguments  
  (command-line
   #:usage-help 
   "Simulate a Turing machine."
   "Put instructions of the form `state-number current-char action-char next-state-number' on separate lines."
   #:once-each
   [("-v" "--verbose") "Verbose mode" (verbose? #t)]
   [("-f" "--filename") tmfn "Name of file with the Turing machine" (tm-filename tmfn)]
   [("-c" "--char") sc "Character the head points to at start" (startchar sc)]
   [("-l" "--left") sl "String giving tape left of the start character" (startleft sl)]
   [("-r" "--right") sr "String giving tape right of the start character" (startright sr)]
   [("-s" "--steplimit") slmt "Number giving max number of steps to run" (steplimit slmt)]
   #:args  () (void))

  ;; Read the file with the TM instructions
  (define TM-LINES '())  ;; list of file lines, one string per instruction
  (if (null? (tm-filename))
    (set! TM-LINES '())
    (set! TM-LINES (file->lines (tm-filename) #:mode 'text #:line-mode 'any)))
  
  ;; Return a list of instructions
  (define TM (for/list ([line TM-LINES])
               (string->instruction line)))
  ;;(display TM)  ; temp for debugging
  ;; Run the simulation
  (define initial-config
    (make-config 0
                 (string-ref (startchar) 0)
                 (string->list (startleft))
                 (string->list (startright))))
  (define STEPLIMIT (string->number (steplimit)))
  
  (if (>= 0 STEPLIMIT)
      (execute-guarded TM initial-config STEPLIMIT)
      (execute TM initial-config))
)

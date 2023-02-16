#! /usr/bin/env racket
#lang racket
(require racket/cmdline)

;; loop.rkt
;; Run programs in LOOP.
;; 
;; Code adapted from from Hans-Jurgen Schnieder "Computability in an Introductory
;; course on Programming" Bulletin of the European Association for Theoretical Computer Science,
;; EATCS 73 (2001), S. 153-164 ISSN: 0252–9742
;;
;; 2023-Feb-15 Jim Hefferon GPL v3

;; ===== Registers 

;; natural -> symbol
;; Return the symbol giving the standard name of a register, such as 'r5
;;  i  register number
(define (make-reg-name i)
  (string->symbol (string-append "r" (number->string i))))

;; REGISTERS is a hash, a finite function associating a register name of the
;; form "r0" or "r1", etc. to a integer that is its contents.
(define REGISTERS (make-hash))
(hash-set! REGISTERS (make-reg-name 0) 0)

;; no input
;; Show the contents of the registers
(define (show-regs)
  (let* ([lst (hash->list REGISTERS)]
         [st-lst (map (lambda (x) (list (symbol->string (car x)) (cdr x)))
                      lst)]
         [sorted-list (sort st-lst string<=? #:key car)]
         [reg-strings (map (lambda (x) (format "~a=~a" (car x) (cadr x)))
                      sorted-list)])
    (printf "~a\n" (string-join reg-strings))))

;; no input
;; Empty the registers, initialize r0 to be 0
(define (clear-regs!)
  (set! REGISTERS (make-hash))
  ; (hash-set! REGISTERS (make-reg-name 0) 0)
  )

(provide make-reg-name
         REGISTERS
         clear-regs!
         show-regs)

;; ===== Getters and setters for the registers

;; natural, natural -> void
;; Set the value of an existing register or initialize a new one.
;;  r  register, such as 'r5
;;  v  value the register will be set to
(define (set-reg-value! r v)
  (hash-set! REGISTERS r v))

;; symbol -> pair
;; Return pair whose car is the given r; if no such reg, return (r . 0)
;; r  register, such as 'r5
(define (get-reg r) 
  (let ([val (hash-ref REGISTERS r #f)])
    (if val
        (cons r val)
        (begin
          (set-reg-value! r 0)
          (cons r 0))))) 

;; natural -> integer
;; Return contents of the register
;;  r  register, such as 'r5
;; If no register with that number is yet allocated, return 0.
(define (get-reg-value r) 
  (cdr (get-reg r)))

(provide set-reg-value!
         get-reg
         get-reg-value)

;; ===== Register operations

;; natural -> void
;; Increment the register
;;  r  register, such as 'r5
(define (increment-reg! r)
  (set-reg-value! r (+ 1 (get-reg-value r))))

;; natural natural -> void
;; Copy value from reg0 to reg1, leave reg0 unchanged
;; r0 r1  the two registers
(define (copy-reg! reg0 reg1)
  (set-reg-value! reg1 (get-reg-value reg0))) 

;; ===== Interpreter

;; list -> void
;; Set the register that is the car of the list to zero
(define (intr-zero pars)
  (set-reg-value! (car pars) 0)
  (when (show-registers?) (show-regs)))  ; for showing the step-by-step register changes 
;; list -> void
;; Increment the register that is the car of the list to zero
(define (intr-incr pars)
  (increment-reg! (car pars))
  (when (show-registers?) (show-regs)))  ; for showing the step-by-step register changes 
;; list -> void
;; Copy the cadr register to the car register
(define (intr-copy pars)
  (set-reg-value! (car pars) (get-reg-value (cadr pars)))
  (when (show-registers?) (show-regs)))  ; for showing the step-by-step register changes 
;; list -> void
;; Run through a loop, based on the car of the input 
(define (intr-loop pars)
  (letrec ([reps (get-reg-value (car pars))]
	   [body (cdr pars)]
	   [iter (lambda (rep)
		   (cond 
		    ((equal? rep 0) '())
		    (else (intr-body body)
			  (iter (- rep 1)))))])
    (when (show-registers?)
      (printf "--start loop of ~a repetitions--\n" reps))
    (iter reps)))

;; list -> void
;; Interpret the body of loop programs
(define (intr-body body)
  (cond 
   [(null? body) '()]
   [else (let ([next-inst (car body)]
	       [tail (cdr body)])
	   (let ([key (car next-inst)]
		 [pars (cdr next-inst)])
	     (cond
	      [(eq? key 'zero) (intr-zero pars)]
	      [(eq? key 'incr) (intr-incr pars)]
	      [(eq? key 'copy) (intr-copy pars)]
	      [(eq? key 'loop) (intr-loop pars)]))
	   (intr-body tail))]))

(provide intr-zero
         intr-incr
         intr-copy
         intr-loop
         intr-body)

;; natural number -> string
;; Return a string showing the values of the first num-registers  
(define (show-output-registers num-registers)
  (let ([reg-value-lst null])
    (for ([i (in-range num-registers)])
      (set! reg-value-lst (cons (get-reg-value (make-reg-name i)) reg-value-lst)))
    (string-join (map number->string (reverse reg-value-lst)))))

;; The data is a list of the values to put in registers r0 r1 r2 ..
;; Value of a program is the value remaining in r0 at end.
(define (interpret progr data)
  (init-regs data)
  (when (show-registers?) (show-regs))  ; for showing intial preloaded registers 
  (intr-body progr)
  (show-output-registers (output)))

;; init-regs  Initialize the registers r0, r1, r2, .. to the values in data 
(define (init-regs data)
  (define (init-regs-helper i data)
    (if (null? data) 
	'()
	(begin
	  (set-reg-value! (make-reg-name i) (car data))
	  (init-regs-helper (+ i 1) (cdr data)))))
  (clear-regs!)
  (set-reg-value! (make-reg-name 0) 0)
  (init-regs-helper 0 data))

(provide increment-reg!
         copy-reg!)

;; ===== Parse ALGOL-like LOOP instructions to LISP-like ones

;; split-program-into-lines  split the string by newlines
(define (split-program-into-lines p)
  (string-split p "\n"))

;; A loop-program is a vector of strings, one per program line
(define (make-loop-program p)
  (apply vector (split-program-into-lines p))) 

;; drop-comment  omit anything in the line from COMMENT-CHARACTER on out
(define COMMENT-CHARACTER #\#)

;; Regular expressions used to parse the lines in one-line routine
(define EMPTY-LINE-REGEXP #px"^\\s*(\\#.*)?$")
(define ZERO-REGEXP #px"^\\s*(r[\\d]+)\\s*=\\s*0\\s*(\\#.*)?$")
(define INCREMENT-REGEXP #px"^\\s*(r[\\d]+)\\s*=\\s*\\1\\s*\\+\\s*1\\s*(\\#.*)?$")
(define LOOP-REGEXP #px"^\\s*loop\\s*(r[\\d]+)\\s*(\\#.*)?$")
(define END-REGEXP #px"^\\s*end\\s*(\\#.*)?$")
(define COPY-REGEXP #px"^\\s*(r[\\d]+)\\s*=\\s*(r[\\d]+)\\s*(\\#.*)?$")
(provide EMPTY-LINE-REGEXP
         ZERO-REGEXP
         INCREMENT-REGEXP
         LOOP-REGEXP
         END-REGEXP
         COPY-REGEXP)

;; string -> string
;; one-line  Return a string translation of the one line, already in tokens, into
;; part of the code that will be evaluated
(define (one-line lne)
  (cond
   [(regexp-match? EMPTY-LINE-REGEXP lne)
    ""]
   [(regexp-match? LOOP-REGEXP lne)
    (let ([m (regexp-match* LOOP-REGEXP lne #:match-select cdr)])
      (format "(loop ~a " (caar m)))]
   [(regexp-match? END-REGEXP lne) 
    ")"]
   [(regexp-match? INCREMENT-REGEXP lne) 
    (let ([m (regexp-match* INCREMENT-REGEXP lne #:match-select cdr)])
      (format "(incr ~a )" (caar m)))]
   [(regexp-match? COPY-REGEXP lne) 
    (let ([m (regexp-match* COPY-REGEXP lne #:match-select cdr)])
      (format "(copy ~a ~a)" (caar m) (cadar m)))]
   [(regexp-match? ZERO-REGEXP lne) 
    (let ([m (regexp-match* ZERO-REGEXP lne #:match-select cdr)])
      (format "(zero ~a )" (caar m)))]
   [else
    (begin
      (printf "ERROR: unable to parse line: ~s\n" lne)
      "")]
   )
  )

;; string -> string
;; Parse the ALGOL-like LOOP program into the Lisp-like string of code to be evaluated
;;  pgm  string with LOOP lines 
(define (parse-loop pgm)
  (define (parse-loop-helper v i)
    ; i=index of line in vector, t=string so far
    (if (>= i (vector-length v))
	""
	(string-append (one-line (vector-ref v i))
		       (parse-loop-helper v (+ i 1)))))

  (let ((lines (make-loop-program pgm)))
    (string-append "(" (parse-loop-helper lines 0) ")")))

;; ===== Driver routine
;; Run as with: (loop-without-parens "r0 = r0 + 1\nloop r0\n  r1 = r1 + 1\nend" '(3))
;; For more examples see the testing cases and the machines/*.loop files 

; Need a reasonable namespace for eval to work (contains definition of car, etc)
(define-namespace-anchor a)
(define ns (namespace-anchor->namespace a))

;; string, list -> number
;; Write loop programs in ALGOL-like syntax, then interpret them.  This is the
;; driver routine. Returns the contents of r0.
;; (Coding note: They are nested let's because a letrec or a let* makes Dr Racket freeze.)
(define (loop-without-parens pgm data)
  (when (display-list?)
    (printf "LOOP program=~s\n  with data=~s\n" pgm data)
    (printf "  ... translates to ~a\n" (parse-loop pgm)))
  (let ([ps (string-append "'" (parse-loop pgm))]) 
    (let ([pl (eval (read (open-input-string ps)) ns)])
      (interpret pl data)
      )
    )
)
(provide loop-without-parens)

;; ============= Running from the command line =========
;; Gratitude to https://jackwarren.info/posts/guides/racket/racket-command-line/

;; Parameters with defaults

;; Display the list translation of the LOOP program, if true
(define display-list? (make-parameter #f))

;; Name of file containing the LOOP program
(define filename (make-parameter null))

;; Output this many registers
(define output (make-parameter 1))

;; Preload these natural numbers into r0 r1 etc.
(define preload (make-parameter null))

;; At each step show the registers, if true
(define show-registers? (make-parameter #f))

;; Talk a lot, if true
(define verbose? (make-parameter #f))

(provide output)

;; For running from the command line; the "module+ main" is the Racket construct to execute code
;; when running from the command line but not from an importing module
(module+ main

  (define command-line-parser
    (command-line
     #:usage-help 
     "Simulate a LOOP machine."
     "Put LOOP instructions on separate lines.  You can indent, or use # as comment character."
     #:once-each
     [("-d" "--display-list") "Display the command string that the LOOP program is translated to"
                              (display-list? #t)]
     [("-f" "--filename") loopfn "Name of file with the LOOP program, as in \"machines/simple.loop\""
                          (filename loopfn)]
     [("-o" "--output-registers") num-registers "At end of run, show contents of  this many registers (default 1)"
                          (output (string->number num-registers))]
     [("-p" "--preload") preloadstring "List of natural numbers to preload registers, probably quoted as in \"3 2 1\""
                          (preload (apply list (map string->number (string-split preloadstring))))]
     [("-s" "--show-registers") "Show the registers for each step"
                                (show-registers? #t)]
     [("-v" "--verbose") "Verbose mode" (verbose? #t)]
     #:args  () (void)))

  (when (verbose?)
    (begin
      (show-registers? #t)
      (display-list? #t)))
  
  ;; Read the file with the LOOP program
  (define LOOP-LINES '())  ;; list of file lines, one string per instruction
  ; (printf "filename=~s\n" filename)
  (if (null? (filename))
    (set! LOOP-LINES "") ;; should instead fail?
    (set! LOOP-LINES
          (port->string (open-input-file (filename)) #:close? #t)))

  (printf "~a\n" (loop-without-parens LOOP-LINES (preload)))  ; print the result to stdout
)


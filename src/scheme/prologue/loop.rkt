#! /usr/bin/env racket
#lang racket
(require racket/cmdline)

;; loop.rkt
;; Run programs in LOOP.
;; Adapted from _Computability in an Intro Course on Programming_
;; by Hans Jurgen Schnieder


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
;; Show the contents of the registers, for debugging
;(define (show-regs) 
;  (write REGISTERS) (newline))
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
  (hash-set! REGISTERS (make-reg-name 0) 0))

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

;; If you get a reg, it creates it, containing 0

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

;; Implement each operation
(define (intr-zero pars)
  (set-reg-value! (car pars) 0)
  (show-regs))
(define (intr-incr pars)
  (increment-reg! (car pars))
  (show-regs))
(define (intr-copy pars)
  (set-reg-value! (car pars) (get-reg-value (cadr pars)))
  (show-regs))
(define (intr-loop pars)
  ; (printf "intr-loop: pars=~a" pars)
  (letrec ([reps (get-reg-value (car pars))]
	   [body (cdr pars)]
	   [iter (lambda (rep)
		   (cond 
		    ((equal? rep 0) '())
		    (else (intr-body body)
			  (iter (- rep 1)))))])
    ; (printf "intr-loop: reps=~a body=~a\n" reps body)
    ; (show-regs)
    (printf "--start loop of ~a repetitions--\n" reps)
    (iter reps)))


;; intr-body  Interpret the body of loop programs
(define (intr-body body)
  ; (printf "intr-body: body=~a\n" body)
  ; (printf "intr-body: REGISTERS=~a\n" REGISTERS)
  (cond 
   [(null? body) '()]
   [else (let ([next-inst (car body)]
	       [tail (cdr body)])
           ; (printf "  intr-body: next-inst=~a tail=~a\n" next-inst tail)
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


;; Code descends from Hans-Jurgen Schnieder "Computability in an Introductory
;; course on Programming" Bulletin of the European Association for Theoretical Computer Science,
;; EATCS 73 (2001), S. 153-164 ISSN: 0252–9742
;; The data is a list of the values to put in registers r0 r1 r2 ..
;; Value of a program is the value remaining in r0 at end.
(define (interpret progr data)
  ; (printf "interpret: progr=~s\n    data=~s\n" progr data)
  (init-regs data)
  (intr-body progr)
  ; (printf "  interpret: REGISTERS=~s\n" REGISTERS)
  (get-reg-value (make-reg-name 0)))

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

;; ===============================================
;; parse functions; go from ALGOL syntax to LISP syntax

;; split-program-into-lines  split the string by newlines
(define (split-program-into-lines p)
  (string-split p "\n"))

;; A loop-program is a vector of strings, one per program line
(define (make-loop-program p)
  (apply vector (split-program-into-lines p))) 

;; drop-comment  omit anything in the line from COMMENT-CHARACTER on out
(define COMMENT-CHARACTER #\#)
;(define (drop-comment ln)
;  (if (or (= (string-length ln) 0)
;	  (char=? (string-ref ln 0) COMMENT-CHARACTER))
;      ""  ; return empty string
;      (let ([split-ln (string-split ln (make-string 1 COMMENT-CHARACTER))])
;	(if (= (length split-ln) 1)   ; no comment char there
;	    ln
;	    (car split-ln)))))

;; split-line-into-toks  return the tokens, with comments and whitespace removed
;(define (split-line-into-toks ln)
;  (printf "split-line-into-toks ln=~s\n" ln)
;  (let* ([without-comment (drop-comment ln)]
;         [trimmed (string-trim without-comment)]
;         ; was: [csi-split (string-split without-comment " \n\t")])
;         [csi-split (regexp-split #px"\\s" trimmed)])
;    (printf "  split-line-into-toks csi-split=~s\n" csi-split)
;    (if (null? csi-split)
;        '("")
;        csi-split)))

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
;; one-line  Return a string translation of the one line, already in tokens
(define (one-line lne)
;   (printf "one-line input: tok-list=~s\n  lne=~s\n" tok-list lne)
;  (printf "  regexp-match? ~s\n" (regexp-match? INCREMENT-REGEXP lne))
;  (printf "    result of string-append: ~s\n" (string-append "(incr " (car tok-list) ")"))
  (cond
   [(regexp-match? EMPTY-LINE-REGEXP lne)
    ""]
   [(regexp-match? LOOP-REGEXP lne)
    (let ([m (regexp-match* LOOP-REGEXP lne #:match-select cdr)])
      (format "(loop ~a " (caar m)))]
    ; (string-append "(loop " (cadr tok-list) " ")]
   [(regexp-match? END-REGEXP lne) 
    ")"]
   [(regexp-match? INCREMENT-REGEXP lne) 
    (let ([m (regexp-match* INCREMENT-REGEXP lne #:match-select cdr)])
      (format "(incr ~a )" (caar m)))]
    ; (string-append "(incr " (car tok-list) ")")]
   [(regexp-match? COPY-REGEXP lne) 
    (let ([m (regexp-match* COPY-REGEXP lne #:match-select cdr)])
      (format "(copy ~a ~a)" (caar m) (cadar m)))]
   ; (string-append "(copy " (car tok-list) " " (caddr tok-list) ")")]
   [(regexp-match? ZERO-REGEXP lne) 
    (let ([m (regexp-match* ZERO-REGEXP lne #:match-select cdr)])
      (format "(zero ~a )" (caar m)))]
   ; (string-append "(zero " (car tok-list) ")")]
   [else
    (begin
      (printf "ERROR: unable to parse line: ~s\n" lne)
      "")]
   )
  )
;(define (one-line tok-list)
;  (printf "one-line input: tok-list=~s\n" tok-list)
;  (cond
;   [(or (null? tok-list) (equal? "" (car tok-list)))
;    ""]
;   [(equal? "loop" (car tok-list)) 
;    (string-append "(loop " (cadr tok-list) " ")]
;   [(equal? "end" (car tok-list)) 
;    ")"]
;   [(= (length tok-list) 5) 
;    (string-append "(incr " (car tok-list) ")")]
;   [(eq? (string->number (caddr tok-list)) #f) 
;    (string-append "(copy " (car tok-list) " " (caddr tok-list) ")")]
;   [else 
;    (string-append "(zero " (car tok-list) ")")]
;    )
;  )

;; parse-loop
(define (parse-loop pgm)
  (define (parse-loop-helper v i)  ; i=index of line in vector, t=string so far
;    (printf "  parse-loop-helper v=~s\n    length=~s\n    line number i=~s\n" v (vector-length v) i)
;    (unless (>= i (vector-length v))
;      (printf "    one-line returns: ~s\n" (one-line (vector-ref v i))))
    (if (>= i (vector-length v))
	""
	(string-append (one-line (vector-ref v i))
		       (parse-loop-helper v (+ i 1)))))

  (let ((lines (make-loop-program pgm)))
    ; (printf "parse-loop pgm=~s\n  lines=~s\n" pgm lines)
    (string-append "(" (parse-loop-helper lines 0) ")")))

;; interpret-string;  interpret a string as Scheme code
; (define FN "fn.scm")
; File name for temp file
;(define FN (string-append "fn" (~r (random 1 9999) #:min-width 4 #:pad-string "0") ".scm"))
;(printf "FN=~s\n" FN)
;(define (interpret-string s)
;  (printf "interpret-string s=~s\n" s)
;  ; (eval (read (open-input-string s)) ns)
;  ; (eval s ns)
;  ; (printf "  interpreted string pe=~s\n" pe)
;  (define myfile (open-output-file FN))
;  (display s myfile)
;  (close-output-port myfile)
;;  (parameterize ([current-namespace (namespace-anchor->namespace a)])
;  (load FN)
;  )

; Need a reasonable namespace for eval to work
(define-namespace-anchor a)
(define ns (namespace-anchor->namespace a))

;; loop-without-parens  Write loop programs in ALGOL-like syntax
;; (They are nested let's because if I do a letrec or a let* then Dr Racket freezes)
(define (loop-without-parens pgm data)
  (printf "LOOP program=~s\n    data=~s\n" pgm data)
  (printf "TRANSLATES TO ~a\n\n" (parse-loop pgm))
  (let ([ps (string-append "'" (parse-loop pgm))]) 
    (let ([pl (eval (read (open-input-string ps)) ns)])
      ; (printf "  loop-without-parens pl=~s\n    ps=~s\n" pl ps)
      (interpret pl data)
      )
    )
)
(provide loop-without-parens)

;; ============= Running from the command line =========
;; Gratitude to https://jackwarren.info/posts/guides/racket/racket-command-line/


;; Parameters with defaults

;; Name of file containing the LOOP program
(define filename (make-parameter null))

;; At each step show the registers, if true
(define show-registers? (make-parameter #f))

;; Display the list translation of the LOOP program, if true
(define display-list? (make-parameter #f))

;; Talk a lot, if true
(define verbose? (make-parameter #f))

;; For running from the command line; this is the Racket construct to execute code from
;; command line but not from an importing module
(module+ main

  (define command-line-parser
    (command-line
     #:usage-help 
     "Simulate a LOOP machine."
     "Put LOOP instructions on separate lines.  You can indent."
     #:once-each
     [("-d" "--display-list") "Display the string that the LOOP program is translated to"
                              (display-list? #t)]
     [("-f" "--filename") loopfn "Name of file with the LOOP program"
                          (filename loopfn)]
     [("-s" "--show-registers") "Show the registers for each step"
                                (show-registers? #t)]
     [("-v" "--verbose") "Verbose mode" (verbose? #t)]
     #:args  () (void)))

  ;; Read the file with the LOOP program
  (define LOOP-LINES '())  ;; list of file lines, one string per instruction
  ; (printf "filename=~s\n" filename)
  (if (null? (filename))
    (set! LOOP-LINES "")
    (set! LOOP-LINES
          (port->string (open-input-file (filename)) #:close? #t)))

  (printf "~a" (loop-without-parens LOOP-LINES '()))
)


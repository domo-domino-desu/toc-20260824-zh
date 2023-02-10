#! /usr/bin/env racket
#lang racket
(require racket/cmdline)

;; loop.rkt
;; Run programs in LOOP.
;; Adapted from _Computability in an Intro Course on Programming_
;; by Hans Jurgen Schnieder

;; ===== Primitive recursive functions
;; Defns for primitive recursive functions, for fun

;; integer -> integer
;; Always return zero
(define (Z x)
  0)
;(module+ test
;  (require rackunit)
;  (check-equal? 0 (Z 0))
;  (check-equal? 0 (Z 1))
;  )

;; integer -> integer
;; Return the successor of the input
(define (successor x)
  (+ 1 x))
;(module+ test
;  (require rackunit)
;  (check-equal? 1 (successor 0))
;  (check-equal? 2 (successor 1))
;  )


(define (i1_1 x0)  ;; projections 
  x0)
(define (i2_1 x0 x1) 
  x0)
(define (i2_2 x0 x1) 
  x1)
(define (i3_1 x0 x1 x2) 
  x0)
(define (i3_2 x0 x1 x2) 
  x1)
(define (i3_3 x0 x1 x2) 
  x2)

(provide Z
         successor
         i1_1
         i2_1
         i2_2
         i3_1
         i3_2
         i3_3)

;; Schema of primitive recursion, for arity 1 and 2

(define (pred x)  ;; convenience for defn of schema of prim rec
  (if (= x 0)
      0
      (- x 1)))

(provide pred)

;; prim-rec-1  Return a function of one variable computed by primitive recursion
(define (prim-rec-1 g h)  ;; g fcn of 0 args, h fcn of 2 args
  (define (f y)
    (if (= y 0)
	g
	(h (f (pred y)) (pred y))))
  f)

;; prim-rec-2  Return a fcn of two variables computed by primitive recursion
(define (prim-rec-2 g h)   ;; g fcn of 1 arg, h fcn of 3 args
  (define (f x0 y)
    (if (= y 0)
	(g x0)
	(h (f x0 (pred y))  x0 (pred y))))
  f)

(provide prim-rec-1
         prim-rec-2)


;; Some simple ones
(define plus
  (prim-rec-2 i1_1
	      (lambda (w x0 z) (successor w))))

(define product
  (prim-rec-2 Z
	      (lambda (w x0 z) (plus w x0))))

(define (one x)
  (successor (Z x)))

(define power 
  (prim-rec-2 one
	      (lambda (w x0 z) (product w x0))))

(define propersub
  (prim-rec-2 i1_1
	      (lambda (w x0 z) (pred w))))

(provide plus
         product
         one
         power
         propersub)



;; ==== LOOP programs ==============

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
    (string-join reg-strings)))

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
    (iter reps)
    (show-regs)))


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
  (printf "interpret: progr=~s\n    data=~s\n" progr data)
  (init-regs data)
  (intr-body progr)
  (printf "  interpret: REGISTERS=~s\n" REGISTERS)
 
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
(define (drop-comment ln)
  (if (or (= (string-length ln) 0)
	  (char=? (string-ref ln 0) COMMENT-CHARACTER))
      ""  ; return empty string
      (let ([split-ln (string-split ln (make-string 1 COMMENT-CHARACTER))])
	(if (= (length split-ln) 1)   ; no comment char there
	    ln
	    (car split-ln)))))

;; split-line-into-toks  return the tokens, with comments and whitespace removed
(define (split-line-into-toks ln)
  ; (printf "split-line-into-toks ln=~s\n" ln)
  (let* ([without-comment (drop-comment ln)]
         [trimmed (string-trim without-comment)]
         ; was: [csi-split (string-split without-comment " \n\t")])
         [csi-split (regexp-split #px"\\s" trimmed)])
    ; (printf "  split-line-into-toks csi-split=~s\n" csi-split)
    (if (null? csi-split)
        '("")
        csi-split)))

;; one-line  Return a string translation of the one line, already in tokens
(define (one-line tok-list)
  ; (printf "one-line input: tok-list=~s\n" tok-list)
  (cond
   [(or (null? tok-list) (equal? "" (car tok-list)))
    ""]
   [(equal? "loop" (car tok-list)) 
    (string-append "(loop " (cadr tok-list) " ")]
   [(equal? "end" (car tok-list)) 
    ")"]
   [(= (length tok-list) 5) 
    (string-append "(incr " (car tok-list) ")")]
   [(eq? (string->number (caddr tok-list)) #f) 
    (string-append "(copy " (car tok-list) " " (caddr tok-list) ")")]
   [else 
    (string-append "(zero " (car tok-list) ")")]
    )
  )

;; parse-loop
(define (parse-loop pgm)
  (define (parse-loop-helper v i)  ; i=index of line in vector, t=string so far
    ; (printf "  parse-loop-helper v=~s    i=~s\n" v i)
    ;; (printf "    parse-loop-helper (one-line (split-line-into-toks (vector-ref v i)))=~s\n" (one-line (split-line-into-toks (vector-ref v i))))
    ; (printf "    (vector-length v)=~s i=~s\n" (vector-length v) i)
    (if (>= i (vector-length v))
	""
	(string-append (one-line (split-line-into-toks (vector-ref v i)))
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
  (printf "loop-without-parens pgm=~s\n    data=~s\n" pgm data)
  (let ([ps (string-append "'" (parse-loop pgm))]) 
    (let ([pl (eval (read (open-input-string ps)) ns)])
      ; (printf "  loop-without-parens pl=~s\n    ps=~s\n" pl ps)
      (interpret pl data)
      )
    )
)
(provide loop-without-parens)

;; ============= Running from the command line =========
;; Gratitude for https://jackwarren.info/posts/guides/racket/racket-command-line/


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
  (printf "filename=~s\n" filename)
  (if (null? (filename))
    (set! LOOP-LINES "")
    (set! LOOP-LINES
          (port->string (open-input-file (filename)) #:close? #t)))

  (printf "~a" (loop-without-parens LOOP-LINES '()))
)


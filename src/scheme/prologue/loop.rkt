#lang racket
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
(define (show-regs) 
  (write REGISTERS) (newline))

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
  (set-reg-value! (car pars) 0))
(define (intr-incr pars)
  (increment-reg! (car pars)))
(define (intr-copy pars)
  (set-reg-value! (car pars) (get-reg-value (cadr pars))))
(define (intr-loop pars)
  (letrec ([reps (get-reg-value (car pars))]
	   [body (cdr pars)]
	   [iter (lambda (rep)
		   (cond 
		    ((equal? rep 0) '())
		    (else (intr-body body)
			  (iter (- rep 1)))))])
    (iter reps)))


;; intr-body  Interpret the body of loop programs
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

;; Code descends from Hans-Jurgen Schnieder "Computability in an Introductory
;; course on Programming"
;; The data is a list of the values to put in registers r0 r1 r2 ..
;; Value of a program is the value remaining in r0 at end.
(define (interpret progr data)
  (init-regs data)
  (intr-body progr)
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
  (let* ([without-comment (drop-comment ln)]
	 [csi-split (string-split without-comment " \n\t")])
	(if (null? csi-split)
	    '("")
	    csi-split)))

;; one-line  Return a string translation of the one line, already in tokens
(define (one-line tok-list)
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
    (if (>= i (vector-length v))
	""
	(string-append (one-line (split-line-into-toks (vector-ref v i)))
		       (parse-loop-helper v (+ i 1)))))

  (let ((lines (make-loop-program pgm)))
    (string-append "(" (parse-loop-helper lines 0) ")")))

;; interpret-string;  interpret a string as Scheme code
(define FN "fn.scm")
(define (interpret-string s)
  (define myfile (open-output-file FN))
  (display s myfile)
  (close-output-port myfile)
  (load FN))

;; loop-without-parens  Write loop programs in ALGOL-like syntax
(define (loop-without-parens pgm data)
  (let ((pl (string-append "(define pe '" (parse-loop pgm) ")")))
    (interpret-string pl)
    (interpret pl data)))



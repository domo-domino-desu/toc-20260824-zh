;; Run programs in LOOP.
;; Adapted from _Computability in an Intro Course on Programming_
;; by Hans Jurgen Schnieder

;; defns for primitive recursive functions, for fun
(define (Z x)
  0)
(define (succ x)
  (+ x 1))
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

(define (pred x)  ;; convenience for defn of schema of prim rec
  (if (= x 0)
      0
      (- x 1)))

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

(define plus
  (prim-rec-2 i1_1
	      (lambda (w x0 z) (succ w))))
(define product
  (prim-rec-2 Z
	      (lambda (w x0 z) (plus w x0))))
(define (one x)
  1)
(define power 
  (prim-rec-2 one
	      (lambda (w x0 z) (product w x0))))

(define propersub
  (prim-rec-2 i1_1
	      (lambda (w x0 z) (pred w))))



;; ==================== LOOP programs ======

;; A register is a pair (name:symbol contents:natural number)
(define REGLIST '())
(define (show-regs)  ; debugging
  (write REGLIST)
  (newline))

(define (clear-regs!)
  (set! REGLIST '()))

;; make-reg-name  return the symbol giving the standard name of a register
(define (make-reg-name i)
  (string->symbol (string-append "r" (number->string i))))

;; Getters and setters for the list of registers
;; set-reg-value! Set the value of an existing register or initialize a new one
(define (set-reg-value! r v)
  (set! REGLIST (alist-update! r v REGLIST equal?)))
;; get-reg  Return pair whose car is given r; if no such reg, return (r . 0)
(define (get-reg r) 
  (let ((val (assoc r REGLIST)))
    (if val
	val
	(begin
	  (set-reg-value! r 0)
	  (cons r 0))))) 
(define (get-reg-value r) 
  (cdr (get-reg r))) 

;; increment-reg!  Increment the register
(define (increment-reg! r)
  (set-reg-value! r (+ 1 (get-reg-value r))))
;; copy-reg! Copy value from r0 to r1, leave r0 unchanged 
(define (copy-reg! r0 r1)
  (set-reg-value! r1 (get-reg-value r0))) 

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

;; intr-zero, intr-incr, intr-copy, intr-loop:  implement each operation
(define (intr-zero pars)
  (set-reg-value! (car pars) 0))
(define (intr-incr pars)
  (increment-reg! (car pars)))
(define (intr-copy pars)
  (set-reg-value! (car pars) (get-reg-value (cadr pars))))
(define (intr-loop pars)
  (letrec ((reps (get-reg-value (car pars)))
	   (body (cdr pars))
	   (iter (lambda (rep)
		   (cond 
		    ((equal? rep 0) '())
		    (else (intr-body body)
			  (iter (- rep 1)))))))
    (iter reps)))

;; intr-body  Interpret the body of loop programs
(define (intr-body body)
  (cond 
   ((null? body) '())
   (else (let ((next-inst (car body))
	       (tail (cdr body)))
	   (let ((key (car next-inst))
		 (pars (cdr next-inst)))
	     (cond
	      ((eq? key 'zero) (intr-zero pars))
	      ((eq? key 'incr) (intr-incr pars))
	      ((eq? key 'copy) (intr-copy pars))
	      ((eq? key 'loop) (intr-loop pars))))
	   (intr-body tail)))))

;; Code descends from Hans-Jurgen Schnieder "Computability in an Introductory
;; course on Programming"
;; The data is a list of the values to put in registers r0 r1 r2 ..
;; Value of a program is the value remaining in r0 at end.
(define (interpret progr data)
  (init-regs data)
  (intr-body progr)
  (get-reg-value (make-reg-name 0)))


  

;; COMPUTER is a global variable storing the information
;; (define COMPUTER (make-vector 3))
;; (define IP-INDEX 0)
;; (define LOOPCOUNT-INDEX 1)
;; (define REGISTERS-INDEX 2)

;; (define (initialize-computer)
;;   (set! COMPUTER (vector 0 '() REGLIST)))
;; (define (get-IP)
;;   (vector-ref COMPUTER IP-INDEX))
;; (define (set-IP i)
;;   (vector-set! COMPUTER IP-INDEX i))
;; ;; a loopcount is a list of pairs (dex:natural lineno:natural)
;; ;; the dex is counted down each time through the loop; lineno is where LOOP is
;; (define (get-LOOPCOUNT)
;;   (vector-ref COMPUTER LOOPCOUNT-INDEX))
;; (define (set-LOOPCOUNT! list-of-pairs)
;;   (vector-set! COMPUTER LOOPCOUNT-INDEX list-of-pairs))
;; (define (get-LOOPCOUNT-pair)
;;   (car (get-LOOPCOUNT)))
;; (define (set-LOOPCOUNT-pair! pr)
;;   (cons pr (cdr (get-LOOPCOUNT))))

;; (define (get-LOOPCOUNT-pair-dex)
;;   (car (get-LOOPCOUNT-pair)))
;; (define (get-LOOPCOUNT-pair-lineno)
;;   (cadr (get-LOOPCOUNT-pair)))
;; (define (set-LOOPCOUNT-pair-dex! newdex)
;;   (set-LOOPCOUNT-pair!) (list newdex (get-LOOPCOUNT-pair-lineno)))
;; (define (set-LOOPCOUNT-pair-lineno! newlineno)
;;   (set-LOOPCOUNT-pair!) (list (get-LOOPCOUNT-pair-dex) newlineno))

;; (define (push-LOOPCOUNT-pair pr)
;;   (set-LOOPCOUNT! (cons pr (get-LOOPCOUNT))))
;; (define (pop-LOOPCOUNT-pair)
;;   (set-LOOPCOUNT! (cdr (get-LOOPCOUNT))))
;; (define (decrement-LOOPCOUNT-dex)
;;   (let ((d (get-LOOPCOUNT-dex)))
;;     (if (= d 0)
;; 	(pop-LOOPCOUNT-pair)
;; 	(set-LOOPCOUNT-pair-dex! (- d 1)))






;; ;; parse functions

;; ;; split-program-into-lines  split the string by newlines
;; (define (split-program-into-lines p)
;;   (string-split p "\n"))

;; ;; A loop-program is a vector of strings, one per program line
;; (define (make-loop-program p)
;;   (apply vector (split-program-into-lines p))) 

;; ;; drop-comment  omit anything in the line from COMMENT-CHARACTER on out
;; (define COMMENT-CHARACTER #\#)
;; (define (drop-comment ln)
;;   (if (or (= (string-length ln) 0)
;; 	  (char=? (string-ref ln 0) COMMENT-CHARACTER))
;;       ""
;;       (let ((split-ln (string-split ln (make-string 1 COMMENT-CHARACTER))))
;; 	(if (= (length split-ln) 1)
;; 	    ln
;; 	    (car split-ln)))))

;; ;; split-line-into-toks  return the tokens, with comments and whitespace removed
;; (define (split-line-into-toks ln)
;;   (let* ((without-comment (drop-comment ln))
;; 	 (csi-split (string-split without-comment " \n\t")))
;; 	(if (null? csi-split)
;; 	    '("")
;; 	    csi-split)))








;; ;; decide-instruction-type  from a list of strings decide the instruction
;; (define (instruction-type inst)
;;   (let ((toks (split-line-into-toks inst)))
;;     (cond 
;;      ((or (null? toks)
;; 	  (eqv? '("") toks)) 
;;       "")
;;      ((string-ci=? "end" (car toks)) " ) ")
;;      ((string-ci=? "loop" (car toks)) (string-append " (loop " (cadr toks)))
;;      ((number? (caddr toks)) (string-append " (initialize " (car toks) " " (caddr toks) " ) "))
;;      ((= 3 (length inst-list)) "copy")
;;      (else "increment")))

;; ;; parse-instructions
;; (define (parse-instructions inst-list)
;;   (define (parse-instructions-helper s inst-list)
;;     (if (null? inst-list)
;; 	s
;; 	(let ((next-line (car inst-list))
;; 	      (remainder (cdr inst-list)))
	  
;; 	  )))

;;   (parse-instructions-helper "" inst-list)
;; )

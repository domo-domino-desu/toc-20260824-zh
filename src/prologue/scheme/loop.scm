;; Run programs in LOOP.
;; Adapted from _Computability in an INtro Course on Programming_
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

;; prim-rec-2  Return a function of two variables comuted by primitive recursion
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

;; A register is a pair (name contents)
(define REGLIST '())

;; Getters and setters for the list of registers
(define (get-reg r) 
  (assq r REGLIST)) 
(define (get-reg-value r) 
  (cdr (get-reg r))) 
;; set-reg-value! Set the value of an existing register or initialize a new one
(define (set-reg-value! r v) 
  (let ((newval (cons r v)))
    (if (assq r REGLIST)
	(alist-update! r v REGLIST)
	(set! REGLIST (append REGLIST (list newval))))))

;; increment-reg!  Increment the register
(define (increment-reg! r)
  (set-reg-value! r (+ 1 (get-reg-value r))))
;; copy-reg! Copy value from r0 to r1, leave r0 unchanged 
(define (copy-reg! r0 r1)
  (set-reg-value! r1 (get-reg-value r0))) 


;; parse functions

;; split-program-into-lines  split the string by newlines
(define (split-program-into-lines p)
  (string-split p "#\newline"))

;; split-line-into-toks  return the tokens, with comments and whitespace removed
(define (split-line-into-toks ln)
  (let ((without-comment (car (string-split ln "#"))))
    (string-split without-comment)))

;; decide-instruction-type  from a list of strings decide the instruction
(define (decide-instruction-type inst-list)
  (cond 
   ((null? inst-list) "none")
   ((string-ci=? "loop" (car inst-list)) "loop")
   ((number? (caddr inst-list)) "initialize")
   ((= 3 (length inst-list)) "copy")
   (else "increment")))
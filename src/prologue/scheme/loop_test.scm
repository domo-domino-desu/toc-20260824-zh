(require-extension test)
(include "loop.scm")


;; ======= zero
(test-begin "zero")
(test-assert (= 0 (Z 0)))
(test-assert (= 0 (Z 1)))
(test-end "zero")


;; ======= successor
(test-begin "successor")
(test-assert (= 1 (succ 0)))
(test-assert (= 2 (succ 1)))
(test-end "successor")


;; ======= projection
(test-begin "projection")
(test-assert (= 0 (i1_1 0)))
(test-assert (= 1 (i1_1 1)))
(test-assert (= 0 (i2_1 0 1)))
(test-assert (= 1 (i2_1 1 1)))
(test-assert (= 0 (i2_2 0 0)))
(test-assert (= 1 (i2_2 0 1)))
(test-assert (= 0 (i3_1 0 1 2)))
(test-assert (= 1 (i3_1 1 1 2)))
(test-assert (= 1 (i3_2 0 1 2)))
(test-assert (= 0 (i3_2 1 0 2)))
(test-assert (= 2 (i3_3 0 1 2)))
(test-assert (= 0 (i3_3 2 1 0)))
(test-end "projection")




;; ======= predecessor
(test-begin "predecessor")
(test-assert (= 0 (pred 1)))
(test-assert (= 1 (pred 2)))
(test-assert (= 0 (pred 0)))
(test-end "predecessor")


;; ======= plus
(test-begin "plus")
(test-assert (= 0 (plus 0 0)))
(test-assert (= 5 (plus 5 0)))
(test-assert (= 7 (plus 5 2)))
(test-assert (= 5 (plus 0 5)))
(test-end "plus")



;; ======= product
(test-begin "product")
(test-assert (= 0 (product 0 0)))
(test-assert (= 0 (product 0 5)))
(test-assert (= 0 (product 1 0)))
(test-assert (= 6 (product 2 3)))
(test-end "product")


;; ======= power
(test-begin "power")
(test-assert (= 1 (power 2 0)))
(test-assert (= 1 (power 0 0)))
(test-assert (= 2 (power 2 1)))
(test-assert (= 25 (power 5 2)))
(test-end "power")


;; ======= propersub
(test-begin "propersub")
(test-assert (= 2 (propersub 5 3)))
(test-assert (= 1 (propersub 4 3)))
(test-assert (= 0 (propersub 3 3)))
(test-assert (= 0 (propersub 3 5)))
(test-assert (= 0 (propersub 0 0)))
(test-end "propersub")


;;;; ==================== LOOP programs ======


;; ======= getters and setters
(test-begin "register getters and setters")
(test-assert "make-reg-name: return a symbol?"
	     (symbol? (make-reg-name 0)))
(test-assert "  generic case"
	     (equal? "r0" (symbol->string (make-reg-name 0))))

(define (initialize-REGLIST)
  (set! REGLIST (list (cons (make-reg-name 0) 0) (cons (make-reg-name 1) 1))))

(initialize-REGLIST)
(test-assert "get-reg: generic"
	     (equal? (cons (make-reg-name 0) 0) 
		     (get-reg (make-reg-name 0))))
(test-assert "  generic"
	     (equal? (cons (make-reg-name 1) 1) 
		     (get-reg (make-reg-name 1))))
(test-assert (= 0 (get-reg-value (make-reg-name 0))))
(test-assert (= 1 (get-reg-value (make-reg-name 1))))
(test-assert "register getters and setters: no such register"
	     (= 0 (get-reg-value (make-reg-name 3))))
(test-assert (= 4 (begin 
		    (set-reg-value! (make-reg-name 0) 4)
		    (get-reg-value (make-reg-name 0)))))
(test-assert "update existing register" 
	     (= 4 (begin 
		    (set-reg-value! (make-reg-name 0) 4)
		    (get-reg-value (make-reg-name 0)))))
(test-assert "create new register"
	     (= 4 (begin 
		    (set-reg-value! (make-reg-name 2) 4)
		    (get-reg-value (make-reg-name 2)))))
(test-end "register getters and setters")


;; ======= initialize registers
(test-begin "register initialize")
(init-regs '(1 2 3))
;; (show-regs)
(test-assert "register initialize: generic initialization" 
	     (= 1 (get-reg-value (make-reg-name 0))))
(test-assert "  generic initialization" 
	     (= 2 (get-reg-value (make-reg-name 1))))
(test-assert "  generic initialization" 
	     (= 3 (get-reg-value (make-reg-name 2))))
(init-regs '())
(test-assert "  empty initialization" 
	     (= 0 (get-reg-value (make-reg-name 0))))
(test-assert "  empty initialization" 
	     (= 0 (get-reg-value (make-reg-name 1))))
(init-regs '(1 2 3))
(init-regs '(4 5 6))
;; (show-regs)
(test-assert "  redo initialization" 
	     (= 4 (get-reg-value (make-reg-name 0))))
(test-assert "  generic initialization" 
	     (= 5 (get-reg-value (make-reg-name 1))))
(test-assert "  generic initialization" 
	     (= 6 (get-reg-value (make-reg-name 2))))
(test-end "register initialize")


;; ======= simple operation implementations
(test-begin "simple operation implementations")
(init-regs '(1 2 3))
(intr-zero (list (make-reg-name 0)))
(test-assert "intr-zero: generic test"
	     (= 0 (get-reg-value (make-reg-name 0))))
(test-assert "  generic test"
	     (= 2 (get-reg-value (make-reg-name 1))))
(test-assert " generic test"
	     (= 0 (get-reg-value (make-reg-name 5))))
(init-regs '(1 2 3))
(intr-incr (list (make-reg-name 0)))
(test-assert "intr-incr: generic test"
	     (= 2 (get-reg-value (make-reg-name 0))))
(test-assert "  generic test"
	     (= 2 (get-reg-value (make-reg-name 1))))
(init-regs '(1 2 3))
(intr-copy (list (make-reg-name 0) (make-reg-name 1)))
; (show-regs)
(test-assert "intr-copy: generic test"
	     (= 2 (get-reg-value (make-reg-name 0))))
(test-assert "  generic test"
	     (= 2 (get-reg-value (make-reg-name 1))))
(test-assert "  generic test"
	     (= 3 (get-reg-value (make-reg-name 2))))
(test-end "simple operation implementations")




;; ======= loop and body
(test-begin "loop and body")
(init-regs '(1 2 3))
(define bd '((zero r0)))
; (show-regs)
(intr-body bd)
(test-assert "intr-body: simple test"
	     (= 0 (get-reg-value (make-reg-name 0))))
(test-assert "  simple test"
	     (= 2 (get-reg-value (make-reg-name 1))))
(init-regs '(1 2 3))
(define bd '((zero r0) (incr r1)))
(intr-body bd)
(test-assert "intr-body: two steps"
	     (= 0 (get-reg-value (make-reg-name 0))))
(test-assert "  two steps"
	     (= 3 (get-reg-value (make-reg-name 1))))
(init-regs '(1 2 3))
(define bd '((zero r1) (incr r2)))
(intr-body bd)
(test-assert "intr-body: other two steps"
	     (= 1 (get-reg-value (make-reg-name 0))))
(test-assert "  other two steps"
	     (= 0 (get-reg-value (make-reg-name 1))))
(test-assert "  other two steps"
	     (= 4 (get-reg-value (make-reg-name 2))))
(init-regs '(1 2 3))
(define bd '((incr r0) (copy r1 r2)))
(intr-body bd)
(test-assert "intr-body: include copy"
	     (= 2 (get-reg-value (make-reg-name 0))))
(test-assert "  include copy"
	     (= 3 (get-reg-value (make-reg-name 1))))
(test-assert "  include copy"
	     (= 3 (get-reg-value (make-reg-name 2))))
(define bd '((zero r0) (loop r2 (incr r0))))
(init-regs '(1 2 3))
(intr-body bd)
(test-assert "intr-body: include loop"
	     (= 3 (get-reg-value (make-reg-name 0))))
(test-assert "  include loop"
	     (= 2 (get-reg-value (make-reg-name 1))))
(test-assert "  include loop"
	     (= 3 (get-reg-value (make-reg-name 2))))
(define bd '((zero r0) (loop r2 (incr r0))))
(init-regs '(1 2 3))
(interpret bd '(1 2 3))
(test-assert "interpret: generic"
	     (= 3 (get-reg-value (make-reg-name 0))))
(test-assert "  generic"
	     (= 2 (get-reg-value (make-reg-name 1))))
(test-assert "  generic"
	     (= 3 (get-reg-value (make-reg-name 2))))
(define bd '((zero r0) (loop r1 (loop r2 (incr r0)))))
(init-regs '(10 20 30))
(interpret bd '(1 2 3))
(test-assert "interpret: nested loop"
	     (= 6 (get-reg-value (make-reg-name 0))))
(test-assert "  nested loop"
	     (= 2 (get-reg-value (make-reg-name 1))))
(test-assert "  nested loop"
	     (= 3 (get-reg-value (make-reg-name 2))))
(test-end "loop and body")


;; ;; ======= simulate the instructions, except LOOP
;; (test-begin "register manipulations")
;; (initialize-REGLIST)
;; (test-assert "increment register" 
;; 	     (= 4 (begin 
;; 		    (set-reg-value! #\A 3)
;; 		    (increment-reg! #\A)
;; 		    (get-reg-value #\A))))
;; (test-assert "copy register" 
;; 	     (= 5 (begin 
;; 		    (set-reg-value! #\A 5)
;; 		    (set-reg-value! #\B 3)
;; 		    (copy-reg! #\A #\B)
;; 		    (get-reg-value #\B))))
;; (test-end "register manipulations")


;; ;; ======= parse functions
;; (test-begin "parse functions")
;; ; Cut the string by newlines
;; (test-assert (equal? '("a b c" "d e f") 
;; 		     (split-program-into-lines (string-append "a b c" "\n" "d e f"))))
;; (test-assert (equal? '("a b c") 
;; 		     (split-program-into-lines "a b c")))
;; ; omit anything after the comment character
;; (test "drop-comment: no comment character to drop"
;;       "abc def"
;;       (drop-comment "abc def"))
;; (test "  generic comment"
;;       "abc"
;;       (drop-comment "abc# def"))
;; (test "  space before comment char"
;;       "abc "
;;       (drop-comment "abc # def"))
;; (test "  two comment chars"
;;       "abc"
;;       (drop-comment "abc# def # ghi"))
;; (test "  comment char starts line"
;;       ""
;;       (drop-comment "# abc def"))
;; ; split-line-into-toks
;; (test "split-line-into-toks: generic split"
;;       '("abc" "def")
;;       (split-line-into-toks "abc def"))
;; (test "  return three toks"
;;       '("abc" "def" "g")
;;       (split-line-into-toks "abc def g"))
;; (test "  return one tok"
;;       '("abc")
;;       (split-line-into-toks "abc "))
;; (test "  include comment"
;;       '("abc" "def")
;;       (split-line-into-toks "abc def# comment"))
;; (test "  empty line"
;;       '("")
;;       (split-line-into-toks ""))
;; (test "  extra whitespace"
;;       '("abc" "def")
;;       (split-line-into-toks "abc    def"))
;; (test "  extra whitespace"
;;       '("abc" "def")
;;       (split-line-into-toks "     abc def"))
;; (test "  extra whitespace"
;;       '("abc" "def")
;;       (split-line-into-toks "abc def    "))
;; (test-end "parse functions")





;; --------------------------- required footer

(display (string-append "TOTAL NUMBER OF FAILURES OVER ALL TESTS: "
			(number->string (test-failure-count))))
(newline)

(test-exit)
;; When running this from the command line, test for return code with
;; $ echo $?
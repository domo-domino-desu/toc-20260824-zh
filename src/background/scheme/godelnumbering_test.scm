(use test)
(include "godelnumbering.scm")


;; ======= triangle-num
(test-begin "triangle-num")
(test #t (= 0 (triangle-num 0)))
(test #t (= 1 (triangle-num 1)))
(test #t (= 3 (triangle-num 2)))
(test #t (= 6 (triangle-num 3)))
(test #t (= 10 (triangle-num 4)))
(test-end "triangle-num")


;; ======= diagonal enumeration
(test-begin "diagonal enumeration")
(test #t (= 0 (g 0 0)))
(test #t (= 1 (g 0 1)))
(test #t (= 2 (g 1 0)))
(test #t (= 3 (g 0 2)))
(test #t (= 4 (g 1 1)))
(do ((i 0 (+ i 1)))
    ((= i 10) '())
  (test #t (= (triangle-num i) (g 0 i))))
(test-end "diagonal enumeration")


;; ======= diagonal number from diagonal enumeration
(test-begin "diagonal number from enumeration")
(test #t (= 0 (diag-num (g 0 0))))  ; (0,0) is on diagonal 0
(test #t (= 1 (diag-num (g 0 1))))  ; (0,1) is on diagonal 1
(test #t (= 1 (diag-num (g 1 0))))  ; 
(test #t (= 2 (diag-num (g 0 2))))  ; 
(test #t (= 2 (diag-num (g 1 1))))  ; 
(do ((x 0 (+ x 1))
     (y 0 (+ y 1)))
    ((= (+ x y) 10) '())
  (test #t (= (+ x y) (diag-num (g x y)))))
(test-end "diagonal number from enumeration")


;; ======= xy from diagonal enumeration
(test-begin "xy from enumeration")
(test #t (equal? '(0 0) (xy (g 0 0))))  
(test #t (equal? '(0 1) (xy (g 0 1))))  
(test #t (equal? '(1 0) (xy (g 1 0))))  
(test #t (equal? '(0 2) (xy (g 0 2))))  
(test #t (equal? '(1 1) (xy (g 1 1))))  
(test #t (equal? '(2 0) (xy (g 2 0))))  
(do ((x 0 (+ x 1))
     (y 0 (+ y 1)))
    ((= (+ x y) 10) '())
  (test #t (equal? (list x y) (xy (g x y)))))
(test-end "xy from enumeration")





(test-exit)


;; ;; triangle-num  return 1+2+3+..+n
;; (define (triangle-num n)
;;   (/ (* (+ n 1)
;; 	n)
;;      2))

;; ;; g  Godel number of the pair (x,y) of integers
;; (define (g x y)
;;   (let ((d (+ x y)))
;;     (+ (triangle-num d)
;;        x)))

;; ;; diag-num  given Godel number, find the number of the diagonal
;; (define (diag-num g)
;;   (inexact->exact (floor (/
;; 			  (- (sqrt (+ (* 8 g) 1))
;; 			     1)
;; 			  2))))

;; ;; xy  given the godel number, return (x y) 
;; (define (xy g)
;;   (let* ((d (diag-num g))
;; 	 (t (triangle-num d)))
;;     (list (- g t)
;; 	  (- d (- g t)))))

;; ;; g3 number triples
;; (define (g3 x0 x1 x2)
;;   (g x0 (g x1 x2)))

;; ;; g4 number quads
;; (define (g4 x0 x1 x2 x3)
;;   (g x0 (g3 x1 x2 x3)))

;; ;; g-omega number any tuples
;; (define (g-omega . args)
;;   (cond ((null? args) (display "ERROR: g-omega requires an input"))
;; 	((= 1 (length args)) (car args))
;; 	((= 2 (length args)) (g (car args) (cadr args)))
;; 	(else 
;; 	 (g (car args) (apply g-omega (cdr args))))))

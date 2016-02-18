;; triangle-num  return 1+2+3+..+n
(define (triangle-num n)
  (/ (* (+ n 1)
	n)
     2))

;; g  Godel number of the pair (x,y) of integers
(define (g x y)
  (let ((d (+ x y)))
    (+ (triangle-num d)
       x)))

;; diag-num  given Godel number, find the number of the diagonal
(define (diag-num g)
  (inexact->exact (floor (/
			  (- (sqrt (+ (* 8 g) 1))
			     1)
			  2))))

;; xy  given the godel number, return (x y) 
(define (xy g)
  (let* ((d (diag-num g))
	 (t (triangle-num d)))
    (list (- g t)
	  (- d (- g t)))))

;; g3 number triples
(define (g3 x0 x1 x2)
  (g x0 (g x1 x2)))

;; g4 number quads
(define (g4 x0 x1 x2 x3)
  (g x0 (g3 x1 x2 x3)))

;; g-omega number any tuples
(define (g-omega . args)
  (cond ((null? args) (display "ERROR: g-omega requires an input"))
	((= 1 (length args)) (car args))
	((= 2 (length args)) (g (car args) (cadr args)))
	(else 
	 (g (car args) (apply g-omega (cdr args))))))

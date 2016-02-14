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
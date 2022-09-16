;; mu.scm Examples of mu-minimization
;; Jim Hefferon 2016 Public domain

;; mu-2 unbounded minimization of the two-input fcn g
(define (mu-2 g x)
  (mu-2-helper g x 0))
(define (mu-2-helper g x y)
  (if (= 0 (g x y))
      (g x y)
      (mu-2-helper g x (+ y 1))))

(define (g x y)
  (ceiling (- (/ (+ x 1) (+ y 1)) 
	      1)))

;; mu unbounded minimization of the fcn g
(define (mu g . xs)
  (apply mu-helper (cons g (append xs '(0)))))
(define (mu-helper g . xs-and-y)
  (let ((y (car (reverse xs-and-y)))
	(xs (reverse (cdr (reverse xs-and-y))))
	(value (apply g xs-and-y)))
    (if (= 0 value)
	value
	(apply mu-helper g (append xs (+ y 1))))))


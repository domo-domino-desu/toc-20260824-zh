;; Decide if the input represents a multiple of three
(define (multiple-of-three-fsm input-string)
  (let ((state 0))
    (if (= 0 (multiple-of-three-fsm-helper state input-string))
	(display "accepted")
	(display "rejected"))
    (display (newline))))

;; tail-recursive helper fcn
(define (multiple-of-three-fsm-helper state tau)
  (let ((tau-list (string->list tau)))
    (if (null? tau-list)
	state
	(multiple-of-three-fsm-helper (delta state (car tau-list))
				      (list->string (cdr tau-list))))))

(define (delta state ch)
  (cond
   ((= state 0)
    (cond
     ((memv ch '(#\0 #\3 #\6 #\9)) 0)
     ((memv ch '(#\1 #\4 #\7)) 1)
     (else 2)))
   ((= state 1)
    (cond
     ((memv ch '(#\0 #\3 #\6 #\9)) 1)
     ((memv ch '(#\1 #\4 #\7)) 2)
     (else 0)))
   (else
    (cond
     ((memv ch '(#\0 #\3 #\6 #\9)) 2)
     ((memv ch '(#\1 #\4 #\7)) 0)
     (else 1)))))
    

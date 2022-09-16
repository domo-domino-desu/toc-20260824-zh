;; Generate all bit strings of length n

;; Display all bitstrings of the given length
(define (bitstrings n)
  (bitstrings-helper n '()))

(define (bitstrings-helper n lst)
  (if (= n 0)
      lst
      ;; (begin
      ;; 	(display (list->string (reverse lst)))
      ;; 	(newline))
      (begin
	(bitstrings-helper (- n 1) (cons #\0 lst))
	(bitstrings-helper (- n 1) (cons #\1 lst)))
      ))

;; Constant of all characters in the alphabet
(define ALLCHARS '(#\a #\b #\space #\( #\)))

;; Display a list of all strings of characters from ALLCHARS
(define (allstrings n lst)
  (define (do-one ch)
    (allstrings (- n 1) (cons ch lst)))

  (if (= n 0)
      (begin
	(display (list->string (reverse lst)))
	(display #\,))
      (begin
	(map do-one ALLCHARS)
	'())))  ; return empty list

(define (all-strings n lst)
  (define (do-one ch)
    (allstrings (- n 1) (cons ch lst)))

  (if (= n 0)
      (list->string (reverse lst))
      (begin
	(map do-one ALLCHARS)
	'())))  ; return empty list

;; Name of the output file
(define OUTFN "allstringstest.scm")

;; Allow us to run programs from the command line
(require-extension shell) 

;; Write the input string to a file, run compiler on that, and test 
;; the return code from the compiler. 
;; (define (run-one-string s)
;;   (let ((p (open-output-file OUTFN)))
;;     (display s p)
;;     (close-output-port p))
;;   (let ((rc (run* ("cat" "<" ,OUTFN ">" "test.out"))))
;;     (display (string-append "return code is " (number->string rc)))))


(define (run-one-string s)
  (let ((p (open-output-file OUTFN)))
    (display s p)
    (close-output-port p))
  (let ((rc (run* ("csc" ,OUTFN))))
    (if (= rc 0)
	#t
	#f)))

(define (run-strings-helper cnt string-list)
  (if (null? string-list)
      cnt
      (begin
	(if (run-one-string (car string-list))
	    (run-strings-helper (+ 1 cnt) (cdr string-list))
	    (run-strings-helper cnt (cdr string-list))))))
(define (run-strings string-list)
  (display (run-strings-helper 0 string-list)))

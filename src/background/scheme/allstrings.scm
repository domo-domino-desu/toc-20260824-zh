;; Generate all bit strings of length n

;; Display all bitstrings of the given length
(define (bitstrings n lst)
  (if (= n 0)
      (begin
	(display (list->string lst))
	(newline))
      (begin
	(bitstrings (- n 1) (cons #\0 lst))
	(bitstrings (- n 1) (cons #\1 lst)))
      ))

;; Constant of all characters in the alphabet
(define ALLCHARS '(#\a #\b #\space #\( #\)))

;; Display a list of all strings of characters from ALLCHARS
(define (allstrings n lst)
  (define (do-one ch)
    (allstrings (- n 1) (cons ch lst)))

  (if (= n 0)
      (begin
	(display (list->string lst))
	(display #\,))
      (begin
	(map do-one ALLCHARS)
	'())))

(define OUTFN "allstringstest.scm")

(require-extension shell)   ; run programs from command line 
(define (run-one-string s)
  (let ((p (open-output-file OUTFN)))
    (display s p)
    (close-output-port p))
  (let ((rc (run* ("cat" "<" ,OUTFN ">" "test.out"))))
    (display (string-append "return code is " (number->string rc)))))

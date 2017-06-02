;; Conway's Game of Life
;;
;; Adapted from https://rosettacode.org/wiki/Conway%27s_Game_of_Life#Scheme
;;  downloaded 2017-May-31 JH
;; "An R6RS Scheme implementation of Conway's Game of Life --- assumes
;; all cells outside the defined grid are dead"

;; If n is outside bounds of list, return 0 else value at n
(define (nth n lst)
  (cond ((> n (length lst)) 0)
        ((< n 1) 0)
        ((= n 1) (car lst))
        (else (nth (- n 1) (cdr lst)))))
 
;; Return the next state of the supplied universe
(define (next-universe universe)
  ;value at (x, y)
  (define (cell x y)
    (if (list? (nth y universe))
        (nth x (nth y universe))
        0))
  ;sum of the values of the cells surrounding (x, y)
  (define (neighbor-sum x y)
    (+ (cell (- x 1) (- y 1))
       (cell (- x 1) y)
       (cell (- x 1) (+ y 1))
       (cell x (- y 1))
       (cell x (+ y 1))
       (cell (+ x 1) (- y 1))
       (cell (+ x 1) y)
       (cell (+ x 1) (+ y 1))))
  ;next state of the cell at (x, y)
  (define (next-cell x y)
    (let ((cur (cell x y))
          (ns (neighbor-sum x y)))
      (cond ((and (= cur 1)
                  (or (< ns 2) (> ns 3)))
             0)
            ((and (= cur 0) (= ns 3))
             1)
            (else cur))))
  ;next state of row n
  (define (row n out)
    (let ((w (length (car universe))))
      (if (= (length out) w)
          out
          (row n
               (cons (next-cell (- w (length out)) n)
                     out)))))
  ;a range of ints from bot to top
  (define (int-range bot top)
    (if (> bot top) '()
        (cons bot (int-range (+ bot 1) top))))
  (map (lambda (n)
         (row n '()))
       (int-range 1 (length universe))))
 
;; Represent the universe as a string
(define (universe->string universe)
  (define (prettify row)
    (apply string-append
           (map (lambda (b)
                  (if (= b 1) "*" "."))
                row)))
  (if (null? universe)
      ""
      (string-append (prettify (car universe))
                     "\n"
                     (universe->string (cdr universe)))))
 
;; Starting with the seed, display reps-many states of the universe
(define (conway seed reps)
  (when (> reps 0)
    (display (universe->string seed))
    (newline)
    (conway (next-universe seed) (- reps 1))))
 
;; --- Example Universes ---
;;  Uncomment to test
 
;blinker in a 3x3 universe
;; (conway '((0 1 0)
;;           (0 1 0)
;;           (0 1 0)) 5)
 
;glider in an 8x8 universe
;; (conway '((0 0 1 0 0 0 0 0)
;;           (0 0 0 1 0 0 0 0)
;;           (0 1 1 1 0 0 0 0)
;;           (0 0 0 0 0 0 0 0)
;;           (0 0 0 0 0 0 0 0)
;;           (0 0 0 0 0 0 0 0)
;;           (0 0 0 0 0 0 0 0)
;;           (0 0 0 0 0 0 0 0)) 30)


;; ---- I/O with output files ----
(define ALIVE #\*)
(define DEAD #\.)

;; io-to-internal
;; Convert a character to what the universe code expects, 0 for dead and 1 for
;;   alive
(define (io-to-internal alive-or-dead)
  (if (eq? ALIVE alive-or-dead)
      1
      0))

;; read-universe
;;   Read DEAD and ALIVE characters from a file, return a universe
(define (read-universe fn)
  (let* ((in (open-input-file fn))
	 (input-file-lines (read-lines in)))
    (read-universe-helper input-file-lines)))

;; read-universe-helper
;; Convert a list of strings, with DEAD and ALIVE chars, to a list of
;; lists of 0's and 1's
;;   s  list of strings, such as ("..*." ".**.")
(define (read-universe-helper s)
  (if (null? s)
      '()
      (cons (map io-to-internal (string->list (car s)))
	    (read-universe-helper (cdr s)))))

;; print-universes
;; Output the sequence of universes to a sequence of files
;;   fn  Input file name.  Format is a sequence of same-length lines, each
;;          composed of `.' for "dead" and `*' for "alive"
;;  output-fn-prefix  String.  The output files will have form -string-xx.life
;;  reps  Natural number.  Number of outputs in the sequence.
(define (print-universes fn output-fn-prefix reps)
  (define (make-output-filename prefix dex)
    (if (< dex 10)            ; I'll never need more than two digits
	(sprintf "out/~A0~S.life" prefix dex)
	(sprintf "out/~A~S.life" prefix dex)))

  (define (print-universes-helper universe output-fn-prefix rep)
    (when (>= rep 0)	  
	  (let ((out (open-output-file
		      (make-output-filename output-fn-prefix (- reps rep)))))
	    (write-string (universe->string universe) #f out)
	    (close-output-port out)
	    (print-universes-helper (next-universe universe)
				    output-fn-prefix
				    (- rep 1)))))

  (let ((universe (read-universe fn)))
    (print-universes-helper universe output-fn-prefix reps)))

;; ====== Chicken Scheme lets you call scripts from the cli ===
;;   Cli args are packed into a list
;;   So call this as:
;;     $ csi -ss life.scm 'blinkerjh.life' 'bjh' 10
(define (main args)
  ; (pretty-print args)
  (print-universes (car args)
		   (cadr args)
		   (string->number (caddr args))))
  

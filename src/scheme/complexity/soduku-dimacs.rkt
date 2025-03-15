#lang racket
;;;; soduku-dimacs.rkt
;;;;  Write a DIMACS file for the standard 9x9 Soduku puzzle
(require racket/date)
(date-display-format 'iso-8601)

;; Constant lists
(define ONETONINE '(1 2 3 4 5 6 7 8 9))
(define ONETOTHREE '(1 2 3))  ;; for boxes
(define FOURTOSIX '(4 5 6))
(define SEVENTONINE '(7 8 9))
(define BOX-INDICES (list ONETOTHREE FOURTOSIX SEVENTONINE))

;; Each clause is a list of triples (row number, column number, variable value).  Each
;; triple is a predicate: #t if the entry in that row and column has that value, and #f
;; otherwise.  Thus, each of the three values are between 1 and 9 inclusive.

(define (make-board)
  (for/vector ([row ONETONINE])
    (make-vector 9 0)))

(define BOARD (make-board))

(define (set-board-entry! board triple)
  (let ([row (vector-ref board (- (first triple) 1))])
    (vector-set! row (- (second triple) 1) (third triple))))

(provide make-board
         BOARD
         set-board-entry!)

;; triple->varnum  Find the variable number associated with the row, column, and value
;;  row-number column-number  integers, counting starts at 1
;;  variable-value  integer  value of the entry.  If negative, then
;;   the predicate is to be negated. 
;;   If variable-value < 0 then use the absolute value for the basic varnum,
;;   but return the negative of the polynomial (saying that the predicate is negated).
(define (triple->varnum row-number column-number variable-value)
  (let ([a-value (+ (* 81 (- (abs variable-value) 1))
                    (* 9 (- row-number 1))
                    (- column-number 1)
                    1)])   ;; add 1 because DIMACS uses 0 to terminate clauses
        (if (negative? variable-value)
            (* -1 a-value)
            a-value)))
        
;; varnum->triple  Return the associated row, column, and value
(define (varnum->triple v)
  (let* ([offset (- (abs v) 1)]
         [variable-value (quotient offset 81)]
         [vv-removed (- offset (* 81 variable-value))]
         [row-number (quotient vv-removed 9)]
         [column-number (remainder vv-removed 9)])
    (if (negative? v)
        (list (+ 1 row-number) (+ 1 column-number) (* -1 (+ 1 variable-value)))
        (list (+ 1 row-number) (+ 1 column-number) (+ 1 variable-value)))))

(provide triple->varnum
         varnum->triple)

;; produce-clauses  Given a list of lists of triples, produce the matching set of
;;   strings for the DIMACS file
(define (produce-clauses list-of-lists)
  (define (one-line-of-one variable-in-clause) ; produce line from list of one num
    (apply format "~a 0\n" variable-in-clause))
  (define (one-line-of-two variables-in-clause) ; a line from list of two nums
    (apply format "~a ~a 0\n" variables-in-clause))
  (define (one-line-of-nine variables-in-clause) ; a line from list of nine nums
    (apply format "~a ~a ~a ~a ~a ~a ~a ~a ~a 0\n" variables-in-clause))

  (for/list ([clause-list list-of-lists])
    (display clause-list)(newline)
    (cond [(= 9 (length clause-list))
           (one-line-of-nine (map
                              (lambda (x) (triple->varnum (first x)
                                                          (second x)
                                                          (third x)))
                              clause-list))]
          [(= 1 (length clause-list))
           (one-line-of-one (map
                             (lambda (x) (triple->varnum (first x)
                                                         (second x)
                                                         (third x)))
                             clause-list))]
          [(= 2 (length clause-list))
           (one-line-of-two (map
                             (lambda (x) (triple->varnum (first x)
                                                         (second x)
                                                         (third x)))
                             clause-list))])))


;; entry-restrictions    Return list of list of triples, each list of triples meaning
;;    that each entry cannot be two separate values 1-9.
(define (entry-restrictions)
  (for*/list  ([row-number ONETONINE]
               [column-number ONETONINE]
               [variable-value1 ONETONINE]
               [variable-value2 ONETONINE]
               #:unless (>= variable-value1 variable-value2))
    (list (list row-number column-number (* -1 variable-value1))
          (list row-number column-number (* -1 variable-value2)))))

;; row-restrictions  Return list of list of triples, each list of triples meaning
;;    that each row has to have each value 1-9.
(define (row-restrictions)
  (define (one-row-one-value row-number variable-value)
    (for/list ([column-number ONETONINE])
      (list row-number column-number variable-value)))

  (for*/fold ([accumulator '()]
              #:result (reverse accumulator))
             ([variable-value ONETONINE]
              [row-number ONETONINE])
    (cons (one-row-one-value row-number variable-value) accumulator)))

;; column-restrictions  Return list of list of triples, each list of triples meaning
;;    that each row has to have each value 1-9.
(define (column-restrictions)
  (define (one-column-one-value column-number variable-value)
    (for/list ([row-number ONETONINE])
      (list row-number column-number variable-value)))
  
  (for*/fold ([accumulator '()]
              #:result (reverse accumulator))
             ([variable-value ONETONINE]
              [column-number ONETONINE])
    (cons (one-column-one-value column-number variable-value) accumulator)))

;; box-restrictions  Return list of list of triples, each list of triples meaning
;;    that each 3x3 box has to have each value 1-9.
(define (box-restrictions)
  (define (one-box-one-value box-row-list box-column-list variable-value)
    (for*/list ([row-number box-row-list]
                [column-number box-column-list])
      (list row-number column-number variable-value)))
  
  (for*/fold ([accumulator '()]
              #:result (reverse accumulator))
             ([variable-value ONETONINE]
              [box-row-list BOX-INDICES]
              [box-column-list BOX-INDICES])
    (cons (one-box-one-value box-row-list box-column-list variable-value)
          accumulator)))


;; ======= write to file =======
;; FILENAME  Name of the output file
(define FILENAME "soduku.cnf")

;; CLAUSES  The list of clauses.

;; INITIAL-CLAUSES  The given layout of the board.  Each row is a list with a
;; triple: row number, column number, integer.
;(define INITIAL-CLAUSES
;  (list (list '(1 3 9)) ; there is a 9 in position (1,3)
;        (list '(1 8 1))
;        (list '(1 9 5))
;        (list '(2 1 5))
;        (list '(2 4 4))
;        (list '(2 6 9))
;        (list '(2 7 7))
;        (list '(3 1 4))
;        (list '(3 2 7))
;        (list '(3 3 3))
;        (list '(3 4 5))
;        (list '(3 5 6))
;        (list '(3 6 1))
;        (list '(3 7 9))
;        (list '(4 4 7))
;        (list '(4 5 4))
;        (list '(4 8 9))
;        (list '(4 9 6))
;        (list '(5 8 8))
;        (list '(6 3 4))
;        (list '(6 4 8))
;        (list '(6 5 3))
;        (list '(6 7 1))
;        (list '(6 8 5))
;        (list '(7 1 1))
;        (list '(7 2 3))
;        (list '(7 3 5))
;        (list '(7 4 9))
;        (list '(7 9 2))
;        (list '(8 3 6))
;        (list '(8 4 2))
;        (list '(8 5 5))
;        (list '(8 6 7))
;        (list '(8 8 3))
;        (list '(9 1 7))
;        (list '(9 2 2))
;        (list '(9 5 1))
;        (list '(9 9 9))
;           ))

; Exercise 
(define INITIAL-CLAUSES
  (list (list '(1 2 3)) ; there is a 3 in position (1,2)
        (list '(1 3 4))
        (list '(1 4 5))
        (list '(1 6 6))
        (list '(1 7 9))
        (list '(2 3 5))
        (list '(2 4 4))
        (list '(3 5 8))
        (list '(3 8 1))
        (list '(4 4 8))
        (list '(4 5 2))
        (list '(4 6 3))
        (list '(4 9 7))
        (list '(5 1 1))
        (list '(5 3 8))
        (list '(5 4 7))
        (list '(5 7 3))
        (list '(6 6 9))
        (list '(7 2 8))
        (list '(7 3 7))
        (list '(8 6 8))
        (list '(8 8 7))
        (list '(8 9 2))
        (list '(9 1 4))
        (list '(9 3 9))
           ))

;; CLAUSES  The list of all clauses, including those auto generated.
(define CLAUSES
  (append INITIAL-CLAUSES (entry-restrictions)
          (row-restrictions) (column-restrictions) (box-restrictions)))

(define FILE-PREAMBLE
  (list (format "c ~a\n" FILENAME)
        "c DIMACS format file for SAT solver\n"
        (format "c ~a Jim Hefferon, hefferon.net.  Public Domain.\n"
                (date->string (current-date)))
        (format "p cnf ~a ~a\n" (* 9 9 9) (length CLAUSES))))
  
(define FILE-LINES
  (append
   FILE-PREAMBLE
   (produce-clauses CLAUSES)))

;; dump-to-file  Drop the clauses to the file
(define (dump-to-file)
  (define (dump-lines outfile)
    (for ([ln FILE-LINES])
      (display ln outfile)))
  
  (call-with-output-file* FILENAME dump-lines #:mode 'text #:exists 'replace))


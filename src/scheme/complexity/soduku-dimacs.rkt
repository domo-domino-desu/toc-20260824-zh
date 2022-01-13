#lang racket
;;;; soduku-dimacs.rkt
;;;;  Write a DIMACS file for the standard 9x9 Soduku puzzle

;; Each clause is a list of triples (row number, column number, variable value).  Each
;; triple is a predicate: #t if the entry in that row and column has that value, and #f
;; otherwise.  Thus, each of the three values are between 1 and 9 inclusive.

;; triple->varnum  Find the variable number associated with the row, column, and value
(define (triple->varnum row-number column-number variable-value)
  (+ (* 81 variable-value)
     (* 9 row-number)
     column-number
     1))   ;; add 1 because DIMACS doesn't allow variable 0 (uses 0 to terminate clauses)

;; varnum->triple  From the variable number, return the associated row, column, and value
(define (varnum->triple v)
  (let* ([offset (- v 1)]
         [variable-value (quotient offset 81)]
         [vv-removed (- offset (* 81 variable-value))]
         [row-number (quotient vv-removed 9)]
         [column-number (remainder vv-removed 9)])
    (list row-number column-number variable-value)))


;; produce-clauses  Given a list of lists of triples, produce the matching set of strings
;;   for the DIMACS file
(define (produce-clauses list-of-lists)
  (define (one-line variables-in-clause) ; produce one line from a list of nine numbers
    (apply format "~a ~a ~a ~a ~a ~a ~a ~a ~a 0\n" variables-in-clause))

  (for/list ([clause-list list-of-lists])
    (one-line (map (lambda (x) (triple->varnum (first x) (second x) (third x)))
                   clause-list))))


(define ONETONINE '(1 2 3 4 5 6 7 8 9))
(define ONETOTHREE '(1 2 3))
(define FOURTOSIX '(4 5 6))
(define SEVENTONINE '(7 8 9))
(define BOX-INDICES (list ONETOTHREE FOURTOSIX SEVENTONINE))


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
    (cons (one-box-one-value box-row-list box-column-list variable-value) accumulator)))


;; write to file

;; CLAUSES  The list of clauses.
(define CLAUSES
  (append (row-restrictions) (column-restrictions) (box-restrictions)))

;; dump-to-file  Drop the clauses to the file
(define FILENAME "soduku.cnf")

(define (dump-to-file)
  (define (dump-lines outfile)
    (for ([ln (produce-clauses CLAUSES)])
      (display ln outfile)))
  
  (call-with-output-file* FILENAME dump-lines #:mode 'text #:exists 'replace))


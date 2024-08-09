#lang racket
;; three-by-three.rkt
;;   Find how many three-by-three grids survive for a specified number of generations
;; 2024-Aug-08 Jim Hefferon For Theory of Computation book CC-BY-SA
(require "life.rkt")

; Input a natural number less than 2^9, output a grid with associated 0's and 1's
; For instance, n=28 is 11100 in binary so this returns the vector of vectors [[0 0 0] [0 1 1] [1 0 0]]
(define (number->three-by-three-grid n)
  (if (>= n (expt 2 9))
      (error "input too large; must be less than 2^9")
      (let* ([bitstr (number->string n 2)]
             [pad-bitstr (make-string (- 9 (string-length bitstr)) #\0)]
             [length-9-bitstr (string-append pad-bitstr bitstr)]
             [input-style-bitstr (string-replace (string-replace length-9-bitstr "0" ".") "1" "*")]
             [list-of-lines (list (substring input-style-bitstr 0 3)
                                  (substring input-style-bitstr 3 6)
                                  (substring input-style-bitstr 6 9))])
        (parse-lines-to-grid list-of-lines))))

; Test if a grid is empty
(define (grid-empty? g)
  (let ([size (grid-size g)])
    (grid-equal? g (grid-create (first size) (second size)))))

; Count the number of 3x3 grids that are alive after the specified number of generations
(define (number-alive generations)
  (let ([counter 0])
    (for ([n (in-range (expt 2 9))])
      (displayln (~a "n=" n "\ngrid=" (grid->string (number->three-by-three-grid n))))
      (let* ([initial-u (universe (number->three-by-three-grid n) (list 0 0))]
             [list-of-universes (run initial-u generations)]
             [ending-grid (universe-grid (last list-of-universes))])
        (when (not (grid-empty? ending-grid))
          (set! counter (add1 counter))
          (displayln " not blank"))))
    (displayln (~a "Number of 3x3 boards surviving is " counter))))

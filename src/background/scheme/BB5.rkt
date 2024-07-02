#lang racket

(define (g n)
  (let ([i (modulo n 3)]) 
    (cond
      [(= i 0) (/ (+ (* n 5) 18) 3)]
      [(= i 1) (/ (+ (* n 5) 22) 3)]
      [else -1])))

; Show values computed while finding Busy Beaver 5.
;  r  values; usually initially use r=0
;  N  cap on number of values to compute; use N=10 for instance 
(define (BB5 r N)
  (let ([val (g r)])
    (if (> val 0) 
        (begin
          (writeln (number->string val))
          (BB5 val (- N 1)))
        (writeln "done"))))
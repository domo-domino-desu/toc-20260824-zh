#lang racket
(define (show-numbers)
  (for ([i '(1 2 3)])
    (display i)))

(define (wait-until-yes)
  (printf "Please enter 'yes'\n")
  (do ()      ; initialization variables (here, none)
    ((string=? (read-line) "yes") (printf "Thanks\n"))  ; stop condition 
    (printf "Enter exactly the string 'yes'\n")))  ; body of do loop
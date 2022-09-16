#lang racket
;; Euclid's gcd recurrence
;; Named gcd-euclid so it won't conflict with Racket's built in gcd
(define (gcd-euclid n m)
  (if (= m 0)
      n
      (gcd-euclid m (remainder n m))))

(define (gcd-euclid-verbose n m)
  (if (= m 0)
      (begin
        (printf "  return ~a\n" n)
        n)
      (begin
        (printf "  call (gcd-euclid ~a ~a)\n" m (remainder n m))
        (gcd-euclid-verbose m (remainder n m)))))

(provide gcd-euclid)
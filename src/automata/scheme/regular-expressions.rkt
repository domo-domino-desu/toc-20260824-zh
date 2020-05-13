#lang racket/base
(require rackunit)

;; Regular expression homework
(define (test-strings-against-regexes str-list regex-list)
  (for ([s str-list])
    (printf " ~a" s)
    (for ([r regex-list])
      (printf " ~a" (regexp-match? r s)))
      (newline)))

(define s '("" "a" "b" "aa" "ab" "ba" "bb" "aaa" "aab" "aba" "abb" "baa" "bab" "bba" "bbb"))
(define r '(#rx"^a*b$" #rx"^a*$" #rx"^z$" #rx"^$" #rx"^b(a|b)a$" #rx"^(a|b)(|a)a$"))
(test-strings-against-regexes s r)
#lang racket/base
(require rackunit)

;; Regular expression homework
(define (test-strings-against-regexes str-list regex-list)
  (for ([s str-list])
    (printf " ~a" s)
    (for ([r regex-list])
      (printf " ~a" (regexp-match? r s)))
      (newline)))

;; Every a is immediately preceeded and immediately followed by a b
(define r #rx"^((ba)*bb*)*$")
(module+ test
  (check-true (regexp-match? r "babbabbb"))
  (check-true (regexp-match? r "babab"))
  (check-true (regexp-match? r "bbbbbbabab"))
  (check-true (regexp-match? r "bbbabbabbb"))
  (check-true (regexp-match? r ""))
  (check-false (regexp-match? r "baab"))
  (check-false (regexp-match? r "ab"))
  (check-false (regexp-match? r "a"))
  )

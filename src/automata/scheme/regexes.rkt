#lang racket

;; Check that the testing is working as I expect.
(define abc #rx"a.c")

(module+ test
  (require rackunit)
  (check-not-false (regexp-match? abc "abc"))
  (check-false (regexp-match? abc "bbc"))
  )


;; Use square brackets to make digits list
(define digits-sq #rx"^[0123456789]$")
(module+ test
  (check-true (regexp-match? digits-sq "3"))
  (check-true (regexp-match? digits-sq "0"))
  (check-true (regexp-match? digits-sq "9"))
  (check-false (regexp-match? digits-sq "b"))
  (check-false (regexp-match? digits-sq "01"))
  )

(define digits-hyphen #rx"^[0-9]$")
(module+ test
  (check-true (regexp-match? digits-hyphen "3"))
  (check-true (regexp-match? digits-hyphen "0"))
  (check-true (regexp-match? digits-hyphen "9"))
  (check-false (regexp-match? digits-hyphen "b"))
  (check-false (regexp-match? digits-hyphen "01"))
  )

(define nondigits-sq #rx"^[^0123456789]$")
(module+ test
  (check-false (regexp-match? nondigits-sq "3"))
  (check-false (regexp-match? nondigits-sq "0"))
  (check-false (regexp-match? nondigits-sq "9"))
  (check-true (regexp-match? nondigits-sq "b"))
  (check-false (regexp-match? nondigits-sq "01"))
  )


;; Square brackets to make a ASCII letter list
(define azAZ #rx"^[A-Za-z]$")
(module+ test
  (check-true (regexp-match? azAZ "d"))
  (check-true (regexp-match? azAZ "a"))
  (check-true (regexp-match? azAZ "z"))
  (check-false (regexp-match? azAZ "0"))
  (check-false (regexp-match? azAZ "ab"))
  )

(define nonazAZ #rx"^[^A-Za-z]$")
(module+ test
  (check-false (regexp-match? nonazAZ "d"))
  (check-false (regexp-match? nonazAZ "a"))
  (check-false (regexp-match? nonazAZ "z"))
  (check-true (regexp-match? nonazAZ "0"))
  (check-false (regexp-match? nonazAZ "ab"))
  )



;; Lists with \d \D, etc
(define slash-d #px"^\\d$")
(module+ test
  (check-true (regexp-match? slash-d "5"))
  (check-true (regexp-match? slash-d "0"))
  (check-true (regexp-match? slash-d "9"))
  (check-false (regexp-match? slash-d "a"))
  (check-false (regexp-match? slash-d "02"))
  )

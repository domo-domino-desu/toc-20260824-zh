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


;; Canadian postal codes
(define canadian #px"^[a-zA-Z]\\d[a-zA-Z] \\d[a-zA-Z]\\d$")
(module+ test
  (check-true (regexp-match? canadian "A1B 2C3"))
  (check-true (regexp-match? canadian "a1b 2c3"))
  (check-true (regexp-match? canadian "f9f 9f9"))
  (check-false (regexp-match? canadian "AAA AAA"))
  (check-false (regexp-match? canadian "12345"))
  )


;; US ZIP postal codes
(define zip #px"^\\d\\d\\d\\d\\d$")
(module+ test
  (check-true (regexp-match? zip "12345"))
  (check-true (regexp-match? zip "11111"))
  (check-false (regexp-match? zip "1234"))
  (check-false (regexp-match? zip "1234567"))
  (check-false (regexp-match? zip "abcde"))
  )


;; Twelve hour time format
(define twelve #px"^(|0|1)\\d:\\d\\d\\s(am|pm)$")
(module+ test
  (check-true (regexp-match? twelve "8:05 am"))
  (check-true (regexp-match? twelve "10:15 pm"))
  (check-true (regexp-match? twelve "13:00 am"))
  (check-true (regexp-match? twelve "9:61 pm"))
  (check-false (regexp-match? twelve "8:05"))
  (check-false (regexp-match? twelve "noon"))
  (check-false (regexp-match? twelve "8 am"))
  (check-false (regexp-match? twelve "23:31"))
  )



;; Fixed/long twelve hour time format
(define twelve-long #px"^(01|02|03|04|05|06|07|08|09|1|2|3|4|5|6|7|8|9|10|11|12):(01|02|03|04|05|06|07|08|09|10|11|12|13|14|15|16|17|18|19|20|21|22|23|24|25|26|27|28|29|30|31|32|33|34|35|36\37|38|39|40|41|42|43|44|45|46|47|48|49|50|51|52|53|54|55|56|57|58|59|60)\\s(am|pm)$")
(module+ test
  (check-true (regexp-match? twelve-long "8:05 am"))
  (check-true (regexp-match? twelve-long "10:15 pm"))
  (check-false (regexp-match? twelve-long "13:00 am"))
  (check-false (regexp-match? twelve-long "9:61 pm"))
  (check-false (regexp-match? twelve-long "8:05"))
  (check-false (regexp-match? twelve-long "noon"))
  (check-false (regexp-match? twelve-long "8 am"))
  (check-false (regexp-match? twelve-long "23:31"))
  )


;; US ZIP postal codes, quantifiers
(define zip-quantifiers #px"^\\d{5}$")
(module+ test
  (check-true (regexp-match? zip-quantifiers "12345"))
  (check-true (regexp-match? zip-quantifiers "11111"))
  (check-false (regexp-match? zip-quantifiers "1234"))
  (check-false (regexp-match? zip-quantifiers "1234567"))
  (check-false (regexp-match? zip-quantifiers "abcde"))
  )


;; digits, quantifiers
(define digits-two-to-five #px"^\\d{2,5}$")
(module+ test
  (check-true (regexp-match? digits-two-to-five "12345"))
  (check-true (regexp-match? digits-two-to-five "1234"))
  (check-true (regexp-match? digits-two-to-five "123"))
  (check-true (regexp-match? digits-two-to-five "12"))
  (check-false (regexp-match? digits-two-to-five "1"))
  (check-false (regexp-match? digits-two-to-five "123456"))
  (check-false (regexp-match? digits-two-to-five "abcde"))
  )


;; digits, at least two
(define digits-at-least-two #px"^\\d{2,}$")
(module+ test
  (check-true (regexp-match? digits-at-least-two "12345"))
  (check-true (regexp-match? digits-at-least-two "123"))
  (check-true (regexp-match? digits-at-least-two "12"))
  (check-false (regexp-match? digits-at-least-two "1"))
  (check-false (regexp-match? digits-at-least-two "12a"))
  )

;; digits, at least one
(define digits-at-least-one #px"^\\d+$")
(module+ test
  (check-true (regexp-match? digits-at-least-one "12345"))
  (check-true (regexp-match? digits-at-least-one "12"))
  (check-true (regexp-match? digits-at-least-one "1"))
  (check-false (regexp-match? digits-at-least-one ""))
  (check-false (regexp-match? digits-at-least-one "12a"))
  )

;; Hamlet
(define hamlet #px"^To be or not to be\?$")
(module+ test
  (check-true (regexp-match? hamlet "To be or not to be?"))
  (check-false (regexp-match? hamlet "To be or not to be."))
  (check-false (regexp-match? hamlet ""))
  )

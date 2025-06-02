#lang racket
;; regexes.rkt
;; Check the regexes given in the Regular Expressions in the wild topic.
;; 2020-Mar-23 JH PD

;; Difference between rx and px:
;;  The px matches Perl more closely.  In particular, it allows \d, \D-type
;; constructs.  Note also the "^ -- pattern -- $", which also tracks with the
;; theory regular expressions

;; Check that the testing is working as I expect.
(define abc #px"a.c")

(module+ test
  (require rackunit)
  (check-true (regexp-match? abc "abc"))
  (check-false (regexp-match? abc "bbc"))
  )

;; examples given as prototypes
(module+ test
  (check-true (regexp-match? #px"^[A-Z]{2}[0-9][A-Z]{2}$" "KE1AZ"))
  (check-false (regexp-match? #px"^[0-9]$" "KE1AZ"))
)
  
;; Use square brackets to make digits list
(define digits-sq #px"^[0123456789]$")
(module+ test
  (check-true (regexp-match? digits-sq "3"))
  (check-true (regexp-match? digits-sq "0"))
  (check-true (regexp-match? digits-sq "9"))
  (check-false (regexp-match? digits-sq "b"))
  (check-false (regexp-match? digits-sq "01"))
  )

(define digits-hyphen #px"^[0-9]$")
(module+ test
  (check-true (regexp-match? digits-hyphen "3"))
  (check-true (regexp-match? digits-hyphen "0"))
  (check-true (regexp-match? digits-hyphen "9"))
  (check-false (regexp-match? digits-hyphen "b"))
  (check-false (regexp-match? digits-hyphen "01"))
  )

(define nondigits-sq #px"^[^0123456789]$")
(module+ test
  (check-false (regexp-match? nondigits-sq "3"))
  (check-false (regexp-match? nondigits-sq "0"))
  (check-false (regexp-match? nondigits-sq "9"))
  (check-true (regexp-match? nondigits-sq "b"))
  (check-false (regexp-match? nondigits-sq "01"))
  (check-true (regexp-match? nondigits-sq (make-string 1 (integer->char 192)))) ; Outside ASCII sitll a match? Latin Capital A with grave
  )


;; Square brackets to make a ASCII letter list
(define azAZ #px"^[A-Za-z]$")
(module+ test
  (check-true (regexp-match? azAZ "d"))
  (check-true (regexp-match? azAZ "a"))
  (check-true (regexp-match? azAZ "z"))
  (check-false (regexp-match? azAZ "0"))
  (check-false (regexp-match? azAZ "ab"))
  )

(define nonazAZ #px"^[^A-Za-z]$")
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


;; ============= Quantifiers ==================
;; At most one
(define at-most-one #px"^(|a)$")
(module+ test
  (check-true (regexp-match? at-most-one ""))
  (check-true (regexp-match?  at-most-one "a"))
  (check-false (regexp-match?  at-most-one "b"))
  (check-false (regexp-match?  at-most-one "bab"))
  (check-false (regexp-match?  at-most-one "aa"))
  )


(define a-query #px"^a?$")
(module+ test
  (check-true (regexp-match? a-query ""))
  (check-true (regexp-match? a-query "a"))
  (check-false (regexp-match? a-query "b"))
  (check-false (regexp-match? a-query "bab"))
  (check-false (regexp-match? a-query "aa"))
  )


(define a-plus #px"^a+$")
(module+ test
  (check-true (regexp-match? a-plus "a"))
  (check-true (regexp-match? a-plus "aa"))
  (check-false (regexp-match? a-plus ""))
  (check-false (regexp-match? a-plus "b"))
  (check-false (regexp-match? a-plus "ab"))
  )


(define five-a #px"^a{5}$")
(module+ test
  (check-true (regexp-match? five-a "aaaaa"))
  (check-false (regexp-match? five-a "aaaa"))
  (check-false (regexp-match? five-a "bbbbb"))
  (check-false (regexp-match? five-a "bababababa"))
  (check-false (regexp-match? five-a ""))
  )


(define two-to-five-a #px"^a{2,5}$")
(module+ test
  (check-true (regexp-match? two-to-five-a "aaaaa"))
  (check-true (regexp-match? two-to-five-a "aa"))
  (check-false (regexp-match? two-to-five-a "a"))
  (check-false (regexp-match? two-to-five-a "babababa"))
  (check-false (regexp-match? two-to-five-a "aaaaaa"))
  )


(define at-least-two-a #px"^a{2,}$")
(module+ test
  (check-true (regexp-match? at-least-two-a "aa"))
  (check-true (regexp-match? at-least-two-a "aaaaaaaa"))
  (check-false (regexp-match? at-least-two-a "a"))
  (check-false (regexp-match? at-least-two-a "baaa"))
  (check-false (regexp-match? at-least-two-a ""))
  )


;; ==================== Cookbook ======================

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
(define hamlet #px"^To be or not to be\\?$")
(module+ test
  (check-true (regexp-match? hamlet "To be or not to be?"))
  (check-false (regexp-match? hamlet "To be or not to be."))
  (check-false (regexp-match? hamlet ""))
  )

;; =========== Cookbook of examples =============

;; US ZIP postal codes
(define zip #px"^\\d\\d\\d\\d\\d$")
(module+ test
  (check-true (regexp-match? zip "12345"))
  (check-true (regexp-match? zip "11111"))
  (check-false (regexp-match? zip "1234"))
  (check-false (regexp-match? zip "1234567"))
  (check-false (regexp-match? zip "abcde"))
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


;; NA phone numbers
(define na #px"^\\d{3}-\\d{3}-\\d{4}$")
(module+ test
  (check-true (regexp-match? na "123-456-7890"))
  (check-true (regexp-match? na "999-000-9999"))
  (check-false (regexp-match? na "123-456-789a"))
  (check-false (regexp-match? na "456-7890"))
  (check-false (regexp-match? na ""))
  )


;; integer, positive or negative
(define integer-re #px"^(-|\\+)?\\d+$")
(module+ test
  (check-true (regexp-match? integer-re "123"))
  (check-true (regexp-match? integer-re "+123"))
  (check-true (regexp-match? integer-re "-123"))
  (check-true (regexp-match? integer-re "0"))
  (check-true (regexp-match? integer-re "9"))
  (check-false (regexp-match? integer-re "1+23"))
  (check-false (regexp-match? integer-re "a"))
  (check-false (regexp-match? integer-re ""))
  )



;; hexadecimal
(define hex #px"^[a-fA-F0-9]+$")
(module+ test
  (check-true (regexp-match? hex "123"))
  (check-true (regexp-match? hex "12A"))
  (check-true (regexp-match? hex "A2"))
  (check-true (regexp-match? hex "0"))
  (check-true (regexp-match? hex "F"))
  (check-false (regexp-match? hex "12G"))
  (check-false (regexp-match? hex "p"))
  (check-false (regexp-match? hex ""))
  )


;; hexadecimal possibly with 0x
(define hex-prefix #px"^(0x)?[a-fA-F0-9]+$")
(module+ test
  (check-true (regexp-match? hex-prefix "123"))
  (check-true (regexp-match? hex-prefix "0x123"))
  (check-true (regexp-match? hex-prefix "A2"))
  (check-true (regexp-match? hex-prefix "0xe"))
  (check-true (regexp-match? hex-prefix "0xF"))
  (check-false (regexp-match? hex-prefix "12G"))
  (check-false (regexp-match? hex-prefix "0xp"))
  (check-false (regexp-match? hex-prefix ""))
  )

;; C identifier
(define c-identifier #px"^[a-zA-Z_]\\w*$")
(module+ test
  (check-true (regexp-match? c-identifier "i"))
  (check-true (regexp-match? c-identifier "n3"))
  (check-true (regexp-match? c-identifier "__lib_sine"))
  (check-true (regexp-match? c-identifier "ACamelCase"))
  (check-false (regexp-match? c-identifier "1Identifier"))
  (check-false (regexp-match? c-identifier ".23"))
  (check-false (regexp-match? c-identifier ""))
  )

;; username
(define username #px"^[\\w\\.]{3,12}$")
(module+ test
  (check-true (regexp-match? username "fred"))
  (check-true (regexp-match? username "jim"))
  (check-true (regexp-match? username "A1idiot"))
  (check-true (regexp-match? username "john.doe"))
  (check-false (regexp-match? username "1"))
  (check-false (regexp-match? username "CatLoverFromHell"))
  (check-false (regexp-match? username ""))
  )

;; password
(define password #px"^.{8,}$")
(module+ test
  (check-true (regexp-match? password "12345678"))
  (check-true (regexp-match? password "qwertyuiop"))
  (check-true (regexp-match? password "Gotta Feed Dog"))
  (check-false (regexp-match? password "x"))
  (check-false (regexp-match? password "123456"))
  (check-false (regexp-match? password ""))
  )

;; Reddit username
(define rusername #px"^[\\w-]{3,20}$")
(module+ test
  (check-true (regexp-match? rusername "JimH10"))
  (check-true (regexp-match? rusername "StJimmy"))
  (check-true (regexp-match? rusername "abc"))
  (check-false (regexp-match? rusername "john.doe"))
  (check-false (regexp-match? rusername "a"))
  (check-false (regexp-match? rusername "CatLoverFromHell789012345678901"))
  (check-false (regexp-match? rusername ""))
  )

;; email address sanity check
(define email #px"\\S+@\\S+")
(module+ test
  (check-true (regexp-match? email "jhefferon10@smcvt.edu"))
  (check-true (regexp-match? email "mike@example.com"))
  (check-true (regexp-match? email "postmaster@localhost"))
  (check-false (regexp-match? email "@"))
  (check-false (regexp-match? email "john.doe"))
  (check-false (regexp-match? email "@example.com"))
  (check-false (regexp-match? email ""))
  )

;; text in parens
(define text-in-parens #px"\\([^()]*\\)")
(module+ test
  (check-true (regexp-match? text-in-parens "(abc)"))
  (check-true (regexp-match? text-in-parens "ab(cd)ef"))
  (check-true (regexp-match? text-in-parens "ab(cd)ef(gh)(ij)kl"))
  (check-false (regexp-match? text-in-parens "abc"))
  (check-false (regexp-match? text-in-parens "ab(c"))
  (check-false (regexp-match? text-in-parens "ab)de"))
  (check-false (regexp-match? text-in-parens ""))
  )


;; url's  Adapted from https://mathiasbynens.be/demo/url-regex
(define url #px"^(https?|ftp)://([^\\s/?\\.#]+\\.?){1,4}(/[^\\s]*)?$")
(module+ test
  (check-true (regexp-match? url "http://foo.com/blah_blah"))
  (check-true (regexp-match? url "http://foo.com/blah_blah/"))
  (check-true (regexp-match? url "http://foo.com/blah_blah_(wikipedia)"))
  (check-true (regexp-match? url "http://foo.com/blah_blah_(wikipedia)_(again)"))
  (check-true (regexp-match? url "http://www.example.com/wpstyle/?p=364"))
  (check-true (regexp-match? url "https://www.example.com/foo/?bar=baz&inga=42&quux"))
  (check-true (regexp-match? url "http://✪df.ws/123"))
  (check-true (regexp-match? url "http://userid:password@example.com:8080"))
  (check-true (regexp-match? url "http://userid:password@example.com:8080/"))
  (check-true (regexp-match? url "http://userid@example.com"))
  (check-true (regexp-match? url "http://userid@example.com/"))
  (check-true (regexp-match? url "http://userid@example.com:8080"))
  (check-true (regexp-match? url "http://userid@example.com:8080/"))
  (check-true (regexp-match? url "http://userid:password@example.com"))
  (check-true (regexp-match? url "http://userid:password@example.com/"))
  (check-true (regexp-match? url "http://142.42.1.1/"))
  (check-true (regexp-match? url "http://142.42.1.1:8080/"))
  (check-true (regexp-match? url "http://➡.ws/䨹"))
  (check-true (regexp-match? url "http://⌘.ws"))
  (check-true (regexp-match? url "http://⌘.ws/"))
  (check-true (regexp-match? url "http://foo.com/blah_(wikipedia)#cite-1"))
  (check-true (regexp-match? url "http://foo.com/blah_(wikipedia)_blah#cite-1"))
  (check-true (regexp-match? url "http://foo.com/unicode_(✪)_in_parens"))
  (check-true (regexp-match? url "http://foo.com/(something)?after=parens"))
  (check-true (regexp-match? url "http://☺.damowmow.com/"))
  (check-true (regexp-match? url "http://code.google.com/events/#&product=browser"))
  (check-true (regexp-match? url "http://j.mp"))
  (check-true (regexp-match? url "ftp://foo.bar/baz"))
  (check-true (regexp-match? url "http://foo.bar/?q=Test%20URL-encoded%20stuff"))
  (check-true (regexp-match? url "http://مثال.إختبار"))
  (check-true (regexp-match? url "http://例子.测试"))
  (check-true (regexp-match? url "http://उदाहरण.परीक्षा"))
  (check-true (regexp-match? url "http://-.~_!$&'()*+,;=:%40:80%2f::::::@example.com"))
  (check-true (regexp-match? url "http://1337.net"))
  (check-true (regexp-match? url "http://a.b-c.de"))
  (check-true (regexp-match? url "http://223.255.255.254"))
  (check-true (regexp-match? url "http://0.0.0.0"))
  (check-true (regexp-match? url "http://10.1.1.0"))
  (check-true (regexp-match? url "http://10.1.1.255"))
  (check-true (regexp-match? url "http://224.1.1.1"))
  (check-true (regexp-match? url "http://10.1.1.1"))
  (check-true (regexp-match? url "http://127.0.0.1"))
  (check-false (regexp-match? url "http://"))
  (check-false (regexp-match? url "http://."))
  (check-false (regexp-match? url "http://.."))
  (check-false (regexp-match? url "http://../"))
  (check-false (regexp-match? url "http://?"))
  (check-false (regexp-match? url "http://??"))
  (check-false (regexp-match? url "http://??/"))
  (check-false (regexp-match? url "http://#"))
  (check-false (regexp-match? url "http://##"))
  (check-false (regexp-match? url "http://##/"))
  (check-false (regexp-match? url "http://foo.bar?q=Spaces should be encoded"))
  (check-false (regexp-match? url "//"))
  (check-false (regexp-match? url "//a"))
  (check-false (regexp-match? url "///a"))
  (check-false (regexp-match? url "///"))
  (check-false (regexp-match? url "http:///a"))
  (check-false (regexp-match? url "foo.com"))
  (check-false (regexp-match? url "rdar://1234"))
  (check-false (regexp-match? url "h://test"))
  (check-false (regexp-match? url "http:// shouldfail.com"))
  (check-false (regexp-match? url ":// should fail"))
  (check-false (regexp-match? url "http://foo.bar/foo(bar)baz quux"))
  (check-false (regexp-match? url "ftps://foo.bar/"))
  ; OK? (check-false (regexp-match? url "http://-error-.invalid/"))
  ; OK? (check-false (regexp-match? url "http://a.b--c.de/"))
  ; OK? (check-false (regexp-match? url "http://-a.b.co"))
  ; OK? (check-false (regexp-match? url "http://a.b-.co"))
  (check-false (regexp-match? url "http://1.1.1.1.1"))
  ; OK? (check-false (regexp-match? url "http://123.123.123"))
  ; (check-false (regexp-match? url "http://3628126748"))
  (check-false (regexp-match? url "http://.www.foo.bar/"))
  ; (check-false (regexp-match? url "http://www.foo.bar./"))
  (check-false (regexp-match? url "http://.www.foo.bar./"))
  (check-false (regexp-match? url "tel:+1234567890"))
  )


;; =========== Case insensitive =============

;; text in parens
(define img #px"\\s+(?i:(img|src))=")
(module+ test
  (check-true (regexp-match? img " img="))
  (check-true (regexp-match? img " IMG="))
  (check-true (regexp-match? img "  img="))
  (check-true (regexp-match? img " src="))
  (check-true (regexp-match? img " SRC="))
  (check-false (regexp-match? img " imgk"))
  (check-false (regexp-match? img "img="))
  )

;; =========== Back references =============

;; match tag
(define b #px"<b>[^<]*</b>")
(module+ test
  (check-true (regexp-match? b "<b>bold text</b>"))
  (check-true (regexp-match? b "<b>USS Constitutuion</b>"))
  (check-false (regexp-match? b "ttt"))
  (check-false (regexp-match? b "<b>cc</i>"))
  )

;; text in parens
(define tag #px"<([^>]+)>[^<]*</\\1>")
(module+ test
  (check-true (regexp-match? tag "<b>bold text</b>"))
  (check-true (regexp-match? tag "<i>USS Constitutuion</i>"))
  (check-false (regexp-match? tag "ttt"))
  (check-false (regexp-match? tag "<a>cc</b>"))
  )

;; squares
(define square #px"^(.*)\\1$")
(module+ test
  (check-true (regexp-match? square "aabaab"))
  (check-true (regexp-match? square "baaabaaa"))
  (check-true (regexp-match? square "aa"))
  (check-true (regexp-match? square ""))
  (check-false (regexp-match? square "aabab"))
  (check-false (regexp-match? square "a"))
  )

;; anban
(define anban #px"^(a*)b\\1$")
(module+ test
  (check-true (regexp-match? anban "aba"))
  (check-true (regexp-match? anban "aabaa"))
  (check-true (regexp-match? anban "aaabaaa"))
  (check-true (regexp-match? anban "aaaaabaaaaa"))
  (check-false (regexp-match? anban "ttt"))
  (check-false (regexp-match? anban "ab"))
  (check-false (regexp-match? anban "aa"))
  (check-false (regexp-match? anban "ba"))
  (check-false (regexp-match? anban "aaabaa"))
  (check-false (regexp-match? anban "abaa"))
  )

;; anbn; from https://nikic.github.io/2012/06/15/The-true-power-of-regular-expressions.html
;; but I can't make it work.  It doesn't work in Python either p = re.compile(r"^(a(\1)?b)$") won't compile.
(define anbn #px"^(a(\\1)?b)$")
(module+ test
  (check-true (regexp-match? anbn "ab"))
  ; Fails: (check-true (regexp-match? anbn "aabb"))
  ;(check-true (regexp-match? anbn "aaabbb"))
  ;(check-true (regexp-match? anbn "aaaabbbb"))
  ;(check-false (regexp-match? anbn "ttt"))
  ;(check-false (regexp-match? anbn "a"))
  ;(check-false (regexp-match? anbn "aa"))
  ;(check-false (regexp-match? anbn "aaaaab"))
  ;(check-false (regexp-match? anbn "aaabb"))
  ;(check-false (regexp-match? anbn "b"))
  )

;; primes
;; https://iluxonchik.github.io/regular-expression-check-if-number-is-prime/
;(define prime #px"^(11+?)\\1+|1?$");
;(module+ test
  ;(check-true (regexp-match? prime "11"))
  ;(check-true (regexp-match? prime "111"))
  ;(check-true (regexp-match? prime "11111"))
  ;(check-true (regexp-match? prime "1111111"))
  ;(check-true (regexp-match? prime "11111111111"))
  ;(check-false (regexp-match? prime "1111"))
  ;)

#! /usr/bin/env racket
#lang racket
(define COUNTER 5)

;; Add one to the counter defined in the third line of the file
(define (intake fn)
  (let* ([contents (port->string (open-input-file fn) #:close? #t)]
         [lines-in (string-split contents "\n")]
         [third-line-in (string-split (third lines-in))]
         [later-lines-in (cdr (cdr (cdr lines-in)))]
         [counter (add1 (string->number (string-trim (third third-line-in) ")")))]
         [third-line-out (string-join (list "(define"
                                             "COUNTER"
                                             (number->string counter)
                                             ")")
                                       " "
                                       #:before-last "")]
         [lines-out (append (list (first lines-in)
                                  (second lines-in)
                                  third-line-out)
                            later-lines-in)])
    lines-out))

(define (update fn str-list)
  (let ([out-port (open-output-file fn #:exists 'replace)])
    (write-string (string-join str-list "\n") out-port)
    (close-output-port out-port)))
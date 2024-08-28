#! /usr/bin/env racket
#lang racket
(define COUNTER 11)

;; Get list of file lines, where the counter defined in the third line is incremented
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

;; Output the strings in a list to the named file
(define (update fn str-list)
  (let ([out-port (open-output-file fn #:exists 'replace #:permissions #o664)])  ; permit rw-rw-r--
    (write-string (string-join str-list "\n") out-port)
    (close-output-port out-port)))

;; When this file is called from the command line it runs these commands 
(update "self-modifying.rkt" (intake "self-modifying.rkt"))
(displayln (~a "Counter=" COUNTER))
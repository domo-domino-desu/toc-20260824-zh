#lang racket

;; Return the first character of the file (raise exception if file empty)
(define (first-char fn)
  (let ([contents (port->string (open-input-file fn) #:close? #t)])
    (string-ref contents 0)))
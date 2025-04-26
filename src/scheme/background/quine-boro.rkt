#lang racket
;; Directly from https://bor0.wordpress.com/2020/04/24/deriving-a-quine-in-a-lisp/
;; and also from https://www.andrew.cmu.edu/user/avigad/Teaching/candi_notes.pdf p 74, 75
; (define p (lambda (x) (list 'Boro 'is 'reading x)))
(define d (lambda (p x) (p (list 'quote (p x)))))
(define q (lambda (x) (list 'Boro 'is 'reading (d identity x))))
(define r (lambda (x) (d q x)))
(define quine-1 (lambda (x) (list x (list 'quote x))))


;; Tweak them to eliminate the lambda's
(define (P x)
  (list 'Boro 'is x))

(define (Diag p x)
  (p (list 'quote (p x))))

(define (Q x)
  (list 'Boro 'is (Diag identity x)))

(define (R x)
  (Diag Q x))

(define (Quine-1 x)
  (list x (list 'quote x)))

; Use this to avoid the definitions
;((lambda (x) (list x (list 'quote x)))
; '(lambda (x) (list x (list 'quote x))))
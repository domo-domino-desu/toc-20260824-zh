#lang racket

;; Run forever without repeating a configuration
(define (go-up)
  (do ([i 0 (add1 i)])
    (#f (displayln "routine halt"))
    (displayln (~a "i=" i))))

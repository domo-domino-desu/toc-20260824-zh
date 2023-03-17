#lang racket
(require rackunit
         "device.rkt"
         "turing-machine.rkt")
(require rackunit/text-ui) ; to run the test suites


;; ===== parse tests
(define parse-tests
  (test-suite
   "parse tests"
  
   (test-case
    "Test simple machine"
    (let* ([INPUT-LINES (list "0 a R 1" "0 b R 1")]
           [tm (parse INPUT-LINES INSTRUCTION-LINE-REGEXP parse-make-instruction instructionstruct)])
      (printf "tm=~a\n" (machine->string tm instruction->string))
      ))
   )) ;; end tape-making suite and tests



;; ===== Run the tests; comment out ones not being worked-on
(run-tests parse-tests)

#lang racket
(require rackunit
         "traverse.rkt")
(require rackunit/text-ui) ; to run the test suites

;; traverse-test.rkt
;;
;; Unit tests for traverse.rkt, from Jim Hefferon's _Theory of Computation_
;; License: GPL 3.0



;; ===== Tree making
(define (string-pad n)
  (apply string-append (build-list n (lambda (x) "  "))))
   
(define tree-tests
  (test-suite
   "tree tests"

   (test-case
    "Test node structure"
    (let ([n (node "a" (mutable-seteq))])
      (check-true (node? n))))

;   (test-case
;    "Test making a history"
;    (let* ([config (list "a" "b")]
;           [history (history-create config)])
;      ; (printf "~s\n" history)
;      (check-equal? (car history) config)
;      ))

;   (test-case
;    "Test building a history"
;    (let* ([config (list "0" "b")]
;           [history (history-create config)]
;           [config1 (list "1" "d")]
;           [node1 (history-node-make config1)]
;           [config2 (list "2" "f")]
;           [node2 (history-node-make config2)])
;      (history-node-add! history node1)
;      (printf "~s\n" history)
;      (check-equal? (car history) config)
;      (check-true (set-member? (cdr history) node1))
;      (history-node-add! node1 node2)
;      (printf "~s\n" history)
;      (check-equal? (car node1) config1)
;      (check-true (set-member? (cdr node1) node2))
;      ))

;   (test-case
;    "Test building a history"
;    (let* ([config (list 1)]
;           [history (history-create config)]
;           ; rank 1
;           [node-2 (history-node-add! history (history-node-make '(2)))]
;           [node-3 (history-node-add! history (history-node-make '(3)))]
;           ; rank 2
;           [node-4 (history-node-add! node-2 (history-node-make '(4)))]
;           [node-5 (history-node-add! node-2 (history-node-make '(5)))]
;           [node-6 (history-node-add! node-2 (history-node-make '(6)))]
;           [node-7 (history-node-add! node-3 (history-node-make '(7)))]
;           ; rank 3
;           [node-8 (history-node-add! node-4 (history-node-make '(8)))]
;           [node-9 (history-node-add! node-4 (history-node-make '(9)))]
;           [node-10 (history-node-add! node-5 (history-node-make '(10)))]
;           [node-11 (history-node-add! node-6 (history-node-make '(11)))]
;           [node-12 (history-node-add! node-7 (history-node-make '(12)))]
;           [node-13 (history-node-add! node-7 (history-node-make '(13)))]
;           ; rank 4
;           [node-14 (history-node-add! node-11 (history-node-make '(14)))]
;           [node-15 (history-node-add! node-13 (history-node-make '(15)))]
;           )
;      ; (printf "history: ~s\n" history)
;      (history-traverse-dfs history 0 (lambda (x y) (printf "~a~s\n" (string-pad y) (caar x))))
;;      (check-equal? (car history) config)
;;      (check-true (set-member? (cdr history) new-history-node))
;      ))

   )) ;; end traverse suite and tests




;; ===== Run the tests; comment out ones not being worked-on
(run-tests tree-tests)

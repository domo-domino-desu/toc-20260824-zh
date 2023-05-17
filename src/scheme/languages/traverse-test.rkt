#lang racket
(require rackunit
         "traverse.rkt")
(require rackunit/text-ui) ; to run the test suites

;; traverse-test.rkt
;;
;; Unit tests for traverse.rkt, from Jim Hefferon's _Theory of Computation_
;; License: GPL 3.0



;; ===== Tree making
;; void --> node
;; Make a tree to test on

(define (stm)
  (let* ([t (tree-create "a")]
         [nb (node-add-child! t "b")]
         [nc (node-add-child! t "c")]
         [nd (node-add-child! t "d")]
         [ne (node-add-child! nb "e")]
         [nf (node-add-child! nb "f")]
         [ng (node-add-child! nd "g")]
         [nh (node-add-child! nd "h")]
         [ni (node-add-child! ng "i")]
         [nj (node-add-child! ng "j")]
         )
    t))
   
(define tree-tests
  (test-suite
   "tree tests"

   (test-case
    "Test node structure"
    (let ([n (node "a" (mutable-seteq))])
      (check-true (node? n))))

   (test-case
    "Test creating a tree"
    (let* ([t (tree-create "a")])
      (check-true (node? t))
      (check-equal? (node-name t) "a")
      (check-true (set-empty? (node-children t)))
      ))

   (test-case
    "Test building a tree"
    (let* ([t (tree-create "a")]
           [naa (node-create "aa")]
           [saa (set-add! (node-children t) naa)]
           [nab (node-create "ab")]
           [sab (set-add! (node-children t) nab)]
           )
      (check-true (node? t))
      (check-equal? (node-name t) "a")
      (check-true (set-member? (node-children t) naa))
      (check-true (set-member? (node-children t) nab))
      (let* ([naaa (node-create "aaa")]
             [saaa (set-add! (node-children naa) naaa)]
             [naba (node-create "aba")]
             [saba (set-add! (node-children nab) naba)]
             )
        (check-true (set-member? (node-children naa) naaa))
        (check-true (set-member? (node-children nab) naba))
        )
      ))


   (test-case
    "Test breadth-first search"
    (let* ([t (stm)]
           )
      (tree-bfs t show-node-name)
      ))

   (test-case
    "Test depth-first search"
    (let* ([t (stm)]
           )
      (tree-dfs t 0 show-node-name)
      ))

   )) ;; end traverse suite and tests


;; ===== Run the tests; comment out ones not being worked-on
(run-tests tree-tests)

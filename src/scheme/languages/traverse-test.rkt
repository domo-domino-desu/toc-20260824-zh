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

(define (sample-tree-make)
  (let* ([t (graph-create "a")]
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


(define (cantor-tree-make)
  (let* ([t (graph-create "0,0")]
         [nb (node-add-child! t "0,1")]
         [nc (node-add-child! t "1,0")]
         [nd (node-add-child! nb "0,2")]
         [ne (node-add-child! nb "1,1")]
         [v0 (set-add! (node-children nc) ne)]
         [nf (node-add-child! nb "2,0")]
         [ng (node-add-child! nd "0,3")]
         [nh (node-add-child! nd "1,2")]
         [v1 (set-add! (node-children ne) nh)]
         [ni (node-add-child! ne "2,1")]
         [v2 (set-add! (node-children nf) ni)]
         [nj (node-add-child! nf "3,0")]
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
    (let* ([t (graph-create "a")])
      (check-true (node? t))
      (check-equal? (node-name t) "a")
      (check-true (set-empty? (node-children t)))
      ))

   (test-case
    "Test building a tree"
    (let* ([t (graph-create "a")]
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
    "Test depth-first search"
    (displayln "+++++ Depth-first below here")
    (let* ([t (sample-tree-make)]
           )
      (traverse-dfs t 0 show-node-name)
      ))

   (test-case
    "Test depth-first search"
    (displayln "+++++ Depth-first below here")
    (let* ([t (sample-tree-make)]
           )
      (traverse-dfs t 0 show-node-name)
      ))

   (test-case
    "Test depth-first search on a DAG"
    (displayln "+++++ Depth-first on a DAG below here")
    (let* ([t (cantor-tree-make)]
           )
      (traverse-dfs t 0 show-node-name)
      ))

   (test-case
    "Test breadth-first search"
    (displayln "+++++ Breadth-first below here")
    (let* ([t (sample-tree-make)]
           )
      (tree-bfs t show-node-name)
      ))

   (test-case
    "Test breadth-first search on DAG"
    (displayln "+++++ Traverse breadth-first on DAG below here")
    (let* ([t (cantor-tree-make)]
           )
      (traverse-bfs t show-node-name)
      ))

   (test-case
    "Test breadth-first search on DAG"
    (displayln "+++++ Traverse breadth-first on tree below here")
    (let* ([t (sample-tree-make)]
           )
      (traverse-bfs t show-node-name)
      ))

   )) ;; end traverse suite and tests


;; ===== Run the tests; comment out ones not being worked-on
(run-tests tree-tests)

#! /usr/bin/env racket
#lang racket

;; traverse.rkt
;;
;; DAG traversal for Jim Hefferon's _Theory of Computation_
;; License: GPL 3.0

;; ===== A graph is made of nodes

;; Structure: create a number of routines including
;;  constructor (node ..) that takes two arguments 
;;  boolean (node? ..)
;;  selectors (node-name ..) and (node-children ..)
(struct node (name children))

;; string -> node
;; Create a node.
;;   name  string
;; The children are in a set.
(define (node-create name)
  (node name (mutable-set)))

;; string -> node
;; Create a new graph.
;;  first-node-name   string  Name of first, or root, node
(define (graph-create first-node-name)
  (node-create first-node-name))

;; node, string --> node
;; To the node n's children create and add a child node.  Return child node.
;;  parent  instance of structure node
;;  c  instance of structure node
(define (node-add-child! parent child-name)
  (let ([n (node-create child-name)])
    (set-add! (node-children parent) n)
    n))

;; natual number --> string
;; Return a string with 2*n spaces 
(define (string-pad n)
  (apply string-append (build-list n (lambda (x) "  "))))

;; node, natural number --> print a string
;; Print a represenation of the node
(define (show-node-name n r)
  (printf "~a~a\n" (string-pad r) (node-name n)))

;; Default for the deepest a traversal will go
(define MAXIMUM-RANK 100)

;; Traverse the tree breadth first
;;   node  Root node 
;;   fcn  Function to apply to each node
;;   #:maxrank  Natural number, the max rank that is traversed
(define (tree-bfs node fcn #:maxrank [maxrank MAXIMUM-RANK])
  (tree-bfs-helper (list node) 0 fcn #:maxrank maxrank))

(define (tree-bfs-helper level rank fcn #:maxrank [maxrank MAXIMUM-RANK])
  (when (< rank maxrank)
    (let ([next-level '()])
      (for ([node level])
        (fcn node rank)
        (for ([child-node (node-children node)])
          (set! next-level (cons child-node next-level))
          ))
      (when (not (null? next-level))
        (tree-bfs-helper next-level (+ 1 rank) fcn)))))

;; Traverse the tree or DAG breadth first
;;   node  Starting node
;;   fcn  Function to apply to each node
;;   #:maxrank  Natural number, the max rank that is traversed
(define (traverse-bfs node fcn #:maxrank [maxrank MAXIMUM-RANK])
  (traverse-bfs-helper (mutable-set node) 0 fcn #:maxrank maxrank))

(define (traverse-bfs-helper level rank fcn #:maxrank [maxrank MAXIMUM-RANK])
  (when (< rank maxrank)
    (let ([next-level (mutable-set)])
      (for ([node level])
        (fcn node rank)
        (for ([child-node (node-children node)])
          (set-add! next-level child-node)
          ))
      (when (not (set-empty? next-level))
        (traverse-bfs-helper next-level (+ 1 rank) fcn)))))

;; Traverse the tree depth first
;;   node  Root node of tree
;;   rank  Natural number  Depth of this node in the tree
;;   fcn  Function to apply to each node
;;   #:maxrank  Natural number, the max rank that is traversed
(define (tree-dfs node rank fcn #:maxrank [maximumrank MAXIMUM-RANK])
  (fcn node rank)
  (when (< rank maximumrank)
    (let ([children (node-children node)])
      (for ([child children])
        (tree-dfs child (+ rank 1) fcn #:maxrank maximumrank))
      )))

;; void --> tree of nodes
;; Make a tree to experiment on.
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

;; void --> tree of nodes
;; Make a binary tree.
(define (exercise-tree-make)
  (let* ([t (graph-create "a")]
         [nb (node-add-child! t "b")]
         [nc (node-add-child! t "c")]
         [nd (node-add-child! nb "d")]
         [ne (node-add-child! nb "e")]
         [nf (node-add-child! nc "f")]
         [ng (node-add-child! nc "g")]
         [nh (node-add-child! ng "h")]
         [ni (node-add-child! ng "i")]
         )
    t))

;; void --> DAG of nodes
;; Make the Cantor graph.
(define (cantor-DAG-make)
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


(provide node
         node?
         node-name
         node-children
         node-create
         graph-create
         node-add-child!
         show-node-name
         MAXIMUM-RANK
         tree-bfs
         traverse-bfs
         tree-dfs
 )


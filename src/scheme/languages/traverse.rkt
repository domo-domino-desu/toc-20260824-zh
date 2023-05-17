#! /usr/bin/env racket
#lang racket

;; traverse.rkt
;;
;; Graph traversal for Jim Hefferon's _Theory of Computation_
;; License: GPL 3.0

;; ===== A tree is made of nodes

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
  (node name (mutable-seteq)))

;; string -> node
;; Create a new tree.
;;  root-node-name   string  Name of root node
(define (tree-create root-node-name)
  (node-create root-node-name))

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
;;   node  Root node of tree
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

(provide node
         node?
         node-name
         node-children
         node-create
         tree-create
         node-add-child!
         show-node-name
         MAXIMUM-RANK
         tree-bfs
         tree-dfs
 )


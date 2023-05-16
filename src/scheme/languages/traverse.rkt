#! /usr/bin/env racket
#lang racket

;; traverse.rkt
;;
;; Graph traversal for Jim Hefferon's _Theory of Computation_
;; License: GPL 3.0


;; set -> string
;; Show a set in a readable way
;; The optional argument allows you to format the elements 
(define (set->string s [elet->string (lambda (x) (format "~a" x))])
  (string-join (map elet->string (set->list s)) #:before-first "{ " #:after-last " }"))

;; ===== Tree, made of nodes

;; Structure: create a number of routines including
;;  constructor (node ..) that takes two arguments 
;;  boolean (node? ..)
;;  selectors (node-name ..) and (node-children ..)
(struct node (name children))

;; Create a node
;;   name  string
;; The children are in a set.
(define (node-create name)
  (node name (mutable-seteq)))

;; Create a new tree
;;  root-node-name   string  Name of root node
(define (tree-create root-node-name)
  (node-create root-node-name))

;; Add a child to the node's children
;;  n  instance of structure node
;;  c  instance of structure node
(define (node-add-child! n c)
  (set-add! (node-children n) c))

;; Default for the deepest a traversal will go
(define MAXIMUM-RANK 100)

;; Traverse the tree breadth first
;;   node  Root node of tree
;;   fcn  Function to apply to each node
;;   #:maxrank  Natural number, the max rank that is traversed
(define (tree-bfs node fcn #:maxrank [maximumrank MAXIMUM-RANK])
  (tree-bfs-helper [node] 0 fcn #:maximumrank maximumrank))

(define (tree-bfs-helper level rank fcn #:maxrank [maximumrank MAXIMUM-RANK])
  (when (< rank maximumrank)
    (let ([next-level '()])
      (for ([node level])
        (fcn node rank)
        (for ([child-node (node-children node)])
          (cons child-node next-level)
          ))
      (when (not (null? next-level))
        (tree-bfs-helper next-level (+ 1 rank) fcn)))))

;; Traverse the tree depth first
;;   node  Root node of tree
;;   rank  Natural number  Depth of this node in the tree
;;   fcn  Function to apply to each node
;;   #:maxrank  Natural number, the max rank that is traversed
(define (tree-dfs node rank fcn #:maxrank [maximumrank MAXIMUM-RANK])
  ; (printf "history-traverse-dfs: node ~s  rank=~s\n" node rank)
  (fcn node rank)
  (when (< rank maximumrank)
    (let ([children (node-children node)])
      (for ([child children])
        ; (printf "   child is ~s\n" child)
        (tree-dfs child (+ rank 1) fcn #:maxrank maximumrank))
      )))

(provide node
         node?
         node-create
         tree-create
         node-add-child!
         MAXIMUM-RANK
         tree-bfs
         tree-dfs
 )


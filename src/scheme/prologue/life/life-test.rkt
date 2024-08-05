#lang racket
;; life-test.rkt
(require rackunit
         "life.rkt")
(require rackunit/text-ui) ; to run the test suites


;; ===== Creation and get/set of grids
(define creation-tests
  (test-suite
   "Grid creation tests"
  
   (test-case
    "Grid creation simple"
    (let* ([g (grid-create 3 5)])
      ; (displayln g)
      (check-pred vector? g "grid is not a vector")
      (check-pred pair? (grid-size g) "grid-size is not a pair")
      (check-eq? (length (grid-size g)) 2 "grid-size is not a length-two list")
      (for* ([row (in-range 3)]
             [col (in-range 5)])
        (check-eq? (vector-ref (vector-ref g row) col) DEAD))  
      )) 

   (test-case
    "Grid getters and setters simple"
    (let* ([g (grid-create 3 5)])
      (for* ([row (in-range 3)]
             [col (in-range 5)])
        (check-eq? (grid-get g row col) DEAD) "Expect all elets of newly-created grid are DEAD")
      ; set something to non-DEAD
      (grid-set! g 1 3 ALIVE)
      ; (displayln g)
      ; (displayln (vector-ref (vector-ref g 1) 2))
      (check-eq? (grid-get g 1 3) ALIVE "Simple grid-get retrieval failed")
      ))

   (test-case
    "Grid as string"
    (let* ([num-rows 3]
           [num-cols 5]
           [g (grid-create num-rows num-cols)])
      (for* ([row (in-range 3)]
             [col (in-range 5)])
        ; (displayln (~a "row=" row " col=" col))
        (when (odd? (+ row col))
          (grid-set! g row col ALIVE)))
      (check-pred string? (grid->string g) "grid->string failed to produce a string")
      (check-eqv? (string-length (grid->string g)) (+ (- num-rows 1) (* num-rows num-cols)) "grid->string length not right")
      ; (displayln (~a "grid is\n" g))
      ; (displayln (~a "string is \n" (grid->string g) "<---"))
      (check-true (string=? (grid->string g) ".*.*.\n*.*.*\n.*.*.") "grid->string didn't produce expected string")
      ))

   (test-case
    "Getting the values of the neighbors of a grid cell"
    (let ([g (grid-create 3 5)])
      (for* ([row (in-range 3)]
             [col (in-range 5)])
        ; (displayln (~a "row=" row " col=" col))
        (when (odd? (+ row col))
          (grid-set! g row col ALIVE)))
      ; (displayln (grid->string g))
      ; Test a cell not on the boundary
      (check-pred list? (grid-neighbor-vals-get g '(1 1)) "grid-neighbor-vals-get failed to return a list")
      ; (displayln (~a "list is \n" (grid-neighbor-vals-get g '(1 1))))
      (check-pred list? (grid-neighbor-vals-get g '(1 1)) "grid-neighbot-vals-get failed to return a list")
      (check-eq? (length (grid-neighbor-vals-get g '(1 1))) 8 "grid-neighbor-vals-get list is not length 8")
      (check-equal? (grid-neighbor-vals-get g '(1 1)) '(0 1 0 1 0 1 0 1) "grid-neighbor-vals-get unexpected returned listfor (1 1)")
      ; Test a cell on the boundary; (2 0) has two alive neighbors
      (check-pred list? (grid-neighbor-vals-get g '(2 0)) "grid-neighbor-vals-get failed to return a list")

      ;(displayln (~a "grid is \n" (grid->string g) "\n"))

      ;(displayln (~a "list is \n" (grid-neighbor-vals-get g '(2 0))))
      (check-pred list? (grid-neighbor-vals-get g '(2 0)) "grid-neighbot-vals-get failed to return a list")
      (check-eq? (length (grid-neighbor-vals-get g '(2 0))) 8 "grid-neighbor-vals-get list is not length 8 ")
      (check-equal? (grid-neighbor-vals-get g '(2 0)) '(0 1 0 1 0 0 0 0) "grid-neighbor-vals-get unexpected returned list")
      ))

   (test-case
    "Test grid equality"
    (let ([g0 (grid-create 3 5)]
          [g1 (make-vector 5 "abc")])
      (check-true (grid? g0) "Expected to find it is a grid")
      (check-false (grid? g1) "Not a grid, since members are not vectors")
      )
    (let ([g0 (grid-create 3 5)]
          [g1 (grid-create 3 4)])
      (check-false (grid-equal? g0 g1) "Different sizes")
      )
    (let ([g0 (grid-create 3 5)]
          [g1 (grid-create 3 5)])
      (check-true (grid-equal? g0 g1) "3 by 5 all elets zero")
      (grid-set! g0 1 2 ALIVE)
      (check-false (grid-equal? g0 g1) "They differ on the 1,2 entry")
      )
    )
   
   (test-case
    "Grid copy"
    (let ([g-src (grid-create 2 4)]
          [g-dest (grid-create 4 7)])
      (for* ([row (in-range 2)]
             [col (in-range 4)])
        ; (displayln (~a "row=" row " col=" col))
        (when (odd? (+ row col))
          (grid-set! g-src row col ALIVE)))
      ; Copy src to dest
      (grid-copy g-src g-dest (list 1 2))
      ; (displayln (~a "destination grid is\n" (grid->string g-dest)))
      (check-true (string=? (grid->string g-dest) ".......\n...*.*.\n..*.*..\n.......") "grid-copy didn't produce expected string")
      ))

   (test-case
    "Copy row and column vectors"
    (let ([src-vector (make-vector 6 ALIVE)]
          [g-dest (grid-create 2 7)])
      ; Copy src to dest
      (grid-copy-row src-vector g-dest (list 0 1))
      ; (displayln (~a "destination grid is\n" (grid->string g-dest)))
      (check-true (string=? (grid->string g-dest) ".******\n.......") "grid-copy-row didn't produce expected string")
      )
    (let ([src-vector (make-vector 3 ALIVE)]
          [g-dest (grid-create 4 2)])
      ; Copy src to dest
      (grid-copy-col src-vector g-dest (list 1 0))
      ; (displayln (~a "destination grid is\n" (grid->string g-dest)))
      (check-true (string=? (grid->string g-dest) "..\n*.\n*.\n*.") "grid-copy-col didn't produce expected string")
      )
    )

   )) ;; end suite and tests


;; Convenience grid for testing
(define (blinker-make)  ; horizontal blinker
  (let* ([g (grid-create 3 3)])
    (grid-set! g 1 0 ALIVE) 
    (grid-set! g 1 1 ALIVE) 
    (grid-set! g 1 2 ALIVE)
    g))

(define (beehive-make)  
  (let* ([g (grid-create 5 5)])
    (grid-set! g 1 2 ALIVE) 
    (grid-set! g 2 1 ALIVE) 
    (grid-set! g 2 3 ALIVE)
    (grid-set! g 3 1 ALIVE)
    (grid-set! g 3 3 ALIVE)
    (grid-set! g 4 2 ALIVE)
    g))

;; ===== Generation of grids
(define generation-tests
  (test-suite
   "Grid generation tests"
  
   (test-case
    "Next generation of a cell"
    (let ([cell-val ALIVE]
          [nbr-val-list (list ALIVE DEAD ALIVE DEAD DEAD DEAD DEAD DEAD)])
      (check-equal? (cell-next-gen cell-val nbr-val-list) ALIVE "cell alive, two neighbors alive, should yield alive")
      ) 
    (let ([cell-val ALIVE]
          [nbr-val-list (list ALIVE DEAD DEAD DEAD DEAD DEAD DEAD DEAD)])
      (check-equal? (cell-next-gen cell-val nbr-val-list) DEAD "cell alive, one neighbors alive, should yield dead")
      ) 
    (let ([cell-val DEAD]
          [nbr-val-list (list ALIVE DEAD ALIVE DEAD ALIVE DEAD DEAD DEAD)])
      (check-equal? (cell-next-gen cell-val nbr-val-list) ALIVE "cell alive, two neighbors alive, should yield alive")
      ) 
    (let ([cell-val DEAD]
          [nbr-val-list (list ALIVE DEAD DEAD DEAD DEAD DEAD DEAD DEAD)])
      (check-equal? (cell-next-gen cell-val nbr-val-list) DEAD "cell alive, two neighbors alive, should yield dead")
      ) 
    )
   
   (test-case
    "Do a grid generation"
    (let ([g-old (blinker-make)])
      (let ([g-new (grid-generation g-old)])
        ; (display (~a "New grid: " (grid->string g-new)))
        (check-true (string=? (grid->string g-new) ".*.\n.*.\n.*.") "grid->generation didn't produce expected new grid")
       )
      )
    )
     
   (test-case
    "Check for outside cells"
    (let* ([g-old (blinker-make)]
           [g-new (grid-generation g-old)]
           [out-cells (outside-cells g-new)])
      (display (~a "New grid:\n" (grid->string g-new)))
      (check-false (any-alive-cells? (first out-cells)) "Shoud be no alive cells on the left")
      (check-false (any-alive-cells? (second out-cells)) "Shoud be no alive cells on the right")
      (check-false (any-alive-cells? (third out-cells)) "Shoud be no alive cells on the top")
      (check-false (any-alive-cells? (fourth out-cells)) "Shoud be no alive cells on the bot")
      )
    )

   )) ;; end suite and tests



;; ===== Evolution of a universe
(define universe-tests
  (test-suite
   "Test universe functions"
  
   (test-case
    "Make a universe"
    (let* ([g (grid-create 3 3)]
           [oset (list 0 0)]
           [u (universe g oset)])
      (check-pred universe? u "universe created")
      ; (displayln (universe->string u)))
    )
    )
  
   (test-case
    "Run a universe for a generation"
    (let* ([g (blinker-make)]
           [oset (list 0 0)]
           [u (universe g oset)])
      ; (displayln (universe->string (universe-generation u))
      (check-pred universe? u "universe created")
      ) 
    )
  
   (test-case
    "Test equality predicate"
    (let* ([g0 (beehive-make)]
           [g1 (beehive-make)]
           [g2 (blinker-make)]
           [u0 (universe g0 (list 0 0))]
           [u1 (universe g1 (list 0 0))]
           [u2 (universe g2 (list 0 0))])
      (check-pred universe? u0 "universe created")
      (check-true (universe-equal? u0 u1) "Equal grids and equal offsets")
      (check-false (universe-equal? u0 u2) "Same offset but unequal sizes")
      ) 
    )
   
   (test-case
    "Run a beehive universe for a generation"
    (let* ([g (beehive-make)]
           [oset (list 0 0)]
           [u (universe g oset)])
      ; (displayln (universe->string (universe-generation u)))
      (check-pred universe? u "universe created")
      (check-true (universe-equal? u (universe-generation u)) "Beehive recreates itself")
      ) 
    )


   )) ;; end suite and tests



;; ===== Parsing lines from input file
(define parse-tests
  (test-suite
   "Test line-parsing functions"
  
   (test-case
    "Parse single lines"
    (let* ([lne ".*."]
           [r (parse-line lne)])
      ;(displayln r)
      (check-pred list? r "parse-line should return a list")
      (check-eqv? (length r) (string-length lne) "parse-line should return a list as long as the string"))
    ; Put a newline on the end
    (let* ([lne ".*.\n"]  
           [r (parse-line lne)])
      (check-pred list? r "parse-line should return a list")
      (check-eqv? (length r) 3 "parse-line should return a list as long as the string, without the newline"))
     )
    (let* ([lne ".*."]
           [r (parse-line lne)])
      ;(displayln r)
      (check-equal? r (list DEAD ALIVE DEAD) "parse-line should return list with DEAD's and ALIVE's"))

   (test-case
    "Parse multiple lines"
    (let* ([lnes (list ".*." "**.")]
           [r (parse-lines lnes)])
      ;(displayln r)
      (check-pred list? r "parse-lines should return a list")
      (check-eqv? (length r) (length lnes) "parse-lines should return a list as long as the number of lines"))
    )
    (let* ([lnes (list ".*." "  # comment" "**.")]
           [r (parse-lines lnes)])
      ;(displayln r)
      (check-pred list? r "parse-lines should return a list")
      (check-eqv? (length r) 2 "parse-lines should not count comment lines")
    )

   (test-case
    "Parse lines to a grid"
    (let* ([lnes (list ".*." "**.")]
           [g (parse-lines-to-grid lnes)])
      ; (displayln (grid->string g))
      (check-true (string=? (grid->string g) ".*.\n**.") "parse-lines-to-grid didn't produce expected grid")
      )
    ; Include a comment line
    (let* ([lnes (list "# comment" ".*." "**.")]
           [g (parse-lines-to-grid lnes)])
      (check-true (string=? (grid->string g) ".*.\n**.") "parse-lines-to-grid didn't produce expected grid")
      )
    ; Later line shorter
    (let* ([lnes (list "# comment" ".*." ".")]
           [g (parse-lines-to-grid lnes)])
      (check-true (string=? (grid->string g) ".*.\n...") "parse-lines-to-grid didn't produce expected grid for mixed-length lines")
      (check-equal? (second (grid-size g)) 3 "Expected grid to have total of three cols")
      )
    ; Earlier line shorter
    (let* ([lnes (list "# comment" "." "**.")]
           [g (parse-lines-to-grid lnes)])
      (check-true (string=? (grid->string g) "...\n**.") "parse-lines-to-grid didn't produce expected grid for earlier line shorter")
      (check-equal? (second (grid-size g)) 3 "Expected grid to have three cols")
      )
    )

    )) ;; end suite and tests


;; ===================================================

;; Tests for creation and manipulation of grids
; (run-tests creation-tests)

;;  Tests for getting the next generation of a grid
(run-tests generation-tests)

;;  Tests for the evolution of a universe
; (run-tests universe-tests)

;;  Tests for parsing lines from the input file
; (run-tests parse-tests)

#lang racket
;; Conway's Game of Life

;; I/O files are plain text with arrays of *'s and .'s for alive cell and dead cell
(define ALIVE-CH #\*)
(define DEAD-CH #\.)

;; ======================================
;; Grid
;;  Array of 1's and 0's
;; In grid, 1 means alive and 0 means dead 1's and 0's
(define ALIVE 1)
(define DEAD 0)

;; Create a grid filled with dead cells
(define (grid-create num-rows num-cols)
  (build-vector num-rows (lambda (y) (make-vector num-cols DEAD))))

(define (grid-size grid)
  (if (empty? grid)
      '()
      (list (vector-length grid)
        (vector-length (vector-ref grid 0)))))

(define (grid-get grid x y)
  (let ([size (grid-size grid)])
    (if (and (< x (car size))
             (< y (cadr size)))
        (vector-ref (vector-ref grid x) y)
        0)))

(define (grid-set! grid x y val)
  (let ([size (grid-size grid)])
    (if (and (< x (first size))
             (< y (second size)))
        (vector-set! (vector-ref grid x) y val)
        (raise-arguments-error 'jh-write-outside-grid
                               "writing outside the grid"
                               "x" x
                               "y" y))))

(define (grid-copy g-src g-dest upper-left)
  (let* ([g-src-size (grid-size g-src)]
         [g-src-numrows (first g-src-size)]
         [g-src-numcols (second g-src-size)]
         [g-dest-size (grid-size g-dest)]
         [uleft-row (car upper-left)]
         [uleft-col (second upper-left)])
    (for* ([row (in-range g-src-numrows)]
           [col (in-range g-src-numcols)])
      (grid-set! g-dest (+ row uleft-row) (+ col uleft-col)))))

(provide ALIVE
         DEAD
         grid-create
         grid-size
         grid-get
         grid-set!
         grid-copy)

;; ==========================================
;; Universe
;;  grid of cells  vector of vectors of 1's and 0's
;;  offset   universe-offset giving how far (x,y) from this universe's uppper left to upper left of starting uni
(struct universe (grid offset) #:transparent)

(define (universe-set! u x y value)
  (let* ([g (universe-grid u)]
         [g-size (grid-size g)]
         [oset (universe-offset u)]
         [oset-x (car oset)]
         [oset-y (cadr oset)])
    (if (or (negative? x)
            (negative? y)
            (>= x (first g-size))
            (>= y (second g-size)))
        (universe-set-resize! g oset x y value)
        (universe (grid-set! x y value) oset))))

;(define (grid-copy g-src g-dest upper-left)
;  (let* ([g-src-size (grid-size g-src)]
;         [g-src-numrows (first g-src-size)]
;         [g-src-numcols (second g-src-size)]
;         [g-dest-size (grid-size g-dest)]
;         [uleft-row (car upper-left)]
;         [uleft-col (second upper-left)])
;    (for* ([row (in-range g-src-numrows)]
;           [col (in-range g-src-numcols)])
;      (grid-set! g-dest (+ row uleft-row) (+ col uleft-col)))))

(define (universe-set-resize! grid offset x y value)
  '())



(provide universe
         universe?
         universe-grid
         universe-offset
         universe-set!)


;(define rows vector-length)
;
;(define (cols grid)
;  (vector-length (vector-ref grid 0)))
;
;(define (make-grid m n living-cells)
;  (let loop ([grid (make-empty-grid m n)]
;             [cells living-cells])
;    (if (empty? cells)
;        grid
;        (loop (2d-set! grid (caar cells) (cadar cells) 1) (cdr cells)))))
;
;(define (2d-ref grid i j)
;  (cond [(< i 0) 0]
;        [(< j 0) 0]
;        [(>= i (rows grid)) 0]
;        [(>= j (cols grid)) 0]
;        [else (vector-ref (vector-ref grid i) j)]))
;
;(define (2d-refs grid indices)
;  (map (lambda (ind) (2d-ref grid (car ind) (cadr ind))) indices))
;
;(define (2d-set! grid i j val)
;  (vector-set! (vector-ref grid i) j val)
;  grid)




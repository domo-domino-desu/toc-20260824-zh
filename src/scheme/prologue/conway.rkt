#lang racket
;; Conway's Game of Life

;; I/O files are plain text with arrays of *'s and .'s for alive cell and dead cell
(define ALIVE-CH #\*)
(define DEAD-CH #\.)

;; In grid, 1 means alive and 0 means dead
(define ALIVE 1)
(define DEAD 0)

(define (grid-ch->grid-val ch)
  (if (eq? ch ALIVE-CH)
      ALIVE
      DEAD))
(define (grid-val->grid-ch v)
  (if (eq? v ALIVE)
      ALIVE-CH
      DEAD-CH))

;; ======================================
;; Grid
;;  Array of ALIVE's and DEAD's

;; Create a grid, filled with dead cells
(define (grid-create num-rows num-cols)
  (build-vector num-rows (lambda (y) (make-vector num-cols DEAD))))

;; Get number of rows, number of cols
(define (grid-size grid)
  (if (empty? grid)
      '()
      (list (vector-length grid)
        (vector-length (vector-ref grid 0)))))

;; Get x,y entry (zero offset) 
(define (grid-get grid x y)
  (let ([size (grid-size grid)])
    (if (and (< x (car size))
             (< y (cadr size))
             (>= x 0)
             (>= y 0))
        (vector-ref (vector-ref grid x) y)
        DEAD)))

;; Grid as string
(define (grid->string grid)
  (let* ([size (grid-size grid)]
         [num-rows (first size)]
         [num-cols (second size)]
         [s (make-vector (+ num-rows (* num-rows num-cols)))])  ; put extra \n on, then strip at end 
    (let ([i 0])
      (for ([row (in-range num-rows)])
        (for ([col (in-range num-cols)])
          (vector-set! s
                       i
                       (grid-val->grid-ch (grid-get grid row col)))
          (set! i (+ i 1)))
        (vector-set! s i "\n")
        (set! i (+ i 1))))
    ; Return the concatenation of all the vector elets, with final "\n" stripped
    (apply ~a (vector->list (vector-copy s 0 (- (vector-length s) 1))))))

;; Display grid to terminal
(define (grid-display grid)
  (displayln (grid->string grid)))

;; Get list of values of neighbors of grid cell (x,y) pair
(define (grid-neighbor-vals-get g c)
  (let ([row (first c)]
        [col (second c)])
    (list (grid-get g (- row 1) (- col 1)) ;  top left
          (grid-get g (- row 1) col)  ; top
          (grid-get g (- row 1) (+ col 1))  ; top right
          (grid-get g row (+ col 1))  ; right
          (grid-get g (+ row 1) (+ col 1))  ; bottom right
          (grid-get g (+ row 1) col)  ; bottom
          (grid-get g (+ row 1) (- col 1))  ; bottom left
          (grid-get g row (- col 1))  ; left
          )))

;; Change x,y entry in grid (zero offset)
(define (grid-set! grid x y val)
  (let ([size (grid-size grid)])
    (if (and (< x (first size))
             (< y (second size)))
        (vector-set! (vector-ref grid x) y val)
        (raise-arguments-error 'jh-write-outside-grid
                               "writing outside the grid"
                               "x" x
                               "y" y))))

;; Copy contents of grid from src to dest, where (0,0) in src is at upper-left in dest
(define (grid-copy g-src g-dest upper-left)
  (let* ([g-src-size (grid-size g-src)]
         [g-src-numrows (first g-src-size)]
         [g-src-numcols (second g-src-size)]
         [g-dest-size (grid-size g-dest)]
         [uleft-row (car upper-left)]
         [uleft-col (second upper-left)])
    (for* ([row (in-range g-src-numrows)]
           [col (in-range g-src-numcols)])
      (grid-set! g-dest
                 (+ row uleft-row)
                 (+ col uleft-col)
                 (grid-get g-src row col)))))

;; Copy a row vector src to the destination dest, starting at (row,col)
(define (grid-copy-row src dest start)
  (let* ([start-row (first start)]
         [start-col (second start)])
    (for ([col (in-range (vector-length src))])
      (grid-set! dest
                 start-row
                 (+ col start-col)
                 (vector-ref src col)))))

;; Copy a column vector src to the destination dest, starting at (row,col)
(define (grid-copy-col src dest start)
  (let* ([start-row (first start)]
         [start-col (second start)])
    (for ([row (in-range (vector-length src))])
      (grid-set! dest
                 (+ row start-row)
                 start-col
                 (vector-ref src row)))))

(provide ALIVE
         DEAD
         grid-create
         grid-size
         grid-get
         grid->string
         grid-display
         grid-neighbor-vals-get
         grid-set!
         grid-copy
         grid-copy-row
         grid-copy-col)

;; ==========================================
;; Life cycle

;; Whether a cell will be alive or dead in the next generation 
(define (cell-next-gen cell-val nbr-val-lst)
  (let ([tot (apply + nbr-val-lst)])
    (if (eq? cell-val ALIVE)
        (if (or (= tot 2) (= tot 3))
            ALIVE
            DEAD)
        (if (= tot 3)
            ALIVE
            DEAD))))

;;  Go through grid, updating cells.
(define (grid-generation g-old)
  (let* ([size (grid-size g-old)]
         [num-rows (first size)]
         [num-cols (second size)]
         [g-new (grid-create num-rows num-cols)])
    (for* ([row (in-range num-rows)]
           [col (in-range num-cols)])
      (grid-set! g-new row col
                 (cell-next-gen (grid-get g-old row col)
                                (grid-neighbor-vals-get g-old (list row col)))))
      g-new))

(provide cell-next-gen
         grid-generation
         )


;; ==========================================
;; Universe
;;  grid of cells  vector of vectors of 1's and 0's
;;  offset   universe-offset giving how far (x,y) from this universe's uppper left to upper left of starting uni
(struct universe (grid offset) #:transparent)

; Have the universe evolve for one generation
(define (universe-generation u)
  (let* ([g-old (universe-grid u)]
         [size (grid-size g-old)]
         [num-rows (first size)]
         [num-cols (second size)]
         [f-old (universe-offset u)]
         [g-new (grid-generation g-old)])
    ; Any cells come alive outside the starting grid?
    (let ([left-side (grid-create num-rows 1)]
          [right-side (grid-create num-rows 1)]
          [top-side (grid-create 1 num-cols)]
          [bot-side (grid-create 1 num-cols)])
      (for ([row (in-range num-rows)])
        (grid-set! left-side row 0
                   (cell-next-gen DEAD
                                  (grid-neighbor-vals-get g-old (list row -1))))
        (grid-set! right-side row 0
                   (cell-next-gen DEAD
                                  (grid-neighbor-vals-get g-old (list row num-cols)))))
      (for ([col (in-range num-cols)])
        (grid-set! top-side 0 col
                   (cell-next-gen DEAD
                                  (grid-neighbor-vals-get g-old (list -1 col))))
        (grid-set! bot-side 0 col
                   (cell-next-gen DEAD
                                  (grid-neighbor-vals-get g-old (list num-rows col)))))
      ; Flag if need to add any sides to new universe's grid
      (let ([left-side-flag (positive? (apply + (vector->list left-side)))]
            [right-side-flag (positive? (apply + (vector->list right-side)))]
            [top-side-flag (positive? (apply + (vector->list top-side)))]
            [bot-side-flag (positive? (apply + (vector->list bot-side)))]
            [u-new-width num-cols]  ; Will be width of ending universe's grid
            [u-new-hgt num-rows]
            [u-new-f-increment (list 0 0)])  ; Will add to offset at end
        ; With the flags, figure the width and height of new grid
        (when left-side-flag
          (set! u-new-width (+ u-new-width 1))
          (set! u-new-f-increment (list (+ (first u-new-f-increment) 1) (second u-new-f-increment))))  ; also adjust offset
        (when right-side-flag
          (set! u-new-width (+ u-new-width 1)))
        (when top-side-flag
          (set! u-new-hgt (+ u-new-hgt 1))
          (set! u-new-f-increment (list (first u-new-f-increment) (+ (second u-new-f-increment) 1))))
        (when bot-side-flag
          (set! u-new-hgt (+ u-new-hgt 1)))
        (let ([u-new-g (grid-create u-new-width u-new-hgt)])
          (grid-copy g-new u-new-g u-new-f-increment)  ; copy changes inside grid, with increment offset
          (when left-side-flag
            (grid-copy-col left-side g-new (list 1 0)))
          (when right-side-flag
            (grid-copy-col right-side g-new (list 1 num-cols)))
          (when top-side-flag
            (grid-copy top-side g-new (list 0 1)))
          (when bot-side-flag
            (grid-copy bot-side g-new (list 0 1)))
          (universe u-new-g (list (+ (first u-new-f-increment) (first f-old))
                                  (+ (second u-new-f-increment (second f-old))))))))))

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


(define (universe-set-resize! grid offset x y value)
  '())



(provide universe
         universe?
         universe-grid
         universe-offset
         universe-set!)






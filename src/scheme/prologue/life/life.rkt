#! /usr/bin/env racket
#lang racket
;; Conway's Game of Life

;; Run from the command line
(require racket/cmdline)

; Basic calling under Linux
;   ./life.rkt -s 5 blinker.init
; This runs five generations of the game specified in the initial file, storing the output in five files
; blinker000.life .. blinker004.life
;
; = Code Details =
;
; Making a life simulation is easy, if you ignore that the non-dead grid can grow from one generation to another.
; This code allows for growth.  At each step it checks if any cells surrounding the current grid come alive.  If so,
; it adds a line of surrounding cells.  At the end it goes back and adjusts the sequence of grids to all be the same
; size.
;
; To do the adjustment, a _universe_ consists of a grid and a pair offset.   The offset keeps track of whether
; extra cells were added on the top, bottom, left, or right of the current grid, and accumulates over the
; list of universe generations.
;
; = History =
; 2024-Aug-01 Jim Hefferon CC-BY-SA 4.0  Written


;; ===========================
;; Characters 
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

(define (grid? g)
  (if (not (vector? g))
      #f
      (let ([flag #t])
        (for ([i g])
          (when (not (vector? i))
            (set! flag #f)))
        flag)))

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
                               "y" y
                               "size" size))))

;; Decide if two grids are equal
(define (grid-equal? g0 g1)
  (cond
    [(not (and (grid? g0)
               (grid? g1))) #f]
    [(not (equal? (grid-size g0)
                  (grid-size g1))) #f]
    [else (let* ([s (grid-size g0)]
                 [num-rows (first s)]
                 [num-cols (second s)]
                 [flag #t])
            (for* ([r (in-range num-rows)]
                   [c (in-range num-cols)])
              (when (not (equal? (grid-get g0 r c)
                                 (grid-get g1 r c)))
                (set! flag #f)))
            flag)]))

;; Copy contents of grid from src to dest, where (0,0) in src is at upper-left in dest
(define (grid-copy g-src g-dest upper-left [verbose #f])
  (when verbose
    (displayln (~a "Entering grid-copy g-src=" (grid->string g-src)
                   "\n g-dest=" (grid->string g-dest)
                   "\n upper-left" upper-left)))
  (let* ([g-src-size (grid-size g-src)]
         [g-src-numrows (first g-src-size)]
         [g-src-numcols (second g-src-size)]
         [g-dest-size (grid-size g-dest)]
         [uleft-row (car upper-left)]
         [uleft-col (second upper-left)])
    (for* ([row (in-range g-src-numrows)]
           [col (in-range g-src-numcols)])
      (when verbose
        (displayln (~a "  setting g-dest's r=" (+ row uleft-row)
                       ", c=" (+ col uleft-col)
                       " to " (grid-get g-src row col))))
      (grid-set! g-dest
                 (+ row uleft-row)
                 (+ col uleft-col)
                 (grid-get g-src row col)))))

;; Copy a row vector src to the destination gric dest, starting at (row,col)
(define (grid-copy-row src dest start)
  ; (displayln (~a "entering grid-copy-row src=" src "\ndest=" (grid->string dest) "\n start=" start))
  (let* ([start-row (first start)]
         [start-col (second start)])
    (for ([col (in-range (vector-length src))])
      (grid-set! dest
                 start-row
                 (+ col start-col)
                 (vector-ref src col)))))

;; Copy a column vector src to the grid destination dest, starting at (row,col)
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
         grid?
         grid-size
         grid-get
         grid->string
         grid-display
         grid-equal?
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

;; Test cells bordering the grid
;; Return four vectors the left, right, top, and bottom cells (corner cells can't turn on)
(define (outside-cells g)
  (let* ([size-pair (grid-size g)]
         [num-rows (first size-pair)]
         [num-cols (second size-pair)]
         [v-left (make-vector num-rows)]
         [v-right (make-vector num-rows)]
         [v-top (make-vector num-cols)]
         [v-bot (make-vector num-cols)])
         (for ([row (in-range num-rows)])
           (vector-set! v-left row
                        (cell-next-gen DEAD
                                       (grid-neighbor-vals-get g (list row -1))))
           ; (displayln (~a "    in outside-cells v-left grid-neighbor-vals-get=" (grid-neighbor-vals-get g (list row -1)) ))
           (vector-set! v-right row
                        (cell-next-gen DEAD
                                       (grid-neighbor-vals-get g (list row num-cols)))))
         (for ([col (in-range num-cols)])
           (vector-set! v-top col
                        (cell-next-gen DEAD
                                       (grid-neighbor-vals-get g (list -1 col))))
           (vector-set! v-bot col
                        (cell-next-gen DEAD
                                       (grid-neighbor-vals-get g (list num-rows col)))))
  (list v-left v-right v-top v-bot)))

;; Look for alive cells in a vector
(define (any-alive-cells? v)
  ; (display (~a "entering any-alive-cells?"))
  (let ([flag #f])
    (for ([c v]
          #:break flag)
      ; (displayln (~a "\n  cell=" c " flag=" flag))
      (when (not (equal? c DEAD))
        (set! flag #t)))
    flag))


(provide cell-next-gen
         grid-generation
         outside-cells
         any-alive-cells?
         )


;; ==========================================
;; Universe
;;  grid of cells  vector of vectors of 1's and 0's
;;  offset   universe-offset giving how far (x,y) from this universe's uppper left to upper left of starting uni
(struct universe (grid offset) #:transparent)

(define (universe->string u)
  (let* ([g (universe-grid u)]
         [oset (universe-offset u)]
         [s ""])
    (~a "grid:\n" (grid->string g) "\noffset: (" (first oset) ", " (second oset) ")")))

;; Decide if the universes are equal
(define (universe-equal? u0 u1)
;  (displayln (~a "entering universe-equal? u0=" (universe->string u0) "\n u1=" (universe->string u1)))
;  (displayln (~a (or (not (universe? u0)
;             (not (universe? u1))))))
;  (displayln "entering cond")
  (cond [(or (not (universe? u0))
             (not (universe? u1))) #f]
        [(not (equal? (universe-offset u0)
                      (universe-offset u1))) #f]
;        [else "kkk"]))
        [else (grid-equal? (universe-grid u0)
                           (universe-grid u1))]))

; Have the universe evolve for one generation
(define (universe-generation u [verbose #f])
  (when verbose
    (displayln (~a "\n ... entering universe-generation ...\n   u=" (universe->string u))))
  (let* ([g-old (universe-grid u)]
         [size (grid-size g-old)]
         [num-rows (first size)]
         [num-cols (second size)]
         [f-old (universe-offset u)]
         [g-new (grid-generation g-old)])
    (when verbose 
      (displayln (~a "  universe-generation: g-new=" (grid->string g-new) "\n")))
    ; Any cells come alive outside the starting grid?
    (let* ([out-cells (outside-cells g-old)]
           [left-side (first out-cells)]
           [right-side (second out-cells)]
           [top-side (third out-cells)]
           [bot-side (fourth out-cells)]
           [left-side-flag (any-alive-cells? left-side)]
           [right-side-flag (any-alive-cells? right-side)]
           [top-side-flag (any-alive-cells? top-side)]
           [bot-side-flag (any-alive-cells? bot-side)]
           [u-new-width num-cols]  ; Will be width of output universe's grid
           [u-new-hgt num-rows]
           [u-new-f-increment (list 0 0)])  ; Will add to offset at end
      ; Figure the width and height of new grid
      (when left-side-flag
        (when verbose 
          (displayln (~a "    left-side-flag: left-side=" left-side "\n")))
        (set! u-new-width (+ u-new-width 1))
        (set! u-new-f-increment (list (first u-new-f-increment) (add1 (second u-new-f-increment)))))  ; also adjust offset
      (when right-side-flag
        (when verbose 
          (displayln (~a "    right-side-flag: right-side=" right-side "\n")))
        (set! u-new-width (+ u-new-width 1)))
      (when top-side-flag
        (when verbose 
          (displayln (~a "    top-side-flag: top-side=" top-side "\n")))
        (set! u-new-hgt (+ u-new-hgt 1))
        (set! u-new-f-increment (list (add1 (first u-new-f-increment)) (second u-new-f-increment))))
      (when bot-side-flag
        (when verbose 
          (displayln (~a "    bot-side-flag: bot-side=" bot-side "\n")))
        (set! u-new-hgt (+ u-new-hgt 1)))
      ; Make output grid
      (when verbose
        (displayln (~a "  figuring new width and hgt: u-new-width=" u-new-width " u-new-hgt=" u-new-hgt)))
      (let ([u-new-g (grid-create u-new-hgt u-new-width)])
        (when verbose
          (displayln (~a "  universe-generation: about to copy the new grid to the new universe's grid"
                         "\n   g-new=" (grid->string g-new)
                         "\n   u-new-g=" (grid->string u-new-g)
                         "\n   u-new-f-increment=" u-new-f-increment)))
        (grid-copy g-new u-new-g u-new-f-increment verbose)  ; copy changes inside grid, with increment offset
        (when verbose 
          (displayln (~a "  .. done copying")))
        (when left-side-flag
          (if top-side-flag
              (grid-copy-col left-side u-new-g (list 1 0))
              (grid-copy-col left-side u-new-g (list 0 0))))
        ;(displayln (~a "  .. done left-side"))
        (when right-side-flag
          (if top-side-flag
              (grid-copy-col right-side u-new-g (list 1 (sub1 u-new-width)))
              (grid-copy-col right-side u-new-g (list 0 (sub1 u-new-width)))))
        ;(displayln (~a "  .. done right-side"))
        (when top-side-flag
          (if left-side-flag
              (grid-copy-row top-side u-new-g (list 0 1))
              (grid-copy-row top-side u-new-g (list 0 0))))
        ;(displayln (~a "  .. done top-side"))
        (when bot-side-flag
          ; (displayln (~a "  bot-side-flag=" bot-side-flag " bot-side is " bot-side))
          (if left-side-flag
              (grid-copy-row bot-side u-new-g (list (sub1 u-new-hgt) 1))
              (grid-copy-row bot-side u-new-g (list (sub1 u-new-hgt) 0)))
          ; (displayln (~a "  .. done bot-side"))
          )
        ; Return the new universe
        (universe u-new-g (list (+ (first u-new-f-increment) (first f-old))
                                (+ (second u-new-f-increment) (second f-old)))))
          )))

(provide universe
         universe?
         universe-grid
         universe-offset
         universe->string
         universe-equal?
         universe-generation)


;; ===== Parse
; Input file has a number of lines of the form "periods and stars then \n"


; string of '.'s and *'s -> vector of 0's and 1's
; Turn the string into its internal representation
(define (parse-line s)
  (for/list ([ch (in-string s)]
             #:unless (char=? ch #\newline))
    (if (eqv? ch ALIVE-CH)
        ALIVE
        DEAD)))
; Comments start a line with the # character
(define COMMENT-LINE-REGEXP #px"^\\s*#")

; list of strings -> list of list of values
(define (parse-lines line-lst)
  (for/list ([line line-lst]
             #:unless (regexp-match COMMENT-LINE-REGEXP line))
      (parse-line line)))

;; list of lists -> natural number
;; Return length of longest constituient lists
(define (longest-list list-of-lists)
  (if (null? list-of-lists)
      0
      (max (length (first list-of-lists))
           (longest-list (rest list-of-lists)))))

;; list of lines -> grid
;; Parse the list of input files lines and return the grid
(define (parse-lines-to-grid line-lst)
  (when (empty? line-lst)
    (error "No non-comment lines in the input file"))
  (let* ([parsed-list (parse-lines line-lst)]
         [num-rows (length parsed-list)]
         [num-cols (longest-list parsed-list)]  ; The longest of the input lines defines the number of cols 
         [g (grid-create num-rows num-cols)])
    (for ([row parsed-list]
          [x (in-range num-rows)])
      (for ([row-col-entry row]
            [y (in-range num-cols)])
        (grid-set! g x y row-col-entry)))
    g))

(provide parse-line
         parse-lines
         parse-lines-to-grid)

;; =============================================
;;  Run a game for a number of steps, return the list of universes
(define (run initial-u steps [verbose #f])
  (when verbose
    (displayln (~a "ENTERING RUN: universe=" (universe->string initial-u)
                   "steps=" steps)))
  (let* ([u initial-u]
        [list-of-generations 
         (for/list ([step (in-range steps)])
           (when verbose
             (displayln (~a "\n   === about to run step=" step "\n  universe=" (universe->string initial-u))))
           (set! u (universe-generation u verbose))
           (when verbose
             (displayln (~a "\n  === just ran step=" step "\n  universe=" (universe->string u) "\n")))
           u
           )])
    (cons initial-u list-of-generations))  ;; initial-u is first on list
  )

(provide run)

;; =============================================
;; list of universes -> list of grids
;;  Adjust the list of universes so all have the same size, return list of grids
(define (adjust list-of-universes [verbose #t])  
  ; (displayln (~a "Enter adjust"))
  (let* ([reversed-list (reverse list-of-universes)]  ; Where u_i=(grid_i,offset_i) want to apply offset_i to grid_{i-1}
         [ending-universe (first reversed-list)]  ; grids monotomicaly grow so this is the size all will be adjusted to
         [size (grid-size (universe-grid ending-universe))] 
         [num-rows (first size)]
         [num-cols (second size)]
         [offsets (for/list ([u reversed-list])  ; get list containing the offsets to apply 
                    (universe-offset u))]
         [all-but-one-list  (for/list ([u (cdr reversed-list)] ; Get list containing all but the last grid
                                       [oset offsets])
                              ; (displayln (~a "    u=" (universe->string u)))
                              (let ([g (grid-create num-rows num-cols)])
                                (grid-copy (universe-grid u) g oset)
                                g
                                ))])
    (reverse (cons (universe-grid ending-universe) all-but-one-list)) ; Add on the last grid, then reverse back to orig order
    )
  )

(provide adjust)

;; =============================================
;; print-generations
;; Output the list of same-sized grids to a sequence of files
;;   fn  Input file name.  Format is a sequence of same-length lines, each
;;          composed of `.' for "dead" and `*' for "alive"
;;  output-fn-prefix  String.  The output files will have form -string-xx.life
;;  reps  Natural number.  Number of outputs in the sequence.
;; Output files have this extension so Asymtote knows what to expect
(define OUTPUT-FILE-SUBDIR "life/")
(define OUTPUT-FILE-EXTENSION ".life")

(define (print-generations list-of-generations output-fn-prefix)
  (define (make-output-filename output-filename-prefix dex)
    (~a output-filename-prefix (~r dex #:min-width 3 #:pad-string "0") OUTPUT-FILE-EXTENSION)
    )

  (define (print-generations-helper grid output-fn-prefix dex)
    ; (displayln (~a "print-generations-helper grid=" grid))
    (let ([outfile (open-output-file
                    (make-output-filename output-fn-prefix dex)
                    #:mode 'text #:exists 'replace)])
      (display (grid->string grid) outfile)
      (close-output-port outfile)))
  
  ; (displayln (~a "print-generations list-of-generations=" list-of-generations))
  (for ([g list-of-generations]
        [dex (in-range (length list-of-generations))])
    ; (displayln (~a "g=" g "  dex=" dex))
    (print-generations-helper g output-fn-prefix dex)))



;; =============================================
;;  Run from the command line

; Define the command line parameters
(define verbose? (make-parameter #f))  
(define input-filename (make-parameter null))
(define output-filename (make-parameter null))
(define steps (make-parameter 1)) ;; number of steps to run

;; This is the Racket construct to execute code from command line but not from an importing module
(module+ main
  ;; Read command line arguments  
  (command-line
   #:usage-help 
   "Simulate Conway's Game of Life."
   "Put the starting rectangular grid in a file, with . for dead and * for alive."
   "Comment character is # at the start of a line."
   #:once-each
   [("-o" "--output-filename") outfile "Prefix of basename of file with output grid (default matches input filename)"
                               (output-filename outfile)]
   [("-s" "--steps") st "Number of generations" (steps (string->number st))]
   [("-v" "--verbose") "Verbose mode" (verbose? #t)]
   ; #:args  () (void))
   #:args (fn) ; expect one command-line argument: <filename>
  (input-filename fn)
  (when (null? (output-filename))  ; default is chosen from input but with .life ending
    (let* ([basename (last (string-split (input-filename) "/"))]
           [prefix-parts (string-split basename ".")])
      (if (null? (cdr prefix-parts))
          (output-filename (car prefix-parts))
          (output-filename (string-join (drop-right prefix-parts 1) ".")))
      ))
  (when (verbose?)
    (displayln (~a "input filename=" (input-filename)
                   "\noutput filename=" (output-filename)
                   "\nsteps=" (steps)
                   "\nverbose=" (verbose?))))
  )
  
  ;; Read the file with the program
  (if (null? (input-filename))
      (error "No input file name given") 
      (let* ([input-lines (string-split (port->string (open-input-file (input-filename)) #:close? #t) "\n")]
             [g (parse-lines-to-grid input-lines)]
             [initial-u (universe g (list 0 0))]
             [list-of-universes (run initial-u (steps) (verbose?))])
        (when (verbose?)
          (for ([u list-of-universes])
            displayln (~a "next universe:\n" (universe->string u))))
        (print-generations (adjust list-of-universes (verbose?)) (output-filename))
        (void)
        ))
  )





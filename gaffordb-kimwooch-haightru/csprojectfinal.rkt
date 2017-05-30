#lang racket
(require gigls/unsafe)
(define world (image-new 1600 400))
(define test (image-new 1600 400))
;;; Procedure:
;;;   turtle-forward-quick!
;;; Parameters:
;;;   turtle, a turtle
;;;   distance, a real number
;;; Purpose:
;;;   Move the turtle forward a bit more quickly than with
;;;   turtle-forward-fast!  To get more speed, we use the current
;;;   color and brush, rather than the turtle's color and brush.
;;; Produces:
;;;   turtle, the same turtle
;;; Preconditions:
;;;   turtle is a valid turtle on a valid image
;;; Postconditions:
;;;   turtle has advanced by distance.  
;;;   If the turtle's brush is down, a line has been drawn from the
;;;     turtle's old position to the turtle's new position.
(define turtle-forward-fast!
  (let ((d2r (/ pi 180)))
    (lambda (turtle distance)
      (let ([col (turtle ':col)]
            [row (turtle ':row)]
            [angle (turtle ':angle)])
        (let ([newcol (+ col (* distance (cos (* d2r angle))))]
              [newrow (+ row (* distance (sin (* d2r angle))))])
          (when (turtle ':pen?)
            (image-draw-line! (turtle ':world)
                              col row
                              newcol newrow))
          (turtle ':set-col! newcol)
          (turtle ':set-row! newrow))
        turtle))))
;;; Procedure:
;;;   sinT!
;;; Parameters:
;;;   turtle, a turtle
;;;   amplitude, a number
;;;   length, a number
;;; Purpose:
;;;  Draw a single wave of a sin graph with a turtle
;;; Produces:
;;;   nothing, called for side-effects
(define sinT!
  (lambda (turtle amplitude length)
    (let ([turtle-pos!
           (lambda ()
             (turtle-forward-fast! turtle length)
             (turtle-turn! turtle (remainder amplitude 180)))]
          [turtle-neg!
           (lambda ()
             (turtle-forward-fast! turtle length)
             (turtle-turn! turtle (- (remainder amplitude 180))))])
      (repeat (truncate (/ 180 (increment (remainder amplitude 180))))  turtle-pos!)
      (repeat (truncate (/ 180 (increment (remainder amplitude 180)))) turtle-neg!))))

;;; Procedure:
;;;   turtleSin!
;;; Parameters:
;;;   turtle, a turtle
;;;   amplitude, a number
;;;   length, a number
;;;   waves, an integer
;;; Purpose:
;;;  Draw a waves waves of a sin graph of amplitude amplitude and length length.
;;; Produces:
;;;   nothing, called for side-effects
(define turtleSin! 
  (lambda (turtle amplitude length waves)
    (cond [(> waves 0)
           (sinT! turtle amplitude length)
           (turtleSin! turtle amplitude length (- waves 1))])))

;(define turtleDraw!
;  (lambda
;      (world topleft_coord bottomright_coord center_coord n numLines) ;coords are pair (x . y) values
;    (let* ([turtle_list (make-list numLines (turtle-new world))]
;           [randomish_help (map + (map turtle-row turtle_list)(map turtle-col turtle_list))]
;           [turtle_list2 (if (not (= 0 (modulo numLines 2)))
;                                (map turtle-face! ;odd numlines
;                                     (map turtle-teleport! turtle_list 
;                                          (map + (make-list numLines (car center_coord)) ;xcoord
;                                               (map * (make-list numLines (/ (- (car topleft_coord) (car bottomright_coord)) numLines)) 
;                                                    (map - (iota numLines) (make-list numLines (floor (/ numLines 2))))))
;                                          (make-list numLines (car topleft_coord))) ;y-coord 
;                                     (make-list numLines 0)) ;face this angle 
;                                (map turtle-face! ;even numlines
;                                     (map turtle-teleport! turtle_list 
;                                          (make-list numLines (cdr topleft_coord))
;                                          (map + (make-list numLines (cdr center_coord)) ;x-coord
;                                               (map * (make-list numLines (/ (- (cdr bottomright_coord) (cdr topleft_coord)) numLines)) 
;                                                    (map - (iota numLines) (make-list numLines (+ .5 (floor (/ numLines 2))))))));y-coord
;                                     (make-list numLines -90)))]) ;face this angle)]);fix this
;           (let* ([randomish_help (map truncate (map + (map turtle-row turtle_list2)(map turtle-col turtle_list2)))])
;             ;(for-each turtleSin! turtle_list2 (map modulo randomish_help (make-list numLines 7)) (map modulo randomish_help (make-list numLines 11)) (map modulo randomish_help (make-list numLines 20)))
;             (display (map modulo randomish_help (make-list numLines 7)))(display (newline))(display (map modulo randomish_help (make-list numLines 11)))(display (newline))(display (map modulo randomish_help (make-list numLines 20)))
;             (display (map cons (map turtle-col turtle_list2)(map turtle-row turtle_list2)))))))

;(- (car topleft_coord) (car bottomright_coord));a
;(- (cdr topleft_coord) (cdr bottomright_coord));a asfdsadfsafd   
;(define world (image-new 600 400))
;(define tommy (turtle-new world))
;(define heartbeat!
;  (lambda (turtle repeatNum amplitude length)
;    
;    (let ([turtleheap! (lambda ()
;                         ;; pos heap
;                         (turtle-turn! turtle (-(truncate (* (atan (/ amplitude length)) (/ 180 pi)))))
;                         (turtle-forward-fast! turtle (sqrt(+ (* amplitude amplitude)(* length length))))
;                         (turtle-turn! turtle (-(* 2(- 180 (truncate (* (atan (/ amplitude length)) (/ 180 pi)))))))
;                         (turtle-forward-fast! turtle (sqrt(+ (* amplitude amplitude)(* length length))))
;                         (turtle-turn! turtle (- 360(truncate (* (atan (/ amplitude length)) (/ 180 pi)))))
;                         ;;negative heap    
;                         (turtle-turn! turtle (truncate (* (atan (/ amplitude length)) (/ 180 pi))))
;                         (turtle-forward-fast! turtle (sqrt(+ (* amplitude amplitude)(* length length))))
;                         (turtle-turn! turtle (* 2(- 180 (truncate (* (atan (/ amplitude length)) (/ 180 pi))))))
;                         (turtle-forward-fast! turtle (sqrt(+ (* amplitude amplitude)(* length length))))
;                         (turtle-turn! turtle (truncate (* (atan (/ amplitude length)) (/ 180 pi))))
;                         )])
;      (turtle-forward-fast! turtle (* length 2))
;      (repeat repeatNum turtleheap!)
;      (turtle-forward-fast! turtle length)
;      )))
;;; Procedure:
;;;   turtleDraw!
;;; Parameters:
;;;   turtle, a turtle
;;;   color, a color
;;;   brush, a brush type
;;;   topleft_coord, a pair
;;;   bottomright_coord, a pair
;;;   center_coord, a pair
;;;   randomizer, an integer
;;;   numLines, an integer
;;; Purpose:
;;;  Draw numLines with turtles, of color color, with brush brush type in a pseudorandom pattern with different amplitudes, lengths, directionalities
;;; Produces:
;;;   nothing, called for side-effects
(define turtleDraw!
  (lambda (turtle color brush topleft_coord bottomright_coord center_coord randomizer numLines)
    (let* ([turtlecop (turtle-clone turtle)]
           [randomish_value (abs (* 19 randomizer))]
           [image_height (- (car bottomright_coord) (car topleft_coord))]
           [image_width (- (cdr bottomright_coord) (cdr topleft_coord))]
           [numWaves (increment (modulo randomish_value 14))])
      (turtle-set-color! turtle color)
      (turtle-set-brush! turtle brush)
      (cond [(= numLines 0) (display "Done")]
            [(= 0 (modulo numLines 2)) ;go horizontally
             (turtle-face! turtle -90)
             (turtle-teleport! turtle
                               (cdr topleft_coord) ;x-val
                               (+ (modulo randomish_value 175) (/ image_height 2))) ;y-val
             ;(display "LINE INFO: turtleSin! turtle, ") (display (modulo randomish_value 50)) (display ", ")(display (/ image_width numWaves))(display ", ")(display numWaves)(display (newline))
             ;(display "TURTLE INFO: ") (display (turtle-row turtle)) (display " by ") (display (turtle-col turtle)) (display (newline))
             ;(if (= (modulo randomish_value 2) 0)******************
                 (turtleSin! turtle (modulo randomish_value 25) (/ image_width numWaves) numWaves)
              ;   (heartbeat! turtle numWaves (modulo randomish_value 25) image_width))***********************
             ;
             ;(display randomish_value)(display (newline))
             ;(display (+ (modulo randomish_value 175) (/ image_height 2)))(display (newline))
             (turtleDraw! turtlecop color brush topleft_coord bottomright_coord center_coord (increment randomizer) (- numLines 1))]
            [else ;go vertically
             (turtle-face! turtle 0)
             (turtle-teleport! turtle
                               (+ (modulo randomizer 275) (/ image_width 2)) ;x-val, randomish
                               (car topleft_coord)) ;y-val, top of bounds
             ;(if (= (modulo randomish_value 2) 0)**************
                 (turtleSin! turtle (modulo randomish_value 25) (/ image_height numWaves) numWaves)
                 ;(heartbeat! turtle numWaves (modulo randomish_value 25) image_height))*******************
             (turtleDraw! turtlecop color brush topleft_coord bottomright_coord center_coord (increment randomizer) (- numLines 1))]))))
;;; Procedure:
;;;   image-series
;;; Parameters:
;;;   n, an integer
;;;   width, an integer
;;;   height, an integer
;;; Purpose:
;;;  Creates 1000 unique images of size width * height, based off of a given n value
;;; Produces:
;;;   result, an image
;;; Preconditions:
;;;  n>0, width>0, height>0
;;; Postconditions:
;;;  result is a unique image of size width*height, based off of a given n value

(define image-series
  (lambda (n width height)
    (let* ([image (image-compute background-display width height)]
           [coord_list (list (list 0 0 (/ width 2) (/ height 2)) ;quad1, car
                         (list (/ width 2) 0 width (/ height 2)) ;quad2, cadr
                         (list 0 (/ height 2) (/ width 2) height) ;quad3, caddr
                         (list (/ width 2) (/ height 2) width height))]) ;quad4, cadddr
      ;(image-compute background-display (/ width 2) (/ height 2))
      (fill-quadrant n 1 image)
      (fill-quadrant n 2 image)
      (fill-quadrant n 3 image)
      (fill-quadrant n 4 image)
      image )))
;;; Procedure:
;;;   fillQuadrant!
;;; Parameters:
;;;   n, an integer
;;;   quadrant, an integer
;;;   image, an image
;;; Purpose:
;;;  Draw using turtles and gimp-tools to create distinct patterns from each quadrant
;;; Produces:
;;;   nothing, called for side-effects
(define fill-quadrant
  (lambda
      (n quadrant image); shape color-pallate gradType lineInfo)
    (let* ([width (image-width image)]
           [height (image-height image)]
           [coord_list (list (list 0 0 (/ width 2) (/ height 2)) ;quad1, car
                         (list (/ width 2) 0 width (/ height 2)) ;quad2, cadr
                         (list 0 (/ height 2) (/ width 2) height) ;quad3, caddr
                         (list (/ width 2) (/ height 2) width height))] ;quad4, cadddr
           [box_coords (list-ref coord_list (- quadrant 1))]
           [image_center (add-pairs (cons (car box_coords) (cadr box_coords))(cons (/ (- (caddr box_coords) (car box_coords)) 2) (/ (- (cadddr box_coords) (cadr box_coords)) 2)))]
           [numLines (remainder (* 17 n quadrant) 10)]
           [turtle (turtle-new image)]
           [turtlecop (turtle-clone turtle)]
           [turtle-color (list-ref colorList (modulo (+ 17 n quadrant) 6))]
           [brush (list-ref (context-list-brushes) (modulo (+ 17 n quadrant) (length (context-list-brushes))))]
           [numsides (+ 3 (modulo (* 17 n quadrant) 7))]
           [side-length (modulo (* 17 n quadrant) 50)]
           [shape-color (list-ref colorList (modulo (* 9 n quadrant) 6))])
      (context-set-brush! brush)
      (context-set-fgcolor! turtle-color)
      (turtle-set-color! turtle turtle-color)
      (turtleDraw! turtlecop turtle-color brush
                   (cons (car box_coords) (cadr box_coords)) 
                   (cons (caddr box_coords) (cadddr box_coords))
                   image_center
                   n
                   numLines)
   ;   (display shape-color)
      (polygon-anywhere (car image_center) (cdr image_center) numsides side-length image shape-color)
      )))
;(display "N val: ") (display n) (display (newline))
;      (display "numlines: ")(display numLines)(display (newline))
;      (display "turtle-color: ")(display turtle-color)(display (newline))
 ;     (display "brush: ")(display brush)(display (newline))
 ;     (display "numsides: ")(display numsides)(display (newline))
 ;     (display "side-length: ")(display side-length)(display (newline))
  ;    (display "shape-color: ")(display shape-color)(display (newline))(display (newline))
;;; Procedure:
;;;   add-pairs
;;; Parameters:
;;; pair1, a pair
;;; pair2, a pair
;;; Purpose:
;;;  Add each element of 2 pairs together and return the new pair value
;;; Produces:
;;;   result, a pair
(define add-pairs
  (lambda (pair1 pair2)
    (cons (+ (car pair1) (car pair2)) (+ (cdr pair1) (cdr pair2)))))


(define colorList (map color-name->irgb (list "red" "orange" "yellow" "green" "blue" "violet")))
;(define shapeList (list 'circle 'ellipse1 'ellipse2 'square 'rect1 'rect2 'triangle 'pentagon 'hexagon 'septagon 'octagon))
;(define gradList (list 'left-right 'right-left 'up-down 'down-up))
;(define coord_list (list               ;coords for quadrants, car is coord of top-left point of box, cadr is coord of bottom-right point of box
;                    '((0 . 0) . ((/ image_width 2) . (/ image_height 2))) ;quad1
;                         '(((/ image_width 2) . 0) . (image_width . (/ image_height 2))) ;quad2
;                         '((0 . (/ image_height 2)) . ((/ image_width 2) . image_height)) ;quad3
;                         '(((/ image_width 2) . (/ image_height 2)) . (image_width . image_height)))) ;quad4

;(define coord_list (list               ;coords for quadrants, car is coord of top-left point of box, cadr is coord of bottom-right point of box
;                    (cons (cons 0 0) (cons 300 200)) ;quad1
;                         '((300 . 0) . (600 . 200)) ;quad2
;                         '((0 . 200) . (300 . 400)) ;quad3
;                         '((300 . 200) . (600 . 400)))) ;quad4
;(define coord_list (list (list 0 0 300 200) ;quad1, car
                       ;  (list 300 0 600 200) ;quad2, cadr
                        ; (list 0 200 300 400) ;quad3, caddr
                        ; (list 300 200 600 400))) ;quad4, cadddr
;;; Procedure:
;;;   log-new
;;; Parameters:
;;;   [None]
;;; Purpose:
;;;   Create a new log of values.
;;; Produces:
;;;   log, a log
;;; Preconditions:
;;;   [No additional]
;;; Postconditions:
;;;   We can apply log-add! and log-get to log.
(define log-new
  (lambda ()
    (vector null)))

;;; Procedure:
;;;   log-add!
;;; Parameters:
;;;   log, a log
;;;   val, a value
;;; Purpose:
;;;   Adds val to the log
;;; Produces:
;;;   [Nothing; called for the side effects]
;;; Preconditions:
;;;   (log-get log) is a value that we will call old-contents
;;; Postconditions:
;;;    We have added val to the end of the log.  That is,
;;;     (log-get log) = (append old-contents (list val))  
(define log-add!
  (lambda (log val)
    (vector-set! log 0 (cons val (vector-ref log 0)))))

;;; Procedure:
;;;   log-get
;;; Parameters:
;;;   log, a log
;;; Purpose:
;;;   Get the list of values added to the log
;;; Produces:
;;;   values, a list
;;; Preconditions:
;;;   [No additional]
;;; Postconditions:
;;;   values contains all of the values added by log-add!,
;;;   in the same order.
(define log-get
  (lambda (log)
    (reverse (vector-ref log 0))))

;;; Procedure:
;;;   turtle-select-polygon!
;;; Parameters:
;;;   turtle, a turtle
;;;   sides, a positive integer
;;;   side-length, a positive real number
;;;   operation, one of ADD, SUBTRACT, REPLACE, INTERSECT
;;; Purpose:
;;;   Selects a polygon using a turtle.  If the turtle is
;;;   up, also draws the polygon.
;;; Produces:
;;;   [Nothing; called for the side effect]
;;; Point:
;;;   Partially intended as an illustration of how to select
;;;   parts of an image using turtles.
(define turtle-select-polygon!
  (lambda (turtle sides side-length operation)
    (let ([points (log-new)]
          [angle (/ 360 sides)])
      ; Build the list of points
      (let kernel! ([side 0])
        (when (< side sides)
          (turtle-forward! turtle side-length)
          (turtle-turn! turtle angle)
          (log-add! points (turtle-point turtle))
          (kernel! (+ side 1))))
      ; Select!
      (image-select-polygon! (turtle-world turtle)
                             operation
                             (log-get points)))))


;;;Procedure
;;;Polygon-anywhere
;;;Parameters
;;; x a real number
;;; y a real number
;;; sides a real number
;;; side-length a real number
;;; image, an image
;;; color, a color
;;; Purpose
;;; Draw a polygon anywhere on a given image
;;;Produces
;;; None, called for side-effect
;;; Preconditions
;;; [no additional]
;;; Postconditions
;;; Center of the pologon can be anywhere on the canvas, but the entire polygon need not be shown on the canvas.  

(define polygon-anywhere
  (lambda (x y sides side-length image color)
    (let ([tommy (turtle-new image)])
     (turtle-set-color! tommy color)
    (turtle-teleport! tommy x y)
    (turtle-select-polygon! tommy sides side-length REPLACE)
      (image-select-nothing! image))))
;;; Procedure:
;;;   background-display
;;; Parameters:
;;;   col, a number
;;;   row, a number 
;;; Purpose:
;;;  Draw the four different backgrounds of the image
;;; Produces:
;;;   a color
;;;NOTES: Used in combination with image-compute, works best with a 600 * 400 image
(define background-display
 (lambda (col row)   
   (cond[(and (<= col 300) (<= row 200))
   (irgb 255 
            (* 0.8 (- 255 col)) (* 0.8 (- 255 col)))]
   [(and (and (<= col 300) (>= row 200)) (<= (+ (square ( - col 150)) (square (- row 180))) (square 200))) 
    (irgb  (* 0.8 (- 255 col)) 0 255)]
   [(and (>= col 300) (>= row 200))
    (irgb ( * 0.8 (- (- col 300) 200 )) ( * 0.8 (- 255 (- row 300))) 255) ]

    [(and (>= col 300) (<= row 200))
    (irgb (* 120 (+ 1 (sin (* pi 0.03 (- col 300))))) (* 120 (+ 1 (cos (* pi 0.03 (- col 300))))) 255)]
    
   [else         
   (irgb 120 150 255)]
   )))



    
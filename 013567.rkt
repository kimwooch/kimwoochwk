#lang racket
(require gigls/unsafe)
(require rackunit)
(require rackunit/text-ui)

;;; File:
;;;   exam2.rkt
;;; Authors:
;;;   The student currently referred to as 000000
;;;   Charlie Curtsinger
;;;   Titus Klinge
;;; Contents:
;;;   Code and solutions for Exam 2 2016F
;;; Citations:
;;;

; +---------+--------------------------------------------------------
; | Grading |
; +---------+

; This section is for the grader's use.

; Problem 1: 
; Problem 2:
; Problem 3:
; Problem 4:
; Problem 5:
; Problem 6:
;           ----
;     Total:

;    Scaled:
;    Errors:
;     Times:
;          :
;          :
;          :
;           ----
;     Total:

; +-----------+------------------------------------------------------
; | Problem 1 |
; +-----------+

; Time Spent: 40 minutes

; Citations:http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/boolean-reading.html
;http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/reference/a-z.html
; Solution:

;;; Procedure:
;;;   in-bounds?
;;; Parameters:
;;;   drawing, a drawing, 
;;;   left, a real number,
;;;    top, a real number,
;;;    right, a real number,
;;;    bottom, a real number
;;; Purpose:
;;;   checks if a drawing is contained by the rectangular area defined by the coordinates of left, top, right, and bottom.
;;; Produces:
;;;   a value, boolean value
;;; Preconditions:
;;;   [no additional]
;;; Postconditions:
;;;  if left most point of the drawing has greater value than the value of the left coordinate of the rectangular area
;;; and the top most point of the drawing has greater value than the value of the top coordinate of the rectangular area 
;;; and the right most point of the drawing has lesser value than the value of the right coordinate of the rectangular area
;;; and the bottom most point of the drawing has lesser value than the value of the bottom coordinate of the rectangular area
;;; return true else false.
(define in-bounds? 
  (lambda (drawing left top right bottom)
    (if (positive? (- (drawing-left drawing) left))
        (if (positive? (- (drawing-top drawing) top))
            (if (negative? (- (drawing-right drawing) right))
                (if (negative? (- (drawing-bottom drawing) bottom))
                    #t #f) #f) #f) #f)))
;;examples
;;> (in-bounds? drawing-unit-circle -1 -1 1 1) 
;;#t
;;> (in-bouds? drawing-unit-circle -1 0 1 1 )
;;#f
;;> (in-bounds? (vshift-drawing3 drawing-unit-square) -0.5 2.5 0.5 3.5)
;;#t

; +-----------+------------------------------------------------------
; | Problem 2 |
; +-----------+

; Time Spent: 1 hour

; Citations:
;http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/rackunit-rgb-reading.html
; Examples/Tests:
(define in-bounds-tests
  (test-suite
   "Tests of in-bounds"
   (test-case 
    "unit circle with its at center 0 0 is contained in a rectangle area"
    (check-equal? (in-bounds? drawing-unit-circle -0.6 -0.6 1 1) true 0))
   (test-case
    "unit circle shifted horizontally 3 units is contained in a rectangle area"
    (check-equal? (in-bounds? (hshift-drawing 3 drawing-unit-circle) 2 -1 4 1) true 0)
   (test-case
    "unit circle shifted vertically 3 units is contained a rectangle area"
    (check-equal? (in-bounds? (vshift-drawing 3 drawing-unit-circle) -1 2 1 4) true 0))
   (test-case
    "unit circle that is in the negative quadrants (x, y coordinates of the circle is negative)")
   (check-equal? (in-bounds? (vshift-drawing -3 (hshift-drawing -3 drawing-unit-circle)) -4 -4 -2 -2) true 0)
   (test-case
    "unit circle that is bigger than the rectangle area"
    (check-equal? (in-bounds? (vscale-drawing 3 (hscale-drawing 3 drawing-unit-circle)) -1 -1 1 1) false 0))
   (test-case
    "unit square that is inside the rectangle area in the second quadrant x points are negative and y points are positve"
    (check-equal? (in-bounds? (hshift-drawing -6 (vshift-drawing 3 drawing-unit-square)) -8 2 3 6) true 0))
   (test-case
    "unit circle that is scaled 10 fits inside a rectangle area"
    (check-equal? (in-bounds? (scale-drawing 10 drawing-unit-circle) -5.0 -5.0 10 10) true 0))
   (test-case 
    "unit square that is shifted 3 in vertical direction"
    (check-equal? (in-bounds? (vshift-drawing 3 drawing-unit-square) -0.5 2.5 0.5 3.5) true 0))
   )))

; +-----------+------------------------------------------------------
; | Problem 3 |
; +-----------+

; Time Spent: 3 hours

; Citations: www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/gimp-tools-reading.html
;www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/let-reading.html

; Solution:

;;; Procedure: color
;;;   
;;; Parameters: num, an integer
;;;   
;;; Purpose: to return a string(red, green, or blue)
;;;   
;;; Produces:string, a string
;;;   
;;; Preconditions:[no additional]
;;;   
;;; Postconditions: if num = 0 return "red"
;;; else if num = 1 return "green"
;;; else return "blue"
;;;   
(define color
  (lambda (num)
    (cond [(= num 0)
          "red"]
         [(= num 1)
          "green"]
         [else
          "blue"])))
;;; Procedure: mod3
;;;   
;;; Parameters: num, an integer
;;;   
;;; Purpose: to return a number 0 1 2 repectively
;;;   
;;; Produces: module number, an integer
;;;   
;;; Preconditions:[no additional]
;;;   
;;; Postconditions: if number 0 return 0
;;; if number is 1 return 1
;;; if number is 2 return 2
;;; if number is 3 return 0, etc
;;; 
;;;   
(define mod3
  (lambda (num)
    (modulo num 3)))


;;; Procedure: semicircles-a
;;;   
;;; Parameters:width, an integer 
;;;            height, an integer 
;;;            n, an integer 
;;;            radius, a real number
;;;   
;;; Purpose: produces an image with dimensions width by height that contains n semicircles with radius radius spaced evenly across the width of the image. 
;;;          Semicircles should cycle through colors red, green, and blue. And one on the right should be in the front of the left semicircles.
;;;   
;;; Produces:image, an image
;;;   
;;; Preconditions:
;;;    mod3 must be defined
;;;    color must be defined
;;;   
;;; Postconditions:
;;;  It takes the input of width, height, n, radius which is the width of the image, height of the image, number of semicircles, and radius of each circles
;;;  There is a local variable circle that makes an image of width and height.
;;;  Using GIMP, the program draws an ellipse which starts at 0 which each edge of the circle is distanced by (width - radius) / (number of circles -1 )
;;;   Also, the program subtracts a right half of ellispe by drawing a rectangle which starts at radius and is distanced by ( width- radius) / (number of circles -1 )
;;;   Each images have top margin of 0 and the height is radius * 2 and each circle has radius of radius value. 
;;;   Using the equation (width - radius )/ (n-1) * value which value goes from 0 to number of circles - 1, the function maps each value into the  
;;;   image-select-ellipse! circle to indicate the left position. 
;;;   And the right half of the circle is subtracted by the equation (width - raidus ) / (n -1 ) * value which value goes from 0 to number of circles -1.
;;;   The end last half of the circle is put at where the left point is width - radius with top at 0 and height of 2 radius and width of 2 radius. 
;;;   After creating all these images, the function selects all the images.
(define semicircles-a
  (lambda (width height n radius)
    (let ([ circle (image-new width height)])
      (map 
       (lambda (x)
         (image-select-ellipse! circle REPLACE (* x ( / ( - width radius)(- n 1))) 0 (* radius 2) (* 2 radius))
       (image-select-rectangle! circle SUBTRACT (+ radius (* (/ (- width radius) (- n 1)) x)) 0  (* radius 2) (* 2 radius))
         (context-set-fgcolor! (color (mod3 x)))
         (image-fill-selection! circle) ) (iota (- n 1)))
      (image-select-ellipse! circle REPLACE (- width radius) 0 (* radius 2) (* radius 2))
      (context-set-fgcolor! (color (mod3 (- n 1))))
      (image-fill-selection! circle)
      (image-select-all! circle))))

; Examples/Tests:
;(image-show (semicircles-a 200 100 8 50))
;.
;(image-show (semicircles-a 200 100 3 50))
;.
; +-----------+------------------------------------------------------
; | Problem 4 |
; +-----------+

; Time Spent: 3 hours

; Citations:www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/iterate-positions-reading.html
;           www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/conditionals-readings.html
; Solution:

;;; Procedure:seicircles-b
;;;   
;;; Parameters:width, an integer
;;;            height, an integer
;;;            radius, an integer
;;; Purpose: returns an image with dimensions width by height that contains three semicircles with radius radius spaced evenly across the image.
;;;   
;;; Produces: image, an image
;;;   
;;; Preconditions:
;;;   [no additional]
;;; Postconditions:
;;;    the circles should be in order of red, green, and blue. The circle should have radius of radius.    
;;;    each circles should have radial blends. 
;;;   ex) As the computer goes through each colume and row, col must be less than width /3 and it should be less than the radius it is given. 
;;;       the color will be (irgb 255 (* (col - width/3)^2 + ( row - height/2) a number("to show bigger effect"))(irgb 255 (* (col - width/3)^2 + ( row - height/2) a number("to show bigger effect"))
;;;       The equation(irgb 255 (* (col - width/3)^2 + ( row - height/2) a number("to show bigger effect")) shows that as col and width goes further away from
;;;       the center of the image, the color becomes lighter. 
;;;
;;;
(define semicircles-b
  (lambda (width height radius)
    (image-compute
     (lambda (col row)
       (cond [ (and ( < col (/ width 3)) (<= ( + (square (- col ( / width 3))) (square (- row (/ height 2)))) (square radius)))
               (irgb 255
                     (* ( + (square (- col ( / width 3))) (square (- row (/ height 2)))) 0.056)
                     (* ( + (square (- col ( / width 3))) (square (- row (/ height 2)))) 0.056))]
             [(and ( and (< col (* (/ width 3) 2)) (> col (/ width 3))) (<= ( + (square (- col (* ( / width 3)2))) (square (- row (/ height 2)))) (square radius)))
              (irgb (* ( + (square (- col (* (/ width 3) 2))) (square (- row (/ height 2)))) 0.056)
                    255
                    (* ( + (square (- col (* (/ width 3) 2))) (square (- row (/ height 2)))) 0.056))]
             [(and ( and (< col width) (> col (* (/ width 3)2)))(<= ( + (square (- col width)) (square (- row (/ height 2)))) (square radius)))
              (irgb (* ( + (square (- col width)) (square (- row (/ height 2)))) 0.056)
                    (* ( + (square (- col width)) (square (- row (/ height 2)))) 0.056)
                    255
                    )]
             [else (irgb 255
                         255
                         255
                         )])) width height)))

; Examples/Tests:
;> (image-show (blue2 150 150 50))
;25
;> (image-show (blue2 150 150 75))
;26
;.
;.

; +-----------+------------------------------------------------------
; | Problem 5 |
; +-----------+

; Time Spent: 40 minutes

; Citations:http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/anonymous-procedures-reading.html
;http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/let-reading.html
; Solution:

; Parts a and b: clean up and document the pair procedure below.


;;; Procedure:
;;; list-types
;;; Parameters:
;;; list, a list
;;; Purpose:
;;; Finds the types of each components in a list. 
;;; Produces:
;;; list, a list of strings
;;; Preconditions:
;;; [no additional]
;;; Postconditions:
;;; drawing will return a list of types of the individual components in the list given
;;; if a component in the list = number then return 'number
;;; else if a component in the list = symbol then return 'symbol
;;; else if a component in the list = pair, then return 'pair
;;; else if a compmonent in the list = string, then return 'string
;;; else return 'other. 
;;; return a list of these types.
(define list-types
  (lambda (list)
    (let ([catchTypes ( lambda (types)
                   (cond [(number? types) 'number]
                         [(symbol? types) 'symbol]
                         [(pair? types) 'pair]
                         [(string? types) 'string]
                         [else 'other]))])
    (map catchTypes list))))

; Explain how this code achieves its purpose

;; The function takes a list of values 
;; Inside the function, there is a local variable called catchType,
;; which takes the individual types of each component in the list given
;; Inside, the conditional function, the individual types are compared with 
;; number, symbol, pair, string to return 'number, 'symbol, 'pair, 'string.
;; If they cannot be classified, the function will return 'other.
;; The code maps catchTypes with lists to put individual outputs to a new list. 


; Examples/Tests:
;;> (list-types '(("3" ."5") ("3" ."2") ("df" ."df")))
;;'(pair pair pair)
;;> (list-types '(df df))
;;'(symbol symbol)
;;> (pair '( 23 23 23))
;;'(number number number)


; +-----------+------------------------------------------------------
; | Problem 6 |
; +-----------+

; Time Spent: 1 hour

; Citations:http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/drawings-late-reading.html

; Solution:

;;; Procedure:
;;; diamond-of-circles
;;;   
;;; Parameters:
;;;   num, an integer
;;; Purpose:
;;;   create a num length of the diamond with num number of unit-circles
;;; Produces:
;;;   drawing, a drawing
;;; Preconditions:
;;; num is at least 2 
;;;   
;;; Postconditions:
;;; makes a num number of lists and and shifts individual unit-circles one by one both horizontally and vertically.
;;;   makes a num number of lists of unit-circles and shifts individual unit-circles one by one both horizontally and vertically.
;;; and moves num-1 vertically upward. 
;;;  makes a num number of lists of unit-circles and shifts individual unit-circles one by one both horizontally and vertically.
;;; and moves num-1 to the right horizontally.
;;;  makes a num number of lists of unit-circles and shifts individual unit-circles one by one both horizontally and vertically.
;;; and moves num-1 both vertically and horizontally to the positive side. 
;;; compose the drawings together and group all the drawings together to form one drawing. 
;;; in order to scale it so that leftmost and topmost edges of the compound drawings starts at 0 and 0, respectively,
;;; do both vertical and horizontal shift by the num - 0.5. 
(define diamond-of-circles
 (lambda (num)
   (vshift-drawing (- num 0.5)
       (hshift-drawing (- num 0.5) 
            (drawing-group 
             (drawing-compose  (map hshift-drawing (iota num) (map vshift-drawing (reverse (iota num)) (make-list num drawing-unit-circle))))
             (vshift-drawing (- 1 num) (drawing-compose  (map hshift-drawing (iota num)
       (map vshift-drawing (iota num)
            (make-list num drawing-unit-circle)))))
             (hshift-drawing (- 1 num) (drawing-compose  (map hshift-drawing (iota num)
       (map vshift-drawing (iota num)
            (make-list num drawing-unit-circle)))))
             (hshift-drawing (- 1 num) (vshift-drawing (- 1 num) (drawing-compose (map hshift-drawing (iota num)
      (map vshift-drawing (reverse (iota num))
           (make-list num drawing-unit-circle)))))))))))

; Examples/Tests:
;> (drawing-top (diamond-of-circles 3))
;0.0
;> (image-show (drawing->image (scale-drawing 10 (diamond-of-circles 10)) 200 200))
;5
;;.
;> (image-show
 ;  (drawing->image
  ;            (scale-drawing 10
   ;                          (diamond-of-circles 3)) 200 200))
;.
;> (drawing-left (diamond-of-circles 3))
;0.0
> 


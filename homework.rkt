#lang racket
(require gigls/unsafe)
(require rackunit)
(require rackunit/text-ui)

;; problem 1
(define simple-center-x
  (lambda (drawing)
    (/ (+ (drawing-right drawing) (drawing-left drawing)) 2)))

(define simple-center-y
  (lambda (drawing)
    (/ (+ (drawing-top drawing) (drawing-bottom drawing)) 2)))

;; problem 2
(define simple-center-x-tests
  (test-suite
   "Tests of simple-center-x"
   (test-case
    "Center is at the origin"
    (check-= (simple-center-x drawing-unit-circle) 
             0 0))
   (test-case
   "Center along the x axis"
    (check-= (simple-center-x (hshift-drawing 40 drawing-unit-square))
             40 0))
   (test-case
    "Center along y axis"
    (check-= (simple-center-x (vshift-drawing 50 (scale-drawing 10 drawing-unit-circle))) 
             0 0))
   (test-case
    "Center in quadrant 1"
    (check-= (simple-center-x (vshift-drawing 10 (hshift-drawing 20 drawing-unit-square)))
              20 0))
   (test-case
    "Center in quadrant 2"
    (check-= (simple-center-x (vshift-drawing 1 (hshift-drawing -10 (scale-drawing 3 drawing-unit-circle))))
             -10 0))
   (test-case
    "Center in quadrant 3"
    (check-= (simple-center-x (vshift-drawing -200 (hshift-drawing -64 (hscale-drawing 10 drawing-unit-circle))))
             -64 0))
   (test-case
    "Center in quadrant 4"
    (check-= (simple-center-x (vshift-drawing -30 (hshift-drawing 60 (vscale-drawing 100 drawing-unit-square))))
             60 0))
   (test-case
    "Compound drawing"
    (check-= (simple-center-x (hshift-drawing 10 (drawing-group (scale-drawing 10 drawing-unit-square)
                                                        (vshift-drawing 10 drawing-unit-square))))
             10 0))
   (test-case
    "Test center coordinates that aren't integers"
    (check-= (simple-center-x (hshift-drawing 5.5 drawing-unit-square))
             5.5 0))))
  
(define simple-center-y-tests
  (test-suite
   "Tests of simple-center-y"
   (test-case
    "Center is at the origin"
    (check-= (simple-center-y drawing-unit-circle) 
             0 0))
   (test-case
   "Center along the x axis"
    (check-= (simple-center-y (hshift-drawing 40 drawing-unit-square))
             0 0))
   (test-case
    "Center along y axis"
    (check-= (simple-center-y (vshift-drawing 50 (scale-drawing 10 drawing-unit-circle))) 
             50 0))
   (test-case
    "Center in quadrant 1"
    (check-= (simple-center-y (vshift-drawing 10 (hshift-drawing 20 drawing-unit-square)))
              10 0))
   (test-case
    "Center in quadrant 2"
    (check-= (simple-center-y (vshift-drawing 1 (hshift-drawing -10 (scale-drawing 3 drawing-unit-circle))))
             1 0))
   (test-case
    "Center in quadrant 3"
    (check-= (simple-center-y (vshift-drawing -200 (hshift-drawing -64 (hscale-drawing 10 drawing-unit-circle))))
             -200 0))
   (test-case
    "Center in quadrant 4"
    (check-= (simple-center-y (vshift-drawing -30 (hshift-drawing 60 (vscale-drawing 100 drawing-unit-square))))
             -30 0))
   (test-case
    "Compound drawing"
    (check-= (simple-center-y (hshift-drawing 10 (drawing-group (scale-drawing 10 drawing-unit-square)
                                                                (vshift-drawing 10 drawing-unit-square))))
             2.75 0))
   (test-case
    "Test center coordinates that aren't integers"
    (check-= (simple-center-y (vshift-drawing 5.5 drawing-unit-square))
             5.5 0))))  

;; problem 3
(define circle-xcoord
  (lambda (n)
    (* 36 (cos (* (/ pi 180) (* 10 n))))))

(define circle-ycoord
  (lambda (n)
    (* 36 (sin (* (/ pi 180) (* 10 n))))))

(define circle-of-drawings
  (lambda (drawing)
    (map vshift-drawing
         (map circle-ycoord (iota 36))
         (map hshift-drawing
              (map circle-xcoord (iota 36))
              (make-list 36 drawing)))))

(define c5 (scale-drawing 5 drawing-unit-circle))
; (image-show (drawing->image (hshift-drawing 50 (vshift-drawing 50 (drawing-compose (circle-of-drawings c5)))) 200 200))



;; problem 4!

;; HEY GRADERS!!!!
;; Increase the amount of memory DrRacket can use or else random-disco-square will take more than one minute for big sizes.
;; We used 2048MB for the memory limit.

(define irgb-random
  (lambda (x)
    (irgb (random 256)
          (random 256)
          (random 256))))

(define random-disco-square 
  (lambda (drawing size)
    (map recolor-drawing 
         (map irgb-random (iota size))
         (map hshift-drawing
              (map (section mod <> <>) 
                   (iota size)
                   (make-list size (floor (sqrt size))))
              (map vshift-drawing
                   (map (compose floor (section / <> <>)) 
                        (iota size)
                        (make-list size (sqrt size)))
                   (make-list size drawing))))))

;(image-show (drawing->image (scale-drawing 5 (drawing-compose (random-disco-square drawing-unit-square 1000))) 100 100))
;(image-show (drawing->image (scale-drawing 5 (drawing-compose (random-disco-square drawing-unit-square 10000))) 500 500))
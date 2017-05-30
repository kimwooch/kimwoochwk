#lang racket
(require gigls/unsafe)

;;; File:
;;;   exam3.rkt
;;; Authors:
;;;   The student currently referred to as 000000
;;;   Charlie Curtsinger
;;;   Titus Klinge
;;; Contents:
;;;   Code and solutions for Exam 3 2016F
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

; Time Spent: 30 minutes

; Citations:http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/recursion-basics-reading.html
;http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/list-recursion-revisited-reading.html
;https://docs.racket-lang.org/reference/strings.html
; Solution:

;;; Procedure:safe-average-a
;;;   
;;; Parameters: lst, a list
;;;   
;;; Purpose: computes the average of those numbers when given a list of numbers
;;;   
;;; Produces: result, a number
;;;   
;;; Preconditions: safe-average-a-kernel must be defined
;;;   
;;; Postconditions: if lst is not list then print the error of list? 
;;;                else if lst is null then return 0
;;;                call the helper function safe-average-a-kernel

(define safe-average-a 
  (lambda (lst)
    (cond [(not (list? lst))
        (error "safe-average-a: contract violation\nexpected: list?\n given: " lst)]
          [(null? lst)
           0]
       [else (safe-average-a-kernel lst (length lst))])))
;;; Procedure:safe-average-a-kernel
;;;   
;;; Parameters: lst, a list
;;;             num, an integer
;;;   
;;; Purpose: computes the average of those numbers when given a list of numbers
;;;   
;;; Produces: result, a number
;;;   
;;; Preconditions: [no additional]
;;;   
;;; Postconditions: if list is null, then return 0
;;;                 if lst does not contain only numbers, throw error list must contain all number
;;;                   else add the numbers divided by the length of the list until the list is null.
(define safe-average-a-kernel
  (lambda (lst num)
     (if (null? lst)
           0
    (if (not (number? (car lst)))
         (error "safe-average-a: list must contain all numbers; given " (car lst))
           (+ (/ (car lst) num) (safe-average-a-kernel (cdr lst) num))))))

; Examples/Tests:
;> (safe-average-a (list 1 2 3))
;2
;> (safe-average-a (list 1 2 3 4))
;2 1/2
;> (safe-average-a (list 1 2 3 4 "f" ))
;. . safe-average-a: list must contain all numbers; given  "f"
;> (safe-average-a 3)
;. . safe-average-a: contract violation
;expected: list?
; given:  3

; +-----------+------------------------------------------------------
; | Problem 2 |
; +-----------+

; Time Spent: 40 minutes

; Citations:  http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/let-reading.html
; assignment 6 problem 3 by student 234233 and partner
; Solution:

(define safe-average-b
  (lambda (lst)
    (letrec ([all-numbers?
              (lambda (ls)
                (or (null? ls)
                    (and (number? (car ls))
                         (all-numbers? (cdr ls)))))]
             [kernel 
              (lambda (rest length)
                (if (null? rest)
                    0
                    (+ (/ (car rest) length) (kernel (cdr rest) length))))])
      (cond [(null? lst)
             (error "safe-average-b: Argument must be a *non-empty* lst of numbers")]
            [(not (list? lst))
             (error "safe-average-b: contract violation\nexpected: list?\n given: " lst)]
            [(not (all-numbers? lst))
             (error "safe-average-b: list must contain all numbers; given " lst)]
            [else (kernel lst (length lst))]))))
              

; Examples/Tests:
;> (safe-average-b (list 1 2 3 4))
;2 1/2
;> (safe-average-b 3)
;. . safe-average-b: contract violation
;expected: list?
; given:  3
;> (safe-average-b (list 1 2 3 "f" ))
;. . safe-average-b: list must contain all numbers; given  (1 2 3 "f")

; +-----------+------------------------------------------------------
; | Problem 3 |
; +-----------+

; Time Spent: 20 minutes

; Citations:http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/strings-reading.html
;http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/homogeneous-lists-reading.html

; Solution:

;;; Procedure: string-substring
;;;   
;;; Parameters: 
;;; str, a string
;;; initial, an integer
;;; final, an integer
;;; Purpose: to return a string which starts at the position of initial and the ends at final-1
;;;   
;;; Produces:result,a string
;;;   
;;; Preconditions:[no additional]
;;;   
;;; Postconditions:
;;; use the string-ref str initial to extract character of a string at the initial point and keep extract character of string by incrementing initial by (iota final - initial)
;;; Map all these characters to make a list and change the list to string to return the string value.
;;;   
(define string-substring 
  (lambda (str initial final)
    (list->string
     (map 
      (compose (l-s string-ref str) (l-s + initial))
      (iota (- final initial)))))) 

; Examples/Tests:
;> (string-substring "str" 0 2)
;"st"
;> (string-substring "str3" 0 1)
;"s"
;> (string-substring "str3" 1 2)
;"t"
; +-----------+------------------------------------------------------
; | Problem 4 |
; +-----------+

; Time Spent: 3 hours

; Citations:http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/numbers-reading.html
;http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/reference/string-reference.html

; Solution:

;;; Procedure:
;;;   number->words
;;; Parameters:
;;;   n, an integer
;;; Purpose:
;;;   To convert an integer to its cardinal representation
;;; Produces:
;;;   result, a string
;;; Preconditions:
;;;   n is between 1 and 999999999999999, inclusive
;;; Postconditions:
;;;   result is the cardinal representation of n
;;;   For example (number->words 1024) returns the string "one thousand twenty four".
(define number->words
  (lambda (n)
   (let ([limit (quotient (- (string-length (number->string n)) 1) 3)])
        (number->words-helper n "" 0 limit))))

(define number->words-helper
  (lambda (n str count limit)
    (let ([1stDigit (list "" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine")]
          [2ndDigit (list "ten" "eleven" "twelve" "thirteen" "fourteen" "fifteen" "sixteen" "seventeen" "eightteen" "nineteen")]
          [3rdDigit (list "" "" "twenty" "thirty" "forty" "fifty" "sixty" "seventy" "eighty" "ninety")]
          [4thDigit (list "" " thousand" " million" " billion" " trillion")]
          [n1 (remainder n 1000)]
          )
    
      (cond  [(< limit  count)
              str]
             ;prints out when the three elements are 000
             [(= (quotient n1 1) 0)
              (string-append (number->words-helper (quotient n 1000) str (+ count 1) limit)
              (string-append (list-ref 1stDigit (remainder n1 10)) str)
              )
]
        ; prints out the first element of the number such as 002
             [(= (quotient n1 10) 0) 
             (string-append (number->words-helper (quotient n 1000) str (+ count 1) limit) " "
                            (string-append (list-ref 1stDigit (remainder n1 10)) 
                                           (list-ref 4thDigit count) str)
             )
             ]
          ;prints out the special number if the element is like  013  first number must be zero
             [(and (= (quotient n1 100) 0) (= (quotient (remainder n1 100) 10) 1))
              (string-append (number->words-helper (quotient n 1000) str (+ count 1) limit) " " 
                             (string-append (list-ref 2ndDigit (remainder n1 10)) 
                                            (list-ref 4thDigit count) str)
             )
]
           ;prints out the 023
             [(=(quotient n1 100) 0)
              (string-append (number->words-helper (quotient n 1000) str (+ count 1) limit ) " " 
                             (string-append (list-ref 3rdDigit (quotient (remainder n1 100)10)) " " 
                                            (list-ref 1stDigit (remainder n1 10)) 
                                            (list-ref 4thDigit count) str)
              )
]
             
           ;prints out 218  
             [(= (quotient (remainder n1 100) 10) 1)
              (string-append (number->words-helper (quotient n 1000) str (+ count 1) limit) " " 
                             (string-append (list-ref 1stDigit (quotient (remainder n1 1000) 100)) " " "hundred " 
                                            (list-ref 2ndDigit (remainder n1 10))  
                                            (list-ref 4thDigit count) str)
              )
]
           
           ;prints out 102 
             [(= (quotient (remainder n1 100) 10) 0)
              (string-append (number->words-helper (quotient n 1000) str (+ count 1) limit) " " 
                             (string-append (list-ref 1stDigit (quotient (remainder n1 1000)100)) " " "hundred " 
                                            (list-ref 1stDigit  (remainder n1 10))  
                                            (list-ref 4thDigit count) str)
              )
]
            ; prints out 234  
             [else
              (string-append (number->words-helper (quotient n 1000) str (+ count 1) limit) " " 
                             (string-append (list-ref 1stDigit (quotient (remainder n1 1000) 100)) " " "hundred " 
                                            (list-ref 3rdDigit (quotient (remainder n1 100)10))  " "
                                            (list-ref 1stDigit (remainder n1 10))  
                                            (list-ref 4thDigit count)  str)
                             )
              
              ]
          
             ))))
            

; Examples/Tests:
;> (number->words 123123)
;" one hundred twenty three thousand one hundred twenty three"
;> (number->words 1000000)
;" one million"
;> (number->words 1000030)
;" one million thirty "



; +-----------+------------------------------------------------------
; | Problem 5 |
; +-----------+

; Time Spent: 10 minutes

; Citations:http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/numeric-recursion-reading.html

; Solution:

;;; Procedure:
;;;   my-remainder
;;; Parameters:
;;;   n, an integer
;;;   d, an integer
;;; Purpose:
;;;   To compute the remainder of n by d
;;; Produces:
;;;   result, an integer
;;; Preconditions:
;;;   n must be zero or larger
;;;   d must be one or larger
;;; Postconditions:
;;;   result < d
;;;   result + (quotient n d) * d = n

(define my-remainder 
  (lambda (n d)
    (if (>= n d)
        (my-remainder (- n d) d)
        n)))
; Examples/Tests:
;> (my-remainder 3 3)
;0
;> (my-remainder 232 2)
;0
;> (my-remainder 3 132)
;3
;> (my-remainder 23 2)
;1

; +-----------+------------------------------------------------------
; | Problem 6 |
; +-----------+

; Time Spent: 3 hours

; Citations:http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/turtle-graphics-reading.html
;http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/helper-recursion-reading.html
; Provided Code:

(define set-up-turtle
  (lambda ()
    (let* ([world (image-show (image-new 300 200))]
           [tommy (turtle-new world)])
      (turtle-turn! tommy -90)
      (turtle-teleport! tommy 150 200)
      (turtle-set-brush! tommy "2. Hardness 100" 0.15)
      tommy)))

; Solution:

;;; Procedure: turtles-tree!
;;;   
;;; Parameters: turtle, a turtle
;;;     trunk-length, a number 
;;;     branches, an integer
;;;     levels, an integer
;;; Purpose: draws a tree which branches number of branches and with trunk-length decreased in each iteration by 75%.
;;;          
;;; Produces: result, a turtle
;;;   
;;; Preconditions: turtle-move! must be defined
;;;   
;;; Postconditions: 
;;;  when levels is equal to zero, it prints out the turtle.
;;; everytime turtles-tree is iterated, 
;;;  the turtle turns randomly in an angle between -60 and 60 and moves the turtle forward.
;;;  Also, in each iteration, the trunk length decreases by 0.75, draws a branches number of branches, and decreases level by 1  
;;;   
(define turtle-tree!
  (lambda (turtle trunk-length branches levels)
    (cond [( = levels 0 ) turtle]
          [else 
           (turtle-turn! turtle (- (random 121) 60))
           (turtle-forward! turtle trunk-length)
           (repeat branches turtle-move! (turtle-clone turtle) (* trunk-length 0.75) branches levels)
           ])))


;;; Procedure: turtles-move!
;;;   
;;; Parameters: turtle, a turtle
;;;     trunk-length, a number 
;;;     branches, an integer
;;;     levels, an integer
;;; Purpose: draws a tree which branches number of branches and with trunk-length decreased in each iteration by 75%.
;;;          
;;; Produces: result, a turtle
;;;   
;;; Preconditions: [no additional]
;;;   
;;; Postconditions: 
;;;  when levels is equal to zero, it prints out the turtle.
;;; everytime turtles-tree is iterated, 
;;;  the turtle turns randomly in an angle between -60 and 60 and moves the turtle forward.
;;;  Also, in each iteration, the trunk length decreases by 0.75, draws a branches number of branches, and decreases level by 1  
;;;   
(define turtle-move!
  (lambda (turtle trunk-length branches levels)
       (turtle-tree! (turtle-clone turtle) (* 0.75 trunk-length) branches (- levels 1))
    ))

; Examples/Tests:
;> (turtle-tree! (set-up-turtle) 60 3 3)
;.

;> (turtle-tree! (set-up-turtle) 120 4 3)
;.
;(turtle-tree! (set-up-turtle) 60 5 4)
;.

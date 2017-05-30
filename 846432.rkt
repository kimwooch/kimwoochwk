#lang racket

(require gigls/unsafe)

;;; File:
;;;   exam4.rkt
;;; Authors:
;;;   The student currently referred to as 000000
;;;   Charlie Curtsinger
;;;   Titus Klinge
;;; Contents:
;;;   Code and solutions for Exam 4 2016F
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

; Time Spent: 2 hours

; Citations:http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/files-reading.html

; Solution:

;;; Procedure:
;;; read-dictionary
;;; Parameters:
;;; filename, a string
;;; Purpose:
;;; to read the dictionary values inside a file
;;; Produces:
;;; result, a list 
;;; Preconditions:
;;; read-line-of-chars must be defined
;;; filename must be the directory of file inside one's computer 
;;; Postconditions:
;;; calls the helper function read-line-of-chars
(define read-dictionary
   (lambda (filename)
    (let ([source (open-input-file filename)])
      (read-line-of-chars (open-input-file filename))
      )))
;;; Procedure:
;;; read-line-of-chars
;;; Parameters:
;;; source, an input port
;;; Purpose:
;;; to read the dictionary values inside a file
;;; Produces:
;;; result, a list 
;;; Preconditions:
;;; source must connect to the file 
;;; Postconditions:
;;; if the next value is eof-object, then return null
;;; else add the value to the list and do a recursive call on the source.
(define read-line-of-chars
  (lambda (source)
    (cond 
      [(eof-object? (peek-char source))
       null]
      [else 
       (cons (read-line source)(read-line-of-chars source))]
      )))  

;;; Procedure:
;;; is-resilient?
;;; Parameters:
;;; word, a string
;;; dictionary, a list
;;; Purpose:
;;; To see if I can remove all of the word's letters one at a time without producing a non-word sequence of characters.
;;; Produces:
;;; result, a boolean
;;; Preconditions:
;;; is-resilient-helper must be defined
;;; Postconditions:
;;; calls the helper function is-resilient-helper.
(define is-resilient?
  (lambda (word dictionary)
    (if (member? (string-downcase word) dictionary)
    (is-resilient-helper word dictionary 1)
    #f)))
;;; Procedure:
;;; is-resilient-helper
;;; Parameters:
;;; word, a string
;;; dictionary, a list
;;; counter, an integer
;;; Purpose:
;;; To see if I can remove all of the word's letters one at a time without producing a non-word sequence of characters.
;;; Produces:
;;; result, a boolean
;;; Preconditions:
;;; word needs to be lower-cased
;;; Postconditions:
;;; if string length of the word is less than counter and string with one element out is not a member in the dictionary.
;;; add one to the counter and do a recursive call to is-resilient-helper.
;;; if string is a member of the dictionary, do the recursive call, but with that smaller string.
;;; if the counter is larger than the string length, then return false.
;;; else return true;
(define is-resilient-helper
  (lambda (word dictionary counter)
    (cond [(and (< counter (string-length word)) (not (member? (string-append (substring word 0 (- counter 1)) (substring word counter (string-length word))) dictionary)))
           (is-resilient-helper word dictionary (+ 1 counter))]
          [(member? (string-append (substring word 0 (- counter 1)) (substring word counter (string-length word))) dictionary)
           (is-resilient-helper (string-append (substring word 0 (- counter 1)) (substring word counter (string-length word))) dictionary 1)]
          [(> counter (string-length word))
           #f]
          [else #t])))

; Extra Credit Solution:

; Examples/Tests:


; +-----------+------------------------------------------------------
; | Problem 2 |
; +-----------+

; Time Spent: 20 minutes

; Citations:http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/pairs-reading.html

; Solution:
;;; Procedure:
;;; count-pairs
;;; Parameters:
;;; value, a scheme value
;;; Purpose:
;;; to determine how many pairs (cons cells) appear the value
;;; Produces:
;;; result, an integer
;;; Preconditions:
;;; [no additional]
;;; Postconditions:
;;; if it is not a pair value then return zero
;;; or else add one and do a recursion of first value in the list or pair structure
;;; and do recursion for the rest of the values in the pair or list structure.
(define count-pairs
  (lambda (value)
    (if (not (pair? value))
        0 
        (+ 1 (count-pairs (car value))
           (count-pairs (cdr value))))))

; Examples/Tests:
;> (count-pairs (cons 3 null))
;1
;> (count-pairs (list 1 2 3))
;3
;> (count-pairs (cons (cons 1 2) 3))
;2
; +-----------+------------------------------------------------------
; | Problem 3 |
; +-----------+

; Time Spent: 2 hours

; Citations:
;;;http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/labs/binary-tree-lab

; Solution:

;;; Procedure:
;;; nod
;;; Parameters: 
;;; t, a tree
;;; Purpose:
;;; print the values at the top of the tree
;;; Produces:
;;; result, tree's value
;;; Preconditions:
;;; [no additional]
;;; Postconditions:
;;; (if the tree is not empty display the the second position of vector) else return null
(define nod
  (lambda (t)
    (if (not (empty? t))
        (display (vector-ref t 1))
        null)))
;;; Procedure:
;;; subnod1
;;; Parameters: 
;;; t, a tree
;;; Purpose:
;;; print the values of the left node of the tree
;;; Produces:
;;; result, tree's value
;;; Preconditions:
;;; [no additional]
;;; Postconditions:
;;; (if the tree is not empty display the the second position of vector) else return null
(define subnod1 
  (lambda (t)
    (if (not (empty? t))
      (display (vector-ref (left t) 1))
      null)))
;;; Procedure:
;;; subnod2
;;; Parameters: 
;;; t, a tree
;;; Purpose:
;;; print the values of the right node of the tree
;;; Produces:
;;; result, tree's value
;;; Preconditions:
;;; [no additional]
;;; Postconditions:
;;; (if the tree is not empty display the the second position of vector) else return null
(define subnod2
  (lambda (t)
    (if (not (empty? t))
        (display (vector-ref (right t) 1))
        null)))
;;; Procedure:
;;; left-leaf1
;;; Parameters: 
;;; t, a tree
;;; Purpose:
;;; print the values of the leftest leaf of the tree
;;; Produces:
;;; result, tree's value
;;; Preconditions:
;;; [no additional]
;;; Postconditions:
;;; (if the tree is not empty and leaf is not empty) display the the second position of vector) else return null
(define left-leaf1
  (lambda (t)
    (if (and (not (empty? t)) (not (empty? (left (left t)))))
        (display (vector-ref (left (left t)) 1)) null)))
;;; Procedure:
;;; left-leaf2
;;; Parameters: 
;;; t, a tree
;;; Purpose:
;;; print the values of the left, but right side of leaf of the tree
;;; Produces:
;;; result, tree's value
;;; Preconditions:
;;; [no additional]
;;; Postconditions:
;;; (if the tree is not empty and leaf is not empty) display the the second position of vector) else return null
(define left-leaf2
  (lambda (t)
    (if (and (not (empty? t)) (not (empty? (right (left t)))))
        (display (vector-ref (right (left t)) 1))null)))
;;; Procedure:
;;; right-leaf1
;;; Parameters: 
;;; t, a tree
;;; Purpose:
;;; print the values of the rightest leaf of the tree
;;; Produces:
;;; result, tree's value
;;; Preconditions:
;;; [no additional]
;;; Postconditions:
;;; (if the tree is not empty and leaf is not empty) display the the second position of vector) else return null
(define right-leaf1
  (lambda (t)
    (if (and (not (empty? t)) (not (empty? (left (right t)))))
        (display (vector-ref (left (right t)) 1))null)))
;;; Procedure:
;;; right-leaf2
;;; Parameters: 
;;; t, a tree
;;; Purpose:
;;; print the values of the right left leaf of the tree
;;; Produces:
;;; result, tree's value
;;; Preconditions:
;;; [no additional]
;;; Postconditions:
;;; (if the tree is not empty and leaf is not empty) display the the second position of vector) else return null
(define right-leaf2
  (lambda (t)
    (if (and (not (empty? t))(not (empty? (right (right t)))))
        (display (vector-ref (right (right t))1)) null)))

;;; Procedure:
;;; print-tree!
;;; Parameters: 
;;; root, a tree
;;; Purpose:
;;; print the values in the tree in ascending order
;;; Produces:
;;; result, tree's values
;;; Preconditions:
;;; left-leaf1, subnod1, left-leaf2, nod,right-leaf1, subnod2, right-leaf2 must be defined. 
;;; Postconditions:
;;; displays leaves from left to right order by calling on functions above and spacing them by " ".
(define print-tree!
  (lambda (root)
  (left-leaf1 root)
  (display " ")
  (subnod1 root)
  (display " ")
  (left-leaf2 root)
  (display " ")
  (nod root)
  (display " ")
  (right-leaf1 root)
  (display " ")
  (subnod2 root)
  (display " ")
  (right-leaf2 root)
  (display " ")
    ))

;;; Procedure:
;;; print-reverse-tree!
;;; Parameters:
;;; root, a tree
;;; Purpose:
;;; print the values in the tree in descending order
;;; Produces:
;;; result, tree's values
;;; Preconditions:
;;; left-leaf1, subnod1, left-leaf2, nod,right-leaf1, subnod2, right-leaf2 must be defined.
;;; Postconditions:
;;; displays leaves from right to left order by calling on functions above and spacing them by " ".
(define print-reverse-tree!
  (lambda (root)
    (right-leaf2 root)
    (display " ")
    (subnod2 root)
    (display " ")
    (right-leaf1 root)
    (display " ")
    (nod root)
    (display " ")
    (left-leaf2 root)
    (display " ")
    (subnod1 root)
    (display " ")
    (left-leaf1 root)
    (display " ")
    ))

; Examples/Tests:
;> (define tree3 (node 'a (node 'b (leaf 'd) empty) (leaf 'c)))
;> (print-tree! tree3)
;d b  a  c '()
;> (define tree (node 3 (node 1 (leaf 1) (leaf 4)) (node 3 (leaf 1 )(leaf 8))))
;> (define treex (node 2 (node 1 empty (leaf 14)) (node 1 (leaf 1) empty)))
;> (define treez (node 'd (node 'c (leaf 'd) empty) (leaf 'd)))
;> (print-tree! tree)
;1 1 4 3 1 3 8
;> (print-tree! treex)
; 1 14 2 1 1 '()
;> (print-tree! treez)
;d c  d  d '()
;> (print-reverse-tree! tree)
;8 3 1 3 4 1 1 
;> (print-reverse-tree! treex)
; 1 1 2 14 1  
;> (print-reverse-tree! treez)
; d  d  c d 
; +-----------+------------------------------------------------------
; | Problem 4 |
; +-----------+

; Time Spent: 2 hours

; Citations:http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/labs/analysis-lab.html

; Provided Code:

; Documentation for counter-new appears later in the exam, but this procedure
; must appear before the counters below.
(define counter-new
  (lambda (name)
    (vector name 0)))

(define cons-counter (counter-new "cons"))
(define car-counter (counter-new "car"))
(define cdr-counter (counter-new "cdr"))
(define null?-counter (counter-new "null?"))

;;; Procedure:
;;;   reset-counters!
;;; Parameters:
;;;   none
;;; Purpose:
;;;   reset the counters used for problem 4
;;; Produces:
;;;   nothing
;;; Preconditions:
;;;   no additional
;;; Postconditions:
;;;   the values of the four counters used in problem 4 will be zero
(define reset-counters!
  (lambda ()
    (counter-reset! cons-counter)
    (counter-reset! car-counter)
    (counter-reset! cdr-counter)
    (counter-reset! null?-counter)))

;;; Procedure:
;;;   print-counters!
;;; Parameters:
;;;   none
;;; Purpose:
;;;   display the current values of the counters for problem 4
;;; Produces:
;;;   nothing
;;; Preconditions:
;;;   no additional
;;; Postconditions:
;;;   the values of the four counters used in problem 4 will be printed
(define print-counters!
  (lambda ()
    (counter-print! cons-counter)
    (counter-print! car-counter)
    (counter-print! cdr-counter)
    (counter-print! null?-counter)))

(define $cons
  (lambda (first second)
    (counter-count! cons-counter)
    (cons first second)))

(define $car
  (lambda (pair)
    (counter-count! car-counter)
    (car pair)))

(define $cdr
  (lambda (pair)
    (counter-count! cdr-counter)
    (cdr pair)))

(define $null?
  (lambda (val)
    (counter-count! null?-counter)
    (null? val)))

(define $make-list
  (lambda (len val)
    (if (zero? len)
        null
        ($cons val ($make-list (- len 1) val)))))

(define $iota
  (lambda (n)
    (let kernel [(i 0)]
      (if (= i n)
          null
          ($cons i (kernel (+ i 1)))))))

(define $map1
  (lambda (fun lst)
    (if ($null? lst)
        null
        ($cons (fun ($car lst))
              ($map1 fun ($cdr lst))))))

(define $map2
  (lambda (fun lst1 lst2)
    (if (or ($null? lst1) ($null? lst2))
        null
        ($cons (fun ($car lst1) ($car lst2))
              ($map2 fun ($cdr lst1) ($cdr lst2))))))

(define $map3
  (lambda (fun lst1 lst2 lst3)
    (if (or ($null? lst1) ($null? lst2) ($null? lst3))
        null
        ($cons (fun ($car lst1) ($car lst2) ($car lst3))
              ($map3 fun ($cdr lst1) ($cdr lst2) ($cdr lst3))))))

; Solution:

; a. Update the procedure below to use the counted versions of cons, car,
;    cdr, map, make-list, null?, and iota.

(define many-circles
  (lambda (n)
    ($map2 vshift-drawing
         ($map2 *
              ($make-list n 10)
              ($map2 modulo
                   ($iota n)
                   ($make-list n 10)))
         ($map2 hshift-drawing
              ($map2 *
                   ($make-list n 5)
                   ($iota n))
              ($map2 scale-drawing
                   ($map1 increment
                        ($map2 modulo
                             ($iota n)
                             ($make-list n 7)))
                   ($make-list n drawing-unit-circle))))))

; b.
;
;         cons        car        cdr          null?
;     +-----------+---------+------------+-------------+
;   5 |    80     |    75   |     75     |        83   |
;     +-----------+---------+------------+-------------+
;  10 |     160   |  150    |     150    |      158    |
;     +-----------+---------+------------+-------------+
;  20 |   320     |   300   |    300     |    308      |
;     +-----------+---------+------------+-------------+
;  40 |   6400    | 6000    |  6000      |   6008      |
;     +-----------+---------+------------+-------------+


; c.
;
;         cons        car        cdr          null?
;     +-----------+---------+------------+-------------+
;   n |   16n     |   15n   |    15n     |  15n+8      |
;     +-----------+---------+------------+-------------+

; d.

(define many-circles1
  (lambda (n)
    (letrec ([10modtimes (lambda (n)
                        (* (mod n 10) 10))]
             [5times (lambda (n)
                       (* n 5))]
             [7modIncrement (lambda (n)
                     (+ 1(mod n 7)))]
             [ioa (lambda (n)
                    ($iota n))]
             [drawing ($make-list n drawing-unit-circle)]
             )
    ($map2 vshift-drawing
         ($map1 10modtimes 
                   (ioa n)
                   )
         ($map2 hshift-drawing
              ($map1 5times
                   (ioa n))
              ($map2 scale-drawing
                   ($map1 7modIncrement
                             (ioa n)
                             )
                   drawing ))))))

; Examples/Tests:


; +-----------+------------------------------------------------------
; | Problem 5 |
; +-----------+

; Time Spent: 40 minutes

; Citations:http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/reference/vector-reference.html

; Solution:

;; Modify and document the procedure below according to the exam's instructions.

;;; Procedure: 
;;; swap-vector
;;;
;;; Parameters:
;;; vector, a vector
;;; Purpose:
;;; To flip the order of values that appear in the vector
;;; Produces:
;;; result, a vector
;;; Preconditions:
;;;[no additional]
;;; Postconditions:
;;; swap-vector will take the vector value and create a local procedure which
;;; takes vector, a initial value, and end value
;;; it will also create local variables for vector length and number of times it wil swap with other values
;;; we will create numofswap number of vector values, create iota of numofswap, and veclen - 1 - iota of num of swap
;;; this ensures that when we call vector-set two times like below, it will swap the very first value with very last value
;;; second value with vector-length - 3 value, etc.
(define swap-vector
  (lambda (vector)
    (let* ([swap-proc
           (lambda (vector init end)
             (let ([backNum (vector-ref vector end)]
                   [frontNum (vector-ref vector init)])
               (vector-set! vector init backNum)
               (vector-set! vector end frontNum)))]
          [veclen (vector-length vector)]
          [numofswap (quotient veclen 2)]
          )
      (map (l-s apply swap-proc)
           (map list (make-list numofswap vector) 
                     (iota numofswap)
                     (map (l-s - (- veclen 1)) (iota numofswap)))))
    vector))

; Examples/Tests:

;> (swap-vector (vector 1 2 3 4 555 666))
;'#(666 555 4 3 2 1)
;> (swap-vector (vector 'a 'b' d' 1 2 3))
;'#(3 2 1 d b a)
;> (swap-vector (vector 'a 'b))
;'#(b a)
; +-----------+------------------------------------------------------
; | Problem 6 |
; +-----------+

; Time Spent: 2 hours

; Citations:
;http://www.cs.grinnell.edu/~curtsinger/teaching/2016F/CSC151/readings/hop-reading.html
; Solution:

;;; Procedure:
;;;   nest
;;; Parameters:
;;;   n, an integer
;;;   fun, a procedure
;;; Purpose:
;;;   nest creates a new procedure than nests n calls to fun
;;; Produces:
;;;   nested, a procedure
;;; Preconditions:
;;;   The value of n must be greater than or equal to zero.
;;;   The procedure fun must accept one parameter, and must return a
;;;   value that can be used as a parameter to a subsequent call to fun.
;;; Postconditions:
;;;   calling nested on a parameter is equivalent to nesting n calls to
;;;   fun, where the parameter to nested is passed as the parameter to
;;;   the innermost call to fun.
;;;   For example, for the result of (nest 3 square), calling (nested x)
;;;   is equivalent to calling (square (square (square x))).
(define nest
  (lambda (n fun)
    (lambda (x)
      (if ( = 0 n)
          x
          ((nest (- n 1) fun) (fun x))))))

; Examples/Tests:
;> (define twosqrt (nest 2 sqrt))
;> (twosqrt 16)
;2
;> (define twoincrement (nest 2 increment))
;> (twoincrement 2)
;4
;> (define lighter (nest 3 irgb-lighter))
;> (irgb->string (lighter (irgb 0 0 0)))
;"48/48/48"


; ===================================================================

; THE CODE BELOW THIS LINE WAS SUPPLIED WITH THE EXAM.  PLEASE LEAVE
; IT IN PLACE IN THE ELECTRONIC VERSION OF THE EXAM!

; +-----------------+------------------------------------------------
; | Tree Procedures |
; +-----------------+

; + --- Tree Constructors -----------------------

;;; Name:
;;;   empty
;;; Type:
;;;   tree
;;; Value:
;;;   The empty tree
(define empty 'empty)

;;; Procedure:
;;;   leaf
;;; Parameters:
;;;   val, a value
;;; Purpose:
;;;   Make a leaf node.
;;; Produces:
;;;   tree, a tree
;;; Preconditions:
;;;   [No additional]
;;; Postconditions:
;;;   (contents tree) = val
;;;   (left tree) = empty
;;;   (right tree) = empty
(define leaf
  (lambda (val)
    (node val empty empty)))

;;; Procedure:
;;;   node
;;; Parameters:
;;;   val, a value
;;;   left-subtree, a tree
;;;   right-subtree, a tree
;;; Purpose:
;;;   Create a node in a binary tree.
;;; Produces:
;;;   tree, a tree
;;; Preconditions:
;;;   [No additional]
;;; Postconditions:
;;;   (node? tree) holds.
;;;   (left tree) = left-subtree.
;;;   (right tree) = right-subtree.
;;;   (contents tree) = val.
(define node
  (lambda (val left right)
    (vector 'node val left right)))

; + --- Tree Observers -----------------------

;;; Procedure:
;;;   contents
;;; Parameters:
;;;   nod, a binary tree node
;;; Purpose:
;;;   Extract the contents of node.
;;; Produces:
;;;   val, a value
;;; Preconditions:
;;;   [No additional]
;;; Postconditions:
;;;   (contents (node val l r)) = val
(define contents
  (lambda (nod)
    (cond
      [(not (node? nod))
       (error "contents requires a node, received" nod)]
      [else
       (vector-ref nod 1)])))

;;; Procedure:
;;;   left
;;; Parameters:
;;;   nod, a binary tree node
;;; Purpose:
;;;   Extract the left subtree of nod.
;;; Produces:
;;;   l, a tree
;;; Preconditions:
;;;   [No additional]
;;; Postconditions:
;;;   (left (node val l r)) = l
(define left
  (lambda (nod)
    (cond
      [(not (node? nod))
       (error "left requires a node, received" nod)]
      [else
       (vector-ref nod 2)])))

;;; Procedure:
;;;   right
;;; Parameters:
;;;   nod, a binary tree node
;;; Purpose:
;;;   Extract the right subtree of nod.
;;; Produces:
;;;   r, a tree
;;; Preconditions:
;;;   [No additional]
;;; Postconditions:
;;;   (right (node val l r)) = r
(define right
  (lambda (nod)
    (cond
      [(not (node? nod))
       (error "right requires a node, received" nod)]
      [else
       (vector-ref nod 3)])))

; + --- Tree Observers -----------------------

;;; Procedure:
;;;   empty?
;;; Parameters:
;;;   val, a Scheme value
;;; Purpose:
;;;   Determine if val represents an empty tree.
;;; Produces:
;;;   is-empty?, a Boolean 
;;; Preconditions:
;;;   [No additional]
;;; Postconditions:
;;;   is-empty? is true (#t) if and only if val can be interpreted as
;;;   the empty tree.
(define empty? 
  (l-s eq? empty))

;;; Procedure:
;;;   leaf?
;;; Parameters:
;;;   val, a Scheme value
;;; Purpose:
;;;   Determine if val is a tree leaf
;;; Produces:
;;;   is-leaf?, a Boolean
(define leaf?
  (lambda (val)
    (and (node? val)
         (empty? (left val))
         (empty? (right val)))))

;;; Procedure:
;;;   node?
;;; Parameters:
;;;   val, a Scheme value
;;; Purpose:
;;;   Determine if val can be used as a tree node.
;;; Produces:
;;;   is-node?, a Boolean
(define node?
  (lambda (val)
    (and (vector? val)
         (= (vector-length val) 4)
         (eq? (vector-ref val 0) 'node))))

; +--------------------------------+----------------------------------
; | Generalized Counter Procedures |
; +--------------------------------+

;;; Procedure:
;;;   counter-new
;;; Parameters:
;;;   name, a string
;;; Purpose:
;;;   Create a counter associated with the given name.
;;; Produces:
;;;   counter, a counter
;;; Preconditions:
;;;   [No additional]
;;; Postconditions:
;;;   counter can be used as a parameter to the various counter
;;;   procedures.
;;; Process:
;;;   Counters are two element vectors.  Element 0 is the name, and
;;;   should not change.  Element 1 is the count, and should change.

; The implementation of this procedure appears in the section for problem 4

;;; Procedure:
;;;   counter-count!
;;; Parameters:
;;;   counter, a counter 
;;; Purpose:
;;;   count the counter
;;; Produces:
;;;   counter, the same counter, now mutated
;;; Preconditions:
;;;   counter was created by counter-new (or something similar) and
;;;   has only been modified by the counter procedures.
;;; Postconditions:
;;;   (counter-get counter) gives a number one higher than it 
;;;   did before.
(define counter-count!
  (lambda (counter)
    (vector-set! counter 1 (+ 1 (vector-ref counter 1)))
    counter))

;;; Procedure:
;;;   counter-get
;;; Parameters:
;;;   counter, a counter
;;; Purpose:
;;;   Get the number of times that counter-count! has been called
;;;   on this counter.
;;; Produces:
;;;   count, a non-negative integer
;;; Preconditions:
;;;   counter was created by counter-new and has only been modified
;;;   by the counter procedures.
;;; Postconditions:
;;;   count is the number of calls to counter-new on this counter since
;;;   the last call to counter-reset! on this counter, or since the
;;;   counter was created, if there have been no calls to counter-reset!
(define counter-get
  (lambda (counter)
    (vector-ref counter 1)))

;;; Procedure:
;;;   counter-reset!
;;; Parameters:
;;;   counter, a counter 
;;; Purpose:
;;;   reset the counter
;;; Produces:
;;;   counter, the same counter, now set to 0
;;; Preconditions:
;;;   counter was created by counter-new (or something similar) and
;;;   has only been modified by the other counter procedures.
;;; Postconditions:
;;;   (counter-get counter) gives 0.
(define counter-reset!
  (lambda (counter)
    (vector-set! counter 1 0)
    counter))

;;; Procedure:
;;;   counter-print!
;;; Parameters:
;;;   counter, a counter
;;; Purpose:
;;;   Print out the information associated with the counter.
;;; Produces:
;;;   counter, the same counter
;;; Preconditions:
;;;   counter was created by counter-new and has only been modified
;;;   by the various counter procedures.
;;; Postconditions:
;;;   counter is unchanged.
;;;   The output port now contains information on counter.
;;; Ponderings:
;;;   Why does counter-print! have a bang, given that it doesn't mutate
;;;   it's parameter?  Because it mutates the broader environment - we
;;;   call counter-print! not to compute a value, but to print something.
(define counter-print!
  (lambda (counter)
    (display (vector-ref counter 0))
    (display ": ")
    (display (vector-ref counter 1))
    (newline)))
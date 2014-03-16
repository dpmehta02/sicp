; Ex 1.3: Define a procedure that takes three numbers as arguments and returns
; the sum of the squares of the two larger numbers. 
  
(define (square x) (* x x)) 

(define (sum-of-squares x y) (+ (square x) (square y))) 

(define (sum-of-squared-largest-two x y z) 
        (cond ((= (min x y z) x) (sum-of-squares y z))
              ((= (min x y z) y) (sum-of-squares x z))
              ((= (min x y z) z) (sum-of-squares x y))))
  
 ;; Testing
(newline)
(display (sum-of-squared-largest-two 1 3 4)) (newline)
(display (sum-of-squared-largest-two 4 1 3)) (newline)
(display (sum-of-squared-largest-two 3 4 1)) (newline)

; Ex 1.4
; Defines a function that takes two inputs and adds the first to the absolute
; value of the second with the following trick: if b is positive, the function
; adds a and b; if b is negative, the function subtracts b from a, in effect 
; adding them together
(define (a-plus-abs-b a b)
  ((if (> b 0) + -) a b))

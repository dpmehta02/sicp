; Ex 1.3: Define a procedure that takes three numbers as arguments and returns
; the sum of the squares of the two larger numbers. 
  
(define (square x) (* x x)) 

(define (sum-of-squares x y) (+ (square x) (square y))) 

(define (sum-of-squared-largest-two x y z) 
        (cond ((= (min x y z) x) (sum-of-squares y z))
              ((= (min x y z) y) (sum-of-squares x z))
              ((= (min x y z) z) (sum-of-squares x y))))
  
; Testing
(newline)
(display (sum-of-squared-largest-two 1 3 4)) (newline)
(display (sum-of-squared-largest-two 4 1 3)) (newline)
(display (sum-of-squared-largest-two 3 4 1)) (newline)

; Ex 1.4
; Defines a function that takes two inputs and adds the first to the absolute
; value of the second with the following trick: if b is positive, the function
; adds a and b; if b is negative, the function subtracts b from a, in effect 
; adding them together

; (define (a-plus-abs-b a b)
;   ((if (> b 0) + -) a b))


; Ex 1.5
; Ben Bitdiddle has invented a test to determine whether the interpreter he is
; faced with is using applicative-order evaluation or normal-order evaluation.
; He defines the following two procedures:

; (define (p) (p))

; (define (test x y)
;   (if (= x 0)
;       0
;       y))

; Then he evaluates the expression

; (test 0 (p))

; What behavior will Ben observe with an interpreter that uses applicative-order
; evaluation? What behavior will he observe with an interpreter that uses 
; normal-order evaluation? Explain your answer. (Assume that the evaluation 
; rule for the special form if is the same whether the interpreter is using 
; normal or applicative order: The predicate expression is evaluated first, 
; and the result determines whether to evaluate the consequent or the 
; alternative expression.)

; Applicative eval: Infinite loop. The interpreter will try to simplify the 
; expression as much as possible before evaluating, so it will continue to 
; return (test 0 (p)), because p recursively calls itself with no simplification.
; Normal eval: 0, because evaluates step by step. If x = 0 is true, return 0 
; and do not try to evaluate p.


; Exercise 1.6.  Alyssa P. Hacker doesn't see why if needs to be provided as a
; special form. ``Why can't I just define it as an ordinary procedure in terms
; of cond?'' she asks. Alyssa's friend Eva Lu Ator claims this can indeed be
; done, and she defines a new version of if:

; (define (new-if predicate then-clause else-clause)
;   (cond (predicate then-clause)
;         (else else-clause)))

; Eva demonstrates the program for Alyssa:

; (new-if (= 2 3) 0 5)
; 5

; (new-if (= 1 1) 0 5)
; 0

; Delighted, Alyssa uses new-if to rewrite the square-root program:

; (define (sqrt-iter guess x)
;   (new-if (good-enough? guess x)
;           guess
;           (sqrt-iter (improve guess x)
;                      x)))

; What happens when Alyssa attempts to use this to compute square roots? Explain.

; Infinite loop. Scheme's applicative-order evaluation evaluates all arguments
; before proceeding, and thus Alyssa's new function calls itself during every
; interation, creating an infinite loop. The if-then logic only evaluates the
; first argument, so when the predicate condition is satisfied, the then clause
; is run and the else is ignored.
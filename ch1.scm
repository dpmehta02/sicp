; Ex 1.3: DEFINE a procedure that takes three numbers as arguments and returns
; the sum of the squares of the two larger numbers. 
  
(DEFINE (square x) (* x x)) 

(DEFINE (sum-of-squares x y) (+ (square x) (square y))) 

(DEFINE (sum-of-squared-largest-two x y z) 
        (cond ((= (min x y z) x) (sum-of-squares y z))
              ((= (min x y z) y) (sum-of-squares x z))
              ((= (min x y z) z) (sum-of-squares x y))))
  
; ; Testing
; (newline)
; (display (sum-of-squared-largest-two 1 3 4)) (newline)
; (display (sum-of-squared-largest-two 4 1 3)) (newline)
; (display (sum-of-squared-largest-two 3 4 1)) (newline)

; Ex 1.4
; DEFINEs a function that takes two inputs and adds the first to the absolute
; value of the second with the following trick: if b is positive, the function
; adds a and b; if b is negative, the function subtracts b from a, in effect 
; adding them together

; (DEFINE (a-plus-abs-b a b)
;   ((if (> b 0) + -) a b))


; Ex 1.5
; Ben Bitdiddle has invented a test to determine whether the interpreter he is
; faced with is using applicative-order evaluation or normal-order evaluation.
; He DEFINEs the following two procedures:

; (DEFINE (p) (p))

; (DEFINE (test x y)
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
; special form. ``Why can't I just DEFINE it as an ordinary procedure in terms
; of cond?'' she asks. Alyssa's friend Eva Lu Ator claims this can indeed be
; done, and she DEFINEs a new version of if:

; (DEFINE (new-if predicate then-clause else-clause)
;   (cond (predicate then-clause)
;         (else else-clause)))

; Eva demonstrates the program for Alyssa:

; (new-if (= 2 3) 0 5)
; 5

; (new-if (= 1 1) 0 5)
; 0

; Delighted, Alyssa uses new-if to rewrite the square-root program:

; (DEFINE (sqrt-ITER guess x)
;   (new-if (good-enough? guess x)
;           guess
;           (sqrt-ITER (improve guess x)
;                      x)))

; What happens when Alyssa attempts to use this to compute square roots? Explain.

; Infinite loop. Scheme's applicative-order evaluation evaluates all arguments
; before proceeding, and thus Alyssa's new function calls itself during every
; interation, creating an infinite loop. The if-then logic only evaluates the
; first argument, so when the predicate condition is satisfied, the then clause
; is run and the else is ignored.

; Ex 1.7 Guesses for very small values are innacuratethe precision cannot be
; specific enough. Guesses for large values can top out on accuracy by
; alternating between two guesses without becoming more accurate, basically
; creating an infinite loop that will not get any more accurate.

; http://www.kendyck.com/archives/2005/03/20/solution-to-sicp-exercise-17/
; Yes, this works better for both large and small numbers

; Ex 1.8
; Initialize our guess
(DEFINE (cube-root x) 
 (cube-root-ITER 1.0 x))

; Recursively improve the guess until it's good enough
(DEFINE (cube-root-ITER guess x) 
 (if (good-enough? guess x) 
     guess 
     (cube-root-ITER (improve guess x) 
                     x))) 

(DEFINE (good-enough? guess x) 
 (< (abs (- (cube guess) x)) 0.001))

; Newton's method
(DEFINE (improve guess x) 
 (/ (+ (/ x (square guess)) (* 2 guess)) 3))

(DEFINE (cube x) 
 (* x x x)) 

; Ex 1.9
; Using the substitution model, illustrate the process generated by each procedure in evaluating (+ 4 5). Are these processes ITERative or recursive?

(DEFINE (+ a b)
  (if (= a 0)
      b
      (inc (+ (dec a) b))))

; Recursive
; (+ 4 5)
; (inc (+ 3 5))
; (inc (inc (+ 2 5)))
; (inc (inc (inc(+ 1 5))))
; (inc (inc (inc (inc (+ 0 5)))))
; (inc (inc (inc (inc (+ 0 5)))))
; (inc (inc (inc (inc 5))))
; (inc (inc (inc 6)))
; (inc (inc 7))
; (inc 8)
; 9

(DEFINE (+ a b)
  (if (= a 0)
      b
      (+ (dec a) (inc b))))

; ITERative
; (+ 4 5)
; (+ (dec 4) (inc 5))
; (+ 3 6)
; (+ (dec 3) (inc 6))
; (+ 2 7)
; (+ (dec 2) (inc 7))
; (+ 1 8)
; (+ (dec 1) (inc 8))
; (+ 0 9)
; 9

; Ex 1.10
; (DEFINE (A x y)
;   (cond ((= y 0) 0)
;         ((= x 0) (* 2 y))
;         ((= y 1) 2)
;         (else (A (- x 1)
;                  (A x (- y 1))))))

; What are the values of the following expressions?

; (A 1 10)
;1024
; (A 2 4)
; 65536
; (A 3 3)
; 65536

; Consider the following procedures, where A is the procedure DEFINEd above:

; (DEFINE (f n) (A 0 n))
; 2n
; (DEFINE (g n) (A 1 n))
; 2^n
; (DEFINE (h n) (A 2 n))
; 2^2^2 ... n times
; (DEFINE (k n) (* 5 n n))

; Give concise mathematical definitions for the functions computed by the procedures f, g, and h for positive integer values of n. For example, (k n) computes 5n2.

; Ex 1.11.  A function f is DEFINEd by the rule that
;f(n) = n if n<3 and f(n) = f(n - 1) + 2f(n - 2) + 3f(n - 3)
; if n> 3. Write a procedure that computes f by means of a 
; recursive process. Write a procedure that computes f by 
; means of an ITERative process.

; Recursive
(DEFINE (f n) 
  (cond ((< n 3) n) 
       (else (+ (f (- n 1))
                (* 2 (f (- n 2))) 
                (* 3 (f (- n 3)))))))

; ITERative
(DEFINE (foo n) 
  (DEFINE (foo-ITER a b c n) 
    (if (< n 3) 
      a 
      (foo-ITER (+ a (* 2 b) (* 3 c)) a b (- n 1)))) 
  (if (< n 3) 
    n 
    (foo-ITER 2 1 0 n)))

; Exercise 1.12.  The following pattern of numbers is called Pascal's triangle.
; The numbers at the edge of the triangle are all 1, and each number inside the
; triangle is the sum of the two numbers above it.35 Write a procedure that
; computes elements of Pascal's triangle by means of a recursive process.

(DEFINE (pascal-triangle row col)
  (cond ((> col row) 0)
        ((< col 0) 0)
        ((= col 1) 1)
        ((+ (pascal-triangle (- row 1) (- col 1))
            (pascal-triangle (- row 1) col)))))

; Exercise 1.13
; http://www.billthelizard.com/2009/12/sicp-exercise-113-fibonacci-and-golden.html

; Ex 1.14: http://community.schemewiki.org/?sicp-ex-1.14
; Ex 1.15 a. 5, Space = O(log(a)), Time = O(log(a))
; Ex 1.16 
(DEFINE (fast-expt b n) 
 (DEFINE (ITER a b n) 
   (cond ((= n 0) a) 
         ((even? n) (ITER a (square b) (/ n 2))) 
         (else (ITER (* a b) b (- n 1))))) 
 (ITER 1 b n)) 

(DEFINE (square x) (* x x)) 

; Ex 1.17
(DEFINE (* x y)
  (cond ((= y 0) 0)
        ((even? y) (double (* x (halve y)))))
        (else (+ a (* a (- b 1))))))

; Ex 1.18
(DEFINE (* a b) 
 (DEFINE (ITER accumulator a b) 
   (cond ((= b 0) accumulator) 
         ((even? b) (ITER accumulator (double a) (halve b))) 
         (else (ITER (+ accumulator a) a (- b 1))))) 
 (ITER 0 a b)) 

; Ex 1.19
(define (fib n) 
 (fib-iter 1 0 0 1 n)) 
(define (fib-iter a b p q count) 
 (cond ((= count 0) b) 
       ((even? count) 
        (fib-iter a 
                  b 
                  (+ (square p) (square q)) 
                  (+ (* 2 p q) (square q)) 
                  (/ count 2))) 
       (else (fib-iter (+ (* b q) (* a q) (* a p)) 
                       (+ (* b p) (* a q)) 
                       p 
                       q 
                       (- count 1))))) 

 (define (square x) (* x x)) 
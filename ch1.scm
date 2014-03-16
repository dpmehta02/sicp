; Ex 1.3
; My solution
(define (sum-of-squares a b c)
  (cond ((and (<= a b) (<= a c)) (+ (* b b) (* c c)))
        ((and (<= b a) (<= b c)) (+ (* a a) (* c c)))
                                 (+ (* a a) (* b b))
  )
)

; Community solution
(define  
     (largest-two-square-sum x y z)  
         (if (= x (larger x y))  
             (sum-of-squares x (larger y z))  
             (sum-of-squares y (larger x z)) 
         ) 
 ) 
  
 (define  
     (larger x y)  
         (if (> x y) x y) 
 ) 
  
 (define  
     (sum-of-squares x y)  
         (+ (square x) (square y)) 
 ) 
  
 (define  
     (square x)  
         (* x x) 
 ) 
  
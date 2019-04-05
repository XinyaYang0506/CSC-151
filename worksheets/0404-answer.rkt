#lang racket
(require loudhum)
;;; Focus on 4Ps and the recursive step and base case. The answer is not that important compare to these. I won't write everything out, but I will provide guidance to every question. 

;;; string-rotate
;;; Extra examples: (string-rotate "ABCD" 1) should produce "DABC"; (string-rotate "ABCD" 2) should produce "CDAB";  (string-rotate "ABCD" 3) should produce "BCDA"; (string-rotate "ABCD" 4) should produce "ABCD"; 
;;; Can str be a empty string? Can num be a negative integer? My version assume that str cannot be "", but num needs to be non-negative.
;;; Non-recursive version
(define string-rotate
  (lambda (str num)
    (let* ([len (string-length str)]
           [real-num (remainder num len)]) ; notice that if you rotate (string-length str) you will get back the original string
      (string-append (substring str (- len real-num) len) (substring str 0 (- len real-num))))))
;;; Idea is that you can just cut the string into "two" parts, swap them and append them back. 

;;; Recursive version
;;; Base case: the easiest scenario will be when num == 0, we just need to return str.
;;; Keyfinding is that as long as you know how to rotate just one last character, you can do this step recursively until you finish num times.
(define string-rotate2
  (lambda (str num)
    (let* ([len (string-length str)])
      (if (= 0 num)
          str
      (string-rotate (string-append (substring str (- len 1) len) (substring str 0 (- len 1))) (- num 1))))))

;;; Notice that you actually don't need to do recursion to solve this problem.

;;; I will just define remainder here, assuming the two parameters are all positive integers. Idea is that you keep substract divisor from dividend until dividend is smaller than divisor. 
(define my-remainder
  (lambda (dividend divisor)
    (if (< dividend divisor)
        dividend
        (my-remainder (- dividend divisor) divisor))))

;;; The list version: Sorry that I just realized it is not easy to implement with a single recursion. As we rotate "clockwise", it is hard to find the last element in the list.
;;; However a rotate anticlockwise version is easy to write and almost the same as the string-rotate-2. Pay attention to why we cannot modify string-rotate-1 and how to adapt string-append, substring to list. And why don't we need to use string-length anymore? 
(define list-rotate-anticlockwise
  (lambda (lst num)
    (if (= num 0)
        lst
      (list-rotate-anticlockwise (append (cdr lst) (list (car lst))) (- num 1)))))


;;; list reverse
;;; I omit the 4P here.

;;; Basic recursion
;;; Idea is that you produce the reserved cdr list, and put the first element of the list in the end. 
(define list-reverse
  (lambda (lst)
    (if (null? lst)
        '()
        (append (list-reverse (cdr lst)) (list (car lst))))))

;;; Tail recursion
;;; Idea is that I start from the beginning of the list, and reverse the list as I walk through the list.
(define list-reverse-2
  (lambda (lst)
    (list-reverse-helper '() lst)))

(define list-reverse-helper
  (lambda (so-far remaining)
    (if (null? remaining)
        so-far
        (list-reverse-helper (cons (car remaining) so-far) (cdr remaining)))))

;;; Swap Elements in Pairs
;;; The key idea is that you can swap the first two elements and then the work remaing is (swap-pairs (cdr (cdr lst))). I omit the 4P here. Also, pay attention that there are 2 base cases. (empty list and list with just one element)

(define swap-pairs
  (lambda (lst)
    (if (null? lst)
        '()
        (if (null? (cdr lst)) ;;; can we swap the two base case check here?
            lst ;;;why not (car lst)?
            (cons (cadr lst) (cons (car lst) (swap-pairs (cdr (cdr lst))))))))) ;;; why do I use cons? 

;;; Pascal Triangle
;;; This question is harder than normal level.
;;; The first elements in the two contious layers will always be the same; the last elements in the two contious layers will always be the same as well.
;;; The code does not deal with all the corner cases (e.g. empty list)

;;; next-layer:
(define next-layer
  (lambda (lst)
    (cons (car lst) (next-layer-helper lst))))

(define next-layer-helper
  (lambda (lst)
    (if (null? (cdr lst))
        lst
        (cons (+ (car lst) (cadr lst)) (next-layer-helper (cdr lst))))))

;;; prev-list:
;;; By valid input, I mean that there exists valid previous layer given the list representing the present layer. 
;;; I will work on this question later, and this question is clealy not required for any quizes.

;;; power
;;; I omit the 4P and precondition check here. 
;;; Here the base case is when n == 0. As n can be a negative number and we know that x^n = 1/(x^(-n)), we can work around negative n here.

(define my-power-helper
  (lambda (x n)
    (if (= 0 n)
        1
        (* x (my-power-helper x (- n 1))))))

(define my-power
  (lambda (x n)
    (if (< n 0)
        (/ 1 (my-power-helper x (- 0 n)))
        (my-power-helper x n))))
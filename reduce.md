# Reduce, reduce-left and reduce-right
Students are confused about [Exercise 6 in Lists lab](https://www.cs.grinnell.edu/~rebelsky/Courses/CSC151/2019S/labs/homogeneous-lists.html), so I think I should give more explanation on this. 
First, some defs: 
```scheme
(define combine
  (lambda (s1 s2)
    (string-append s1 " and " s2 " and " s1)))

(define letters
  (list  "c" "d" "e"))
```
And if you use ```reduce-right```: 
```scheme
> (reduce-right combine letters)
"c and d and e and d and c"
```
Recall that ```reduce-right``` starts processing from the right. Let's do a run through: 
```scheme
> (reduce-right combine (list  "c" "d" "e"))
; as "e" is the far right element in the list, "d" is the second, reduce executes   (combine "e" "d") first. Then the procedure is actually this: 
> (reduce-right combine (list  "c" "d and e and d"))
; and now reduce execute (combine "c" "d and e and d") and yeah we run out of the list. Therefore, we have our result now: 
> "c and d and e and d and c"

; Similarly, reduce-left picks "c" and "d" as the first two elements. 
> (reduce-left combine (list  "c" "d" "e"))
> (reduce-left combine (list  "c and d and c" "e"))
; Notice the "c and d and c" is now the str1 passed into combine procedure
> "c and d and c and e and c and d and c"
```





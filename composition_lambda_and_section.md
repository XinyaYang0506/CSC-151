# Composition, lambda, and section
@XinyaYang0506

I want discuss the difference between the following two code snippets. 
```scheme
> (define numwords
    (lambda (str)
      (length (string-split str " "))))
```
and
```scheme
> (define numwords (o length (section string-split <> " ")))
```
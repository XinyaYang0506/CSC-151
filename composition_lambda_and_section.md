# Composition, lambda, and section
by Xinya

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

Will the second one work without ``` (o ) ```? Why can the first one work without composition? It is worth noticing that composition is for two functions, or in CS sense, two procedures. In the first one, ```(string-split str " ")``` in lambda is a complete statement, which turns out to be a value as the parameter for ```(length number)```. However, for the second one, ```(section string-split <> " ")``` is still a procedure. You can test it by typing ```(section string-split <> " ")``` in the lower window and DrRacket should tell you this is a procedure. Therefore, in order to bridge bewteen ```(section string-split <> " ")``` and ```length``` which is a procedure itself, you need to use composition (aka ```(o proc1 proc2)```) which takes two procedures as parameters. 
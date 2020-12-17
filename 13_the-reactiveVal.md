13: Why reactivity?
================

## Interesante

> \[40 years ago\] I imagined a magic blackboard that if you erased one
> number and wrote a new thing in, all of the other numbers would
> automatically change, like word processing with numbers.

– Dan Bricklin ([Ted
talk](https://www.youtube.com/watch?v=YDvbDiJZpy0&feature=youtu.be))

## Desafio

Quiero una herramienta interactive y eficiente:

1.  Si los inputs cambian, los outputs cambian.
2.  Si los inputs no cambian, los outputs no cambian.
3.  Si los inputs no cambian, y el output ya fue calculado, no
    recalcula.

# Implementacion ingenua

``` r
output <- function() {
  message("Calculando") 
  input * 100
}
```

## 1. Si: Si los inputs cambian, los outputs cambian

``` r
input <- 10
output()
#> Calculando
#> [1] 1000

input <- 9
output()
#> Calculando
#> [1] 900
```

## 2. Si: Si los inputs no cambian, los outputs no cambian

``` r
input <- 9
output()
#> Calculando
#> [1] 900

input <- 9
output()
#> Calculando
#> [1] 900
```

## 3. No: Si los inputs no cambian, y el output ya fue calculado, no recalcula

``` r
input <- 9
output()
#> Calculando
#> [1] 900

input <- 9
output()
#> Calculando
#> [1] 900
```

# Interesante

Falla.

``` r
call_reactive <- reactive(1)
call_reactive()
#> Error: Operation not allowed without an active reactive context.
#> * You tried to do something that can only be done from inside a reactive consumer.
```

Funciona.

``` r
# remotes::install_github("rstudio/shiny")
packageVersion("shiny")
#> [1] '1.5.0.9005'
reactiveConsole(TRUE)

call_reactive <- reactive(1)
call_reactive()
#> [1] 1
```

# Implementación con shiny

``` r
input <- reactiveVal(0)
input()
#> [1] 0
input(1)
input()
#> [1] 1

output <- reactive({
  message("Calculando")
  input() * 100
})

output()
#> Calculando
#> [1] 100
```

## Si, Si, Si

``` r
# 1. Si: Si los inputs cambian, los outputs cambian.
input(10)
output()
#> Calculando
#> [1] 1000
input(9)
output()
#> Calculando
#> [1] 900

# 2. Si: los inputs no cambian, los outputs no cambian.
# 3. Si: Si los inputs no cambian, y el output ya fue calculado, no recalcula.
input(9)
output()
#> [1] 900
```

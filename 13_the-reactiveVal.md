13: Why reactivity?
================

``` r
library(shiny)
```

## Interesante

> \[40 years ago\] I imagined a magic blackboard that if you erased one
> number and wrote a new thing in, all of the other numbers would
> automatically change, like word processing with numbers.

– Dan Bricklin ([Ted
talk](https://www.youtube.com/watch?v=YDvbDiJZpy0&feature=youtu.be))

## Desafio

Quiero una herramienta interactive y eficiente:

-   Reactive expressions and outputs update if and only if their inputs
    change.

-   Outputs stay in sync with inputs, never doing more work than
    necessary.

## Implementacion ingenua

``` r
valor <- 10
out <- function() {
  message("Corriendo") 
  valor * 100
}
```

``` r
# Valor nuevo
valor <- 10
valor
#> [1] 10

# Corre?
out()
#> Corriendo
#> [1] 1000

# Corre?
out()
#> Corriendo
#> [1] 1000
out()
#> Corriendo
#> [1] 1000

# Valor nuevo
valor <- 9

# Corre?
out()
#> Corriendo
#> [1] 900

# Corre?
valor <- 9
out()
#> Corriendo
#> [1] 900
out()
#> Corriendo
#> [1] 900
```

## Shiny

## Interesante 2

Falla.

``` r
call_reactive <- reactive(1)
call_reactive()
#> Error: Operation not allowed without an active reactive context.
#> * You tried to do something that can only be done from inside a reactive consumer.
```

Funciona.

``` r
# shiny-devel
# remotes::install_github("rstudio/shiny")
reactiveConsole(TRUE)

call_reactive <- reactive(1)
call_reactive()
#> [1] 1
```

``` r
out <- reactive({
  message("Corriendo")
  valor() * 100
})
```

## Por que reactividad?

> Lazy: it doesn’t do any work until it’s called.

> Cached: it doesn’t do any work the second and subsequent times it’s
> called because it caches the previous result.

Ejemplo:

``` r
# Valor nuevo
valor <- reactiveVal(10)
valor()
#> [1] 10

# Corre?
out()
#> Corriendo
#> [1] 1000

# Corre?
out()
#> [1] 1000
out()
#> [1] 1000

# Valor nuevo
valor(9)

# Corre?
out()
#> Corriendo
#> [1] 900

# Corre?
valor(9)
out()
#> [1] 900
out()
#> [1] 900
```


<!-- README.md is generated from README.Rmd. Please edit that file -->

# promptr

<!-- badges: start -->
<!-- badges: end -->

The goal of `promptr` is to create a simple interface for `R` users to
format and submit prompts to OpenAI’s Large Language Models (LLMs).

## Installation

You can install the development version of promptr from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("joeornstein/promptr")
```

## Example

This is a basic example:

``` r
library(promptr)

prompt <- format_prompt(text = 'I am genuinely morose.', 
                        instructions = 'Classify this text as sad or happy.')
prompt
#> Classify this text as sad or happy.
#> 
#> Text: I am genuinely morose.
#> Classification:

complete_prompt(prompt)
#>    token probability
#> 1    Sad  0.30095155
#> 2    sad  0.18833067
#> 3  Happy  0.10985229
#> 4  happy  0.06662878
#> 5         0.03196884
```


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

prompt <- format_prompt(text = 'I am sad', 
                        instructions = 'Classify this text as sad or happy.')
prompt
#> Classify this text as sad or happy.
#> 
#> Text: I am sad
#> Classification:

complete_prompt(prompt)
#>    token probability
#> 1    sad  0.34807921
#> 2    Sad  0.28632215
#> 3  happy  0.07706258
#> 4  Happy  0.04710741
#> 5         0.04495020
```

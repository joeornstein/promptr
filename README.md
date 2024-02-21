
<!-- README.md is generated from README.Rmd. Please edit that file -->

# promptr <img src="man/figures/logo.png" align="right" height="89" />

<!-- badges: start -->
<!-- badges: end -->

The goal of `promptr` is to create a straightforward interface for `R`
users to format and submit prompts to OpenAI’s Large Language Models
(LLMs).

## Installation

You can install the development version of `promptr` from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("joeornstein/promptr")
```

## Example

The package workflow is built around two functions: `format_prompt()`
and `complete_prompt()`. The first allows you to format a prompt from
three inputs.

``` r
library(promptr)

prompt <- format_prompt(text = 'I feel positively morose.', 
                        instructions = 'Classify the following text as sad or happy.')
prompt
#> Classify the following text as sad or happy.
#> 
#> Text: I feel positively morose.
#> Classification:
```

This is a **zero-shot** prompt (no labeled examples provided).

Once you’ve formatted the prompt, you can submit it to an LLM through
the OpenAI API using the `complete_prompt()` function.

``` r
complete_prompt(prompt)
#>   token probability
#> 1   Sad 0.837170505
#> 2   sad 0.121762239
#> 3       0.029757389
#> 4   Sad 0.007920812
#> 5       0.001315101
```

Pretty good, but these models often perform better if we provide
few-shot examples.

``` r
examples <- data.frame(
  text = c('What a pleasant day!', 
           'Oh bother.',
           'Merry Christmas!',
           ':-('),
  label = c('happy', 'sad', 'happy', 'sad')
)

prompt <- format_prompt(
  text = 'I feel positively morose.', 
  instructions = 'Classify the following text as sad or happy.',
  examples = examples
  )

prompt
#> Classify the following text as sad or happy.
#> 
#> Text: What a pleasant day!
#> Classification: happy
#> 
#> Text: Oh bother.
#> Classification: sad
#> 
#> Text: Merry Christmas!
#> Classification: happy
#> 
#> Text: :-(
#> Classification: sad
#> 
#> Text: I feel positively morose.
#> Classification:

complete_prompt(prompt)
#>   token  probability
#> 1   sad 9.994194e-01
#> 2   sad 3.485589e-04
#> 3       6.669017e-05
#> 4   Sad 4.741163e-05
#> 5       2.732130e-05
```

The complete pipeline:

``` r
'What a joyous day for our adversaries.' |> 
  format_prompt(instructions = 'Classify this text as happy or sad.',
                examples = examples) |> 
  complete_prompt()
#>     token  probability
#> 1     sad 0.9931754130
#> 2   happy 0.0023576333
#> 3     sad 0.0021634900
#> 4     Sad 0.0007275062
#> 5 unhappy 0.0006792638
```

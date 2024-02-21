
<!-- README.md is generated from README.Rmd. Please edit that file -->

# promptr

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
#>    token probability
#> 1    Sad  0.32946914
#> 2    sad  0.22467843
#> 3  Happy  0.10949952
#> 4  happy  0.09439449
#> 5    Mor  0.01932781
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
#>      token probability
#> 1      sad 0.905665026
#> 2    happy 0.054389411
#> 3  unhappy 0.009089383
#> 4     very 0.002997360
#> 5      mor 0.001604371
```

The complete pipeline:

``` r
'What a joyous day...for our adversaries.' |> 
  format_prompt(instructions = 'Classify this text as happy or sad.',
                examples = examples) |> 
  complete_prompt()
#>      token probability
#> 1      sad  0.53916775
#> 2    happy  0.26690740
#> 3  neutral  0.03237954
#> 4    angry  0.02813183
#> 5  unhappy  0.01287969
```

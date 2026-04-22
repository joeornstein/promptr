# promptr 1.0.1

* Note: Since the release of the `ellmer` package, I have opted to lightly maintain this package. R users will find that `ellmer` is preferable for most use cases.
* `complete_chat()` now uses `max_completion_tokens` instead of the deprecated `max_tokens` parameter, fixing compatibility with newer OpenAI models.
* `complete_chat()` now warns when called with the default `max_tokens = 1` on a non-default model, as next-token probability prediction is not supported by more-recent "reasoning" models.

# promptr 1.0.0

* Initial CRAN submission.

#' Format a Large Language Model (LLM) prompt
#'
#' @param text The text to be classified
#' @param instructions Instructions to be included in the prompt (format them like you would format instructions to a human research assistant).
#' @param examples A dataframe of "few-shot" examples. Must include one column called 'text' with the example text(s) and another column called "label" with the correct label(s).
#' @param template The template for how examples and completions should be formatted, in `glue` syntax. If you are including few-shot examples in the prompt, this must contain the \{text\} and \{label\} placeholders.
#' @param prompt_template The template for the entire prompt. Defaults to instructions, followed by few-shot examples, followed by the input to be classified.
#' @param separator A character that separates examples. Defaults to two carriage returns.
#'
#' @return Returns a formatted prompt that can be used as input for `complete_prompt()`.
#' @export
#'
#' @examples
#' data(scotus_tweets_examples)
#'
#' format_prompt(text = "I am disappointed with this ruling.",
#'               instructions = "Decide whether the sentiment of this statement is Positive or Negative.",
#'               examples = scotus_tweets_examples,
#'               template = "Statement: {text}\nSentiment: {label}")
#'
#' format_prompt(text = 'I am sad about the Supreme Court',
#'               examples = scotus_tweets_examples,
#'               template = '"{text}" is a {label} statement',
#'               separator = '\n')
format_prompt <- function(text,
                          instructions = '',
                          examples = data.frame(),
                          template = 'Text: {text}\nClassification: {label}',
                          prompt_template = '{instructions}{examples}{input}',
                          separator = '\n\n'){

  # convert examples dataframe to string
  if(nrow(examples) == 0){
    examples <- ''
  } else{
    examples <- examples |>
      dplyr::mutate(prompt_segment = glue::glue(template)) |>
      dplyr::pull(prompt_segment) |>
      paste(collapse = separator) |>
      paste0(separator)
  }

  # add separator to instructions
  if(nchar(instructions) > 0){
    instructions <- paste0(instructions, separator)
  }

  # format input using template (removing the {label} tag and anything after it)
  input <- template |>
    stringr::str_replace('\\{label\\}.*', '') |>
    stringr::str_trim() |>
    glue::glue()

  # glue together the complete prompt template
  glue::glue(prompt_template)

}

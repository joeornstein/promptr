#' Complete an LLM Prompt
#'
#' @description
#' Submits a text prompt to OpenAI's "Completion" API endpoint and formats the response into a string or tidy dataframe. (Note that, as of 2024, this endpoint is considered "Legacy" by OpenAI and is likely to be deprecated.)
#'
#'
#' @param prompt The prompt
#' @param model  Which OpenAI model to use. Defaults to 'gpt-3.5-turbo-instruct'
#' @param openai_api_key Your API key. By default, looks for a system environment variable called "OPENAI_API_KEY" (recommended option). Otherwise, it will prompt you to enter the API key as an argument.
#' @param max_tokens How many tokens (roughly 4 characters of text) should the model return? Defaults to a single token (next word prediction).
#' @param temperature A numeric between 0 and 2 When set to zero, the model will always return the most probable next token. For values greater than zero, the model selects the next word probabilistically.
#' @param seed An integer. If specified, the OpenAI API will "make a best effort to sample deterministically".
#' @param parallel TRUE to submit API requests in parallel. Setting to FALSE can reduce rate limit errors at the expense of longer runtime.
#'
#' @return If max_tokens = 1, returns a dataframe with the 5 most likely next words and their probabilities. If max_tokens > 1, returns a single string of text generated by the model.
#' @export
#'
#' @examples \dontrun{
#' complete_prompt('I feel like a')
#' complete_prompt('Here is my haiku about frogs:',
#'                 max_tokens = 100)
#' }
complete_prompt <- function(prompt,
                            model = 'gpt-3.5-turbo-instruct',
                            openai_api_key = Sys.getenv('OPENAI_API_KEY'),
                            max_tokens = 1,
                            temperature = 0,
                            seed = NULL,
                            parallel = FALSE) {

  if(openai_api_key == ''){
    stop("No API key detected in system environment. You can enter it manually using the 'openai_api_key' argument.")
  }

  # function to return a formatted API request -----------------
  format_request <- function(prompt,
                             base_url = "https://api.openai.com/v1/completions"){

    logprobs <- NULL
    if(max_tokens == 1) logprobs <- 5

    httr2::request(base_url) |>
      # headers
      httr2::req_headers('Authorization' = paste("Bearer", openai_api_key)) |>
      httr2::req_headers("Content-Type" = "application/json") |>
      # body
      httr2::req_body_json(list(model = model,
                                prompt = prompt,
                                temperature = temperature,
                                max_tokens = max_tokens,
                                logprobs = logprobs,
                                seed = seed))
  }

  # split the prompt into chunks; the API will accept 2048 at most
  chunks <- split(prompt, ceiling(seq_along(prompt) / 2048))

  # format requests
  reqs <- lapply(chunks, format_request)

  # submit prompts sequentially or in parallel
  if(parallel){
    # 20 concurrent requests per host seems to be the optimum
    resps <- httr2::req_perform_parallel(reqs, pool = curl::new_pool(host_con = 20))
  } else{
    resps <- httr2::req_perform_sequential(reqs)
  }

  # parse the responses
  parsed <- resps |>
    lapply(httr2::resp_body_string) |>
    lapply(jsonlite::fromJSON, flatten=TRUE)


  # if max_tokens > 1, return the text
  to_return <- unlist(lapply(parsed, function(x) x$choices$text))

  # if max_tokens == 1, return a tidy dataframe of probabilities for each prompt
  if(max_tokens == 1){
    # get list of logprobs
    top_logprobs <- parsed |>
      lapply(function(x) x$choices$logprobs.top_logprobs) |>
      unlist(recursive = FALSE)

    # convert to list of dataframes
    tokens <- lapply(top_logprobs, names)
    logprobs <- lapply(top_logprobs, as.numeric)

    to_return <- Map(function(token,logprob){
      data.frame(token = trimws(token),
                 probability = exp(logprob))
    }, tokens, logprobs)

    # don't return it as a list if there's only one prompt in the input
    if(length(prompt) == 1){
      to_return <- to_return[[1]]
    }
  }

  return(to_return)

}

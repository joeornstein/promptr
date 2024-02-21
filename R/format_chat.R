#' Format a Chat Prompt
#'
#' @description
#' Format a chat prompt to submit to OpenAI's ChatGPT or GPT-4 (particularly useful for classification tasks).
#'
#' @param text The text to be classified.
#' @param instructions Instructions to be included at the beginning of the prompt (format them like you would format instructions to a human research assistant).
#' @param examples A dataframe of "few-shot" examples. Must include one column called 'text' with the example text(s) and another column called "label" with the correct label(s).
#' @param system_message An optional "system message" with high-level instructions (e.g. "You are a helpful research assistant.")
#'
#' @return Returns a series of messages formatted as a list object, which can be used as an input for promptr::complete_chat() or openai::create_chat_completion().
#' @export
#'
#' @examples
#' data(scotus_tweets_examples)
#'
#' format_chat(text = "I am disappointed with this ruling.",
#'                    instructions = "Decide if the statement is Positive or Negative.",
#'                    examples = scotus_tweets_examples)
format_chat <- function(text, instructions = NA,
                        examples = data.frame(),
                        system_message = NA){

  # initialize empty list
  result <- list()

  # start with system message (if applicable)
  if(!is.na(system_message)){
    result[[length(result) + 1]] <- list('role' = 'system',
                                         'content' = system_message)
  }

  # add instructions
  if(!is.na(instructions)){
    result[[length(result) + 1]] <- list('role' = 'user',
                                         'content' = instructions)
  }

  # loop through examples, formatting as user/assistant responses
  if(nrow(examples) > 0){
    for(i in 1:nrow(examples)){
      user_entry <- list('role' = 'user', 'content' = examples$text[i])
      assistant_entry <- list('role' = 'assistant', 'content' = examples$label[i])

      result[[length(result) + 1]] <- user_entry
      result[[length(result) + 1]] <- assistant_entry
    }
  }

  # add the text to be classified
  result[[length(result) + 1]] <- list('role' = 'user',
                                       'content' = text)

  return(result)

}

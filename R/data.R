#' Tweets About The Supreme Court of the United States
#'
#' This dataset contains 945 tweets referencing the US Supreme Court.
#' Roughly half were collected on June 4, 2018 following the *Masterpiece Cakeshop*
#' ruling, and the other half were collected on July 9, 2020 following the
#' Court's concurrently released opinions in *Trump v. Mazars* and *Trump v. Vance*.
#' Each tweet includes three independent human-coded sentiment scores (-1 to +1).
#'
#' CONTENT WARNING: These texts come from social media, and many contain explicit
#' or offensive language.
#'
#' @docType data
#'
#' @usage data(scotus_tweets)
#'
#' @format
#' A data frame with 945 rows and 5 columns:
#' \describe{
#'  \item{tweet_id}{A unique ID}
#'  \item{text}{The text of the tweet}
#'  \item{case}{An identifier denoting which Supreme Court ruling the tweet was collected after.}
#'  \item{expert1, expert2, expert3}{Hand-coded sentiment score (-1 = negative, 0 = neutral, 1 = positive)}
#' }
#'
#' @keywords datasets
#'
#' @references Ornstein et al. (2024). "How To Train Your Stochastic Parrot"
"scotus_tweets"


#' Labelled Example Tweets About The Supreme Court of the United States
#'
#' This dataset contains 12 example tweets referencing the Supreme Court
#' along with a sentiment label. These can be used as few-shot prompt
#' examples for classifying tweets in the `scotus_tweets` dataset.
#'
#' @docType data
#'
#' @usage data(scotus_tweets_examples)
#'
#' @format
#' A data frame with 12 rows and 4 columns:
#' \describe{
#'  \item{tweet_id}{A unique ID for each tweet}
#'  \item{text}{The text of the tweet}
#'  \item{case}{The case referenced in the tweet (Masterpiece Cakeshop or Trump v. Mazars)}
#'  \item{label}{The "true" label (Positive, Negative, or Neutral)}
#' }
#'
#' @keywords datasets
#'
#' @references Ornstein et al. (2023). "How To Train Your Stochastic Parrot"
"scotus_tweets_examples"

#' Occupations
#'
#' This dataset contains 3,948 ballot designations from municipal elections in California.
#' A random subset are hand-labeled as either "Working Class" or "Not Working Class" occupations.
#'
#' @docType data
#'
#' @usage data(occupations)
#'
#' @format
#' A data frame with 3948 rows and 2 columns:
#' \describe{
#'  \item{baldesig}{Ballot designation as it appears in the CEDA dataset}
#'  \item{hand_coded}{A hand-coded occupation classification (for a random subset)}
#' }
#'
#' @keywords datasets
#'
#' @references California Elections Data Archive (CEDA). https://hdl.handle.net/10211.3/210187
"occupations"


#' Labelled Occupations
#'
#' This dataset contains 9 example occupations
#' along with a classification. These can be used as few-shot
#' examples for classifying occupations in the `occupations` dataset.
#'
#' @docType data
#'
#' @usage data(occupations_examples)
#'
#' @format
#' A data frame with 9 rows and 2 columns:
#' \describe{
#'  \item{text}{The text of the ballot designation}
#'  \item{label}{The hand-coded label (Working Class, Not Working Class, NA)}
#' }
#'
#' @keywords datasets
#'
#' @references California Elections Data Archive (CEDA). https://hdl.handle.net/10211.3/210187
"occupations_examples"

#' Get legislative speech
#'
#' @description
#' \code{get_speech()} extracts speech data by deputy.
#'
#' @param dep_id A deputy's ID.
#' @param ... query parameters.
#'
#' @return A \code{tibble}.
#'
#' @export

get_speech <- function(dep_id, ...){

  query <- c(as.list(environment()), list(...))
  query$itens <- 100
  query$dep_id <- NULL
  httr::modify_url("https://dadosabertos.camara.leg.br/", path = paste0("api/v2/deputados/", dep_id, "/discursos")) %>%
    get_data(data_frame = FALSE, query = query)
}


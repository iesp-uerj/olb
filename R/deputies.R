#' Get a list of all deputies
#'
#' @description
#' \code{get_deputies_list()} extracts a list of national deputies in Bazil.
#'
#' @param ... query parameters.
#'
#' @return A \code{tibble}.
#'
#' @export

get_deputies_list <- function(...){

  query <- c(as.list(environment()), list(...))
  get_data("https://dadosabertos.camara.leg.br/api/v2/deputados", query)
}



#' Get a deputy's bio
#'
#' @description
#' \code{get_deputy_bio()} extracts a deputy's biography.
#'
#' @param dep_id A deputy's ID.
#'
#' @return A \code{tibble}.
#'
#' @export

get_deputy_bio <- function(dep_id){

  httr::modify_url("https://dadosabertos.camara.leg.br/", path = paste0("api/v2/deputados/", dep_id)) %>%
    get_data(data_frame = TRUE)
}



#' Get a deputy's bio
#'
#' @description
#' \code{get_deputies_bios()} extracts the biography of all seating deputies.
#'
#' @param ... query parameters passed to the get_deputies_list call (inside the function).
#'
#' @return A \code{tibble}.
#'
#' @export

get_deputies_bios <- function(...){

  get_deputies_list(...) %>%
    .$id %>%
    purrr::map(get_deputy_bio) %>%
    dplyr::bind_rows()
}

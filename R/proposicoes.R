#' Arrange data on legislative bills introduced in a given period
#'
#' @description
#' \code{proposicoes()} cleans data on legislative bills introduced in a given period.
#'
#' @param ini Starting date in the YYYY-MM-DD format (\code{character}).
#' @param end Ending date in the YYYY-MM-DD format (\code{character}).
#'
#' @importFrom rlang .data
#'
#' @return A \code{data.frame} containing selected information for each bill introduced in a given year.
#'
#' @export

proposicoes <- function(ini, end){

  # Inputs
  ini <- as.POSIXct(ini)
  end <- as.POSIXct(end)
  stopifnot(ini > as.POSIXct("1985-01-01") & end <= lubridate::today())

  # Gather data
  message("\nCollecting necessary data (this may take a while)...")
  props <- lubridate::year(ini):lubridate::year(end) %>%
    purrr::map(pega_props) %>%
    dplyr::bind_rows()

  temas <- lubridate::year(ini):lubridate::year(end) %>%
    purrr::map(pega_tema) %>%
    dplyr::bind_rows()

  # Return
  message("Done.\n")
  dplyr::left_join(props, temas, by = c("ano" = "ano", "numero" = "numero", "siglaTipo" = "siglaTipo")) %>%
      dplyr::filter(.data$dataApresentacao >= ini & .data$dataApresentacao <= end)
}


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

  ini <- as.POSIXct(ini)
  end <- as.POSIXct(end)

  message("\nCollecting necessary data (this may take a while)...")

  # Scenario 1: ini date > 2018-12-31
  if(ini > as.POSIXct("2018-12-31")){

    proposicoes <- pega_props(2019) %>%
      dplyr::filter(.data$dataApresentacao >= ini & .data$dataApresentacao <= end)
  }

  # Scenario 2: ini date <= 2018-12-31
  else {

    proposicoes <- pega_props(2019) %>%
      dplyr::bind_rows(propos) %>%
      dplyr::filter(.data$dataApresentacao >= ini & .data$dataApresentacao <= end)
  }

  message("Done.\n")
  proposicoes
}


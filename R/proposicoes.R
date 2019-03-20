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

  #stopifnot(
  #
  #)

  message("\nCollecting necessary data (this may take a while)...")

  # Scenario 1: ini date > 2018-12-31
  if(ini > as.POSIXct("2018-12-31")){

    proposicoes <- pega_props(2019) %>%
      dplyr::left_join(
        pega_tema(2019),
        by = c("ano" = "ano", "numero" = "numero", "siglaTipo" = "siglaTipo")
      ) %>%
      dplyr::filter(.data$dataApresentacao >= ini & .data$dataApresentacao <= end)
  }

  # Scenario 2: ini date <= 2018-12-31 & end date > 2018-12-31
  else if(ini <= as.POSIXct("2018-12-31") & end > as.POSIXct("2018-12-31")) {

    proposicoes <- pega_props(2019) %>%
      dplyr::left_join(
        pega_tema(2019),
        by = c("ano" = "ano", "numero" = "numero", "siglaTipo" = "siglaTipo")
      ) %>%
      dplyr::bind_rows(propos) %>%
      dplyr::filter(.data$dataApresentacao >= ini & .data$dataApresentacao <= end)
  }

  # Scenario 3: ini and end <= 2018-12-31
  else if(ini <= as.POSIXct("2018-12-31") & end <= as.POSIXct("2018-12-31")) {

    proposicoes <- propos %>%
      dplyr::filter(.data$dataApresentacao >= ini & .data$dataApresentacao <= end)
  }

  message("Done.\n")
  proposicoes
}


#' Extract legislative bills' classification
#'
#' @description
#' \code{pega_tema()} is a convenience function used to download data on legislative bills's
#' classification from the Brazilian Chamber of Deputies' website.
#'
#' @param year Year in YYYY format (\code{character} or \code{numeric}).
#'
#' @return A \code{data.frame}.
#'
#' @examples
#' \dontrun{
#' # Get information for all bills in 2010
#' pega_tema(2010)
#' }
#'
#' @export

pega_tema <- function(year){

  suppressMessages(

    sprintf("https://dadosabertos.camara.leg.br/arquivos/proposicoesTemas/csv/proposicoesTemas-%s.csv", year) %>%
      readr::read_delim(delim = ";") %>%
      dplyr::select(.data$tema, .data$ano, .data$numero, .data$siglaTipo)
  )
}


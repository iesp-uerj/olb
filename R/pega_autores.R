#' Get authors of legislative bills
#'
#' @description
#' \code{pega_autores()} is a convenience function used to download data about the authors of the legislative
#' bills introduced in the Brazilian Chamber of Deputies' website.
#'
#' @param year Year in YYYY format (\code{character} or \code{numeric}).
#'
#' @return A \code{data.frame}.
#'
#' @examples
#' \dontrun{
#' # Get information for all bills in 2010
#' pega_autores(2010)
#' }
#'
#' @export

pega_autores <- function(year){

  suppressMessages(

    sprintf("https://dadosabertos.camara.leg.br/arquivos/proposicoesAutores/csv/proposicoesAutores-%s.csv", year) %>%
      readr::read_delim(delim = ";")
  )
}

#' Extract legislative bills from the Brazilian Chamber of Deputies' website
#'
#' @description
#' \code{pega_propos()} is a convenience function used to download data on legislative bills.
#'
#' @param year Year in YYYY format (\code{character} or \code{numeric}).
#'
#' @importFrom rlang .data
#'
#' @return A \code{data.frame} containing information for each bill proposed in a given year.
#'
#' @examples
#' \dontrun{
#' # Get information on all bills in 2010
#' pega_propos(2010)
#' }
#'
#' @export

pega_props <- function(year){

  suppressMessages(

    sprintf("https://dadosabertos.camara.leg.br/arquivos/proposicoes/csv/proposicoes-%s.csv", year) %>%
      readr::read_delim(delim = ";") %>%
      dplyr::select(.data$ano, .data$id, .data$numero, .data$siglaTipo, .data$dataApresentacao,
                    .data$ementa, .data$ementaDetalhada, .data$keywords, .data$urlInteiroTeor,
                    .data$ultimoStatus_dataHora, .data$ultimoStatus_siglaOrgao, .data$ultimoStatus_regime,
                    .data$ultimoStatus_descricaoTramitacao) %>%
      dplyr::filter(.data$siglaTipo %in% c("PL", "PLP", "PEC", "PLV", "MPV"))
  )
}


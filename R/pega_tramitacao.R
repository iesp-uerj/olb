#' Extract information about the legislative activity of a given bill
#'
#' @description
#' \code{pega_tramitacao()} extracts information about the activity of a given legislative bill introduced in the
#' Brazilian Chamber of Deputies.
#'
#' @param id_prop Bill ID as used by the Brazilian Chamber of Deputies (\code{character} or \code{numeric}).
#'
#'
#' @return A \code{data.frame} containing information for a given bill.
#'
#' @examples
#' \dontrun{
#' # Get information on a given bill
#' tramitacao(id_prop = 123)
#' }
#'
#' @export

tramitacao <- function(id_prop){

  sprintf("https://dadosabertos.camara.leg.br/api/v2/proposicoes/%s/tramitacoes", id_prop) %>%
    httr::GET() %>%
    httr::content() %>%
    .$dados %>%
    purrr::map(purrr::compact) %>%
    dplyr::bind_rows() %>%
    dplyr::mutate(id_prop = id_prop)
}

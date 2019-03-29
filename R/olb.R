#' Collect data to produce legislative reports by topic
#'
#' @description
#' \code{proposals_track_report()} gathers a dataset with all the information required to produce
#' OLB's legislative reports by topic.
#'
#' @param dataInicio Start date (in YYYY-MM-DD format, as \code{character}).
#' @param dataFim End date (in YYYY-MM-DD format, as \code{character}).
#' @param codTema Topic code (use \code{\link{list_topics}} to obtain a list of all valid topic codes).
#'
#' @return A \code{tibble} with some \code{nested} columns.
#'
#' @export

proposals_track_report <- function(dataInicio, dataFim, codTema){

  get_proposals_olb(dataInicio = dataInicio, dataFim = dataFim, codTema = codTema) %>%
    dplyr::mutate(detalhes = purrr::map(.$id, get_proposal)) %>%
    dplyr::mutate(autor = purrr::map(.$id, get_proposal_author)) %>%
    dplyr::mutate(tramitacao = purrr::map(.$id, get_proposal_history)) %>%
    dplyr::mutate(relacionadas = purrr::map(.$id, get_related_proposals))
}


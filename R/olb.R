#' Collect data to update the OLB's legislative monitor
#'
#' @description
#' \code{get_monitor_data()} gathers a dataset with all the information required to produce
#' OLB's llegislative monitor.
#'
#' @param dataInicio Start date (in YYYY-MM-DD format, as \code{character}).
#' @param dataFim End date (in YYYY-MM-DD format, as \code{character}).
#' @param codTema Topic code (use \code{\link{list_topics}} to obtain a list of all valid topic codes).
#'
#' @return A \code{tibble} with some \code{nested} columns.
#'
#' @importFrom rlang .data
#'
#' @export

get_monitor_data <- function(dataInicio, dataFim, codTema){

  # Util
  is_zero <- function(x) length(x) == 0

  # Main data
  props <- get_proposals_olb(dataInicio = dataInicio, dataFim = dataFim, codTema = codTema) %>%
    dplyr::select(.data$id, .data$siglaTipo, .data$codTipo, .data$numero, .data$ano, .data$ementa) %>%
    dplyr::mutate(detalhes = purrr::map(.$id, get_proposal)) %>%
    dplyr::mutate(inteiroteor = purrr::map(.$detalhes, ~ .$urlInteiroTeor) %>% as.character) %>%
    dplyr::select(-.data$detalhes)

  # Track
  trams <- props %>%
    dplyr::mutate(tramitacao = purrr::map(.$id, get_proposal_history)) %>%
    tidyr::unnest(.data$tramitacao)

  # Related
  relac <- props %>%
    dplyr::mutate(relacionadas = purrr::map(.$id, get_related_proposals)) %>%
    dplyr::mutate(relacionadas = purrr::map_if(.$relacionadas, is_zero, data.frame)) %>%
    tidyr::unnest(.sep = "_") %>%
    dplyr::mutate(data_relacionada = purrr::map(.data$relacionadas_id, get_proposal)) %>%
    dplyr::mutate(data_relacionada = purrr::map(.data$data_relacionada, ~ .$dataApresentacao) %>% as.character %>% as.Date)

  # Intro
  intro <- get_proposals_olb(dataApresentacaoInicio = dataInicio, dataApresentacaoFim = dataFim, codTema = codTema) %>%
    dplyr::select(.data$id, .data$siglaTipo, .data$codTipo, .data$numero, .data$ano, .data$ementa) %>%
    dplyr::mutate(detalhes = purrr::map(.$id, get_proposal)) %>%
    dplyr::mutate(dataApresentacao = purrr::map(.$detalhes, ~ .$dataApresentacao) %>% as.character) %>%
    dplyr::mutate(dataApresentacao = as.Date(.data$dataApresentacao)) %>%
    dplyr::group_by(.data$dataApresentacao) %>%
    dplyr::summarise(n = dplyr::n())

  # Return
  list(props = props, trams = trams, relac = relac, intro = intro)
}

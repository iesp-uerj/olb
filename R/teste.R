get_monitor_data <- function(dataInicio, dataFim, codTema){


  # Util
  is_zero <- function(x) length(x) == 0

  # Longitudinal data
  long <- get_proposals_olb(dataApresentacaoInicio = "1998-01-01", dataApresentacaoFim = dataFim, codTema = codTema) %>%
    dplyr::select(.data$id, .data$siglaTipo, .data$codTipo, .data$numero, .data$ano, .data$ementa)

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


  # Authors


  # Return
  list(long = long, props = props, trams = trams, relac = relac)
}

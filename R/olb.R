#' Collect data to produce legislative reports by topic
#'
#' @description
#' \code{get_track_report_data()} gathers a dataset with all the information required to produce
#' OLB's legislative reports by topic.
#'
#' @param dataInicio Start date (in YYYY-MM-DD format, as \code{character}).
#' @param dataFim End date (in YYYY-MM-DD format, as \code{character}).
#' @param codTema Topic code (use \code{\link{list_topics}} to obtain a list of all valid topic codes).
#'
#' @return A \code{tibble} with some \code{nested} columns.
#'
#' @export

get_track_report_data <- function(dataInicio, dataFim, codTema){

  get_proposals_olb(dataInicio = dataInicio, dataFim = dataFim, codTema = codTema) %>%
    dplyr::mutate(detalhes = purrr::map(.$id, get_proposal)) %>%
    dplyr::mutate(autor = purrr::map(.$id, get_proposal_author)) %>%
    dplyr::mutate(tramitacao = purrr::map(.$id, get_proposal_history)) %>%
    dplyr::mutate(relacionadas = purrr::map(.$id, get_related_proposals))
}


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


  # Return
  list(long = long, props = props, trams = trams, relac = relac)
}




#' Collect all the data to create OLB's legislative monitor
#'
#' @description
#' \code{build_monitor_data()} create a dataset with the required data to update the OLB's monitor website.
#'
#' @importFrom rlang .data
#'
#' @export

build_monitor_data <- function(){


  # Check whether there are previous data
  if(!file.exists("dados_monitor.Rda")) {

    # Dates
    fim <- lubridate::today()
    ini <- fim - 30

    # Get topics' data
    ciencia_tecnologia <- get_monitor_data(ini, fim, 62)
    economia <- get_monitor_data(ini, fim, 40)
    direitos_humanos <- get_monitor_data(ini, fim, 44)
    meio_ambiente <- get_monitor_data(ini, fim, 48)
    previdencia <- get_monitor_data(ini, fim, 52)
    saude <- get_monitor_data(ini, fim, 56)
    educacao <- get_monitor_data(ini, fim, 46)
    defesa_seguranca <- get_monitor_data(ini, fim, 57)

    # Export
    save(ciencia_tecnologia,
         economia,
         direitos_humanos,
         meio_ambiente,
         previdencia,
         saude,
         educacao,
         defesa_seguranca,
         file = paste0("dados_monitor.Rda"))

  } else {


    # Manage dates
    fim <- lubridate::today()
    inicio_filter <- fim - 30
    inicio <- as.Date(file.info("dados_monitor.Rda")$ctime)
    if(fim == inicio) return()
    inicio <- inicio + 1

    # Load previous data
    load("dados_monitor.Rda")

    # Get topics' data
    ciencia_tecnologia <- dplyr::bind_rows(ciencia_tecnologia, get_monitor_data(ini, fim, 62))
    economia <- dplyr::bind_rows(economia, get_monitor_data(ini, fim, 40))
    direitos_humanos <- dplyr::bind_rows(direitos_humanos, get_monitor_data(ini, fim, 44))
    meio_ambiente <- dplyr::bind_rows(meio_ambiente, get_monitor_data(ini, fim, 48))
    previdencia <- dplyr::bind_rows(previdencia, get_monitor_data(ini, fim, 52))
    saude <- dplyr::bind_rows(saude, get_monitor_data(ini, fim, 56))
    educacao <- dplyr::bind_rows(educacao, get_monitor_data(ini, fim, 46))
    defesa_seguranca <- dplyr::bind_rows(defesa_seguranca, get_monitor_data(ini, fim, 57))


    # Export
    save(ciencia_tecnologia,
         economia,
         direitos_humanos,
         meio_ambiente,
         previdencia,
         saude,
         educacao,
         defesa_seguranca,
         file = paste0("dados_monitor.Rda"))
  }
}

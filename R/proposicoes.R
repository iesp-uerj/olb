#' Arrange data on legislative bills introduced in a given period
#'
#' @description
#' \code{proposicoes()} cleans data on legislative bills introduced in a given period.
#'
#' @param ini Starting date in the YYYY-MM-DD format (\code{character}).
#' @param end Ending date in the YYYY-MM-DD format (\code{character}).
#'
#' @importFrom rlang .data
#' @importFrom rlang :=
#'
#' @return A \code{data.frame} containing selected information for each bill introduced in a given year.
#'
#' @export

proposicoes <- function(ini, end){

  # Inputs
  ini <- as.POSIXct(ini)
  end <- as.POSIXct(end)
  stopifnot(ini > as.POSIXct("1985-01-01") & end <= lubridate::today())

  # Gather data
  message("\nGathering necessary data (this may take a while)...")
  props <- lubridate::year(ini):lubridate::year(end) %>%
    purrr::map(pega_props) %>%
    dplyr::bind_rows()

  temas <- lubridate::year(ini):lubridate::year(end) %>%
    purrr::map(pega_tema) %>%
    dplyr::bind_rows()

  autores <- lubridate::year(ini):lubridate::year(end) %>%
    purrr::map(pega_autores) %>%
    dplyr::bind_rows()

  autores_tidy <- autores %>%
    dplyr::group_by(.data$id) %>%
    dplyr::mutate(!!"nome" := dplyr::case_when(

      dplyr::n() > 1 ~ "Varios autores",
      .data$tipo == "Deputado" & dplyr::n() == 1 ~ paste0(.data$nome, " (", .data$partido, "/", .data$uf, ")"),
      .data$tipo == "Senador" & dplyr::n() == 1 ~ paste0(.data$nome, " (", .data$partido, "/", .data$uf, ")"),
      TRUE ~ "Outros"
    )) %>%
    dplyr::summarise(!!"autor" := .data$nome[1])


  # Return
  message("Done.\n")

  base <- dplyr::left_join(props, temas, by = c("ano" = "ano", "numero" = "numero", "siglaTipo" = "siglaTipo")) %>%
    dplyr::filter(.data$dataApresentacao >= ini & .data$dataApresentacao <= end) %>%
    dplyr::left_join(autores_tidy, by = c("id" = "id"))

  autores <- autores %>%
    dplyr::filter(.data$id %in% base$id) %>%
    dplyr::filter(.data$tipo == "Deputado") %>%
    dplyr::left_join(

      dplyr::select(base, .data$id, .data$numero, .data$siglaTipo, .data$dataApresentacao, .data$ementa,
                    .data$tema, .data$urlInteiroTeor),
      by = c("id" = "id")
    )

  list(props = base, autores = autores)
}


#' Get a list of proposals
#'
#' @description
#' \code{get_proposal_list()} extracts a list of proposals introduced in the Brazilian Chamber of Deputies.
#'
#' @param ... query parameters.
#'
#' @return A \code{tibble}.
#'
#' @export

get_proposal_list <- function(...){

  query <- c(as.list(environment()), list(...))
  query$itens <- 100
  dados <- get_data("https://dadosabertos.camara.leg.br/api/v2/proposicoes", query = query, single_page = FALSE)
}



#' Get a legislative proposal
#'
#' @description
#' \code{get_proposal()} extracts detailed information about a given legislative proposal.
#'
#' @param id Proposal id.
#'
#' @return A \code{tibble}.
#'
#' @export

get_proposal <- function(id){

  httr::modify_url("https://dadosabertos.camara.leg.br/", path = paste0("api/v2/proposicoes/", id)) %>%
    get_data(data_frame = TRUE)
}



#' Get a list of proposals related to a certain one
#'
#' @description
#' \code{get_related_proposals()} a list of proposals related to a given legislative proposal.
#'
#' @param id Main proposal id.
#'
#' @return A \code{tibble}.
#'
#' @export

get_related_proposals <- function(id){

  httr::modify_url("https://dadosabertos.camara.leg.br/", path = paste0("api/v2/proposicoes/", id, "/relacionadas")) %>%
    get_data(data_frame = FALSE)
}



#' Get the topics of a certain proposal
#'
#' @description
#' \code{get_proposal_topic()} a list of topics related to a given legislative proposal.
#'
#' @param id Main proposal id.
#'
#' @return A \code{tibble}.
#'
#' @export

get_proposal_topic <- function(id){

  httr::modify_url("https://dadosabertos.camara.leg.br/", path = paste0("api/v2/proposicoes/", id, "/temas")) %>%
    get_data(data_frame = FALSE)
}




#' Get the history of a certain proposal
#'
#' @description
#' \code{get_proposal_history()} extracts a list of the situations of a given legislative proposal.
#'
#' @param id Main proposal id.
#'
#' @return A \code{tibble}.
#'
#' @export

get_proposal_history <- function(id){

  httr::modify_url("https://dadosabertos.camara.leg.br/", path = paste0("api/v2/proposicoes/", id, "/tramitacoes")) %>%
    get_data(data_frame = FALSE)
}



#' Get the authors of a certain proposal
#'
#' @description
#' \code{get_proposal_author()} extracts a list of authors of a given legislative proposal.
#'
#' @param id Main proposal id.
#'
#' @return A \code{tibble}.
#'
#' @export

get_proposal_author <- function(id){

  httr::modify_url("https://dadosabertos.camara.leg.br/", path = paste0("api/v2/proposicoes/", id, "/autores")) %>%
    get_data(data_frame = FALSE)
}



#' Get a list of proposals of a given type
#'
#' @description
#' \code{get_proposals_olb()} extracts a list of PEC, PL, MPV, and PLP introduced in the Brazilian Chamber of Deputies.
#'
#' @param ... query parameters.
#'
#' @return A \code{tibble}.
#'
#' @export

get_proposals_olb <- function(...){

  query <- c(as.list(environment()), list(...))
  query$itens <- 100
  query$siglaTipo <- "PL,MPV,PLP,PEC"
  get_data("https://dadosabertos.camara.leg.br/api/v2/proposicoes", query = query, single_page = FALSE)
}


#' List all the topics of legislative bills
#'
#' @description
#' \code{list_ropics()} returns a \code{tibble} with a list of topics used by the Brazilian Chamber
#' of Deputies to classify legislative bills.
#'
#' @return A \code{tibble}.
#'
#' @export

list_topics <- function(){

  get_data("https://dadosabertos.camara.leg.br/api/v2/referencias/proposicoes/codTema")
}



#' List all the possible situations of legislative bills
#'
#' @description
#' \code{list_ropics()} returns a \code{tibble} with a list of situations used by the Brazilian Chamber
#' of Deputies to track legislative bills.
#'
#' @return A \code{tibble}.
#'
#' @export

list_proposal_situations <- function(){

  get_data("https://dadosabertos.camara.leg.br/api/v2/referencias/proposicoes/codSituacao")
}




#' Pipe operator
#'
#' See \code{magrittr::\link[magrittr]{\%>\%}} for details.
#'
#' @name %>%
#' @rdname pipe
#' @keywords internal
#' @export
#' @importFrom magrittr %>%
#' @usage lhs \%>\% rhs
NULL


# Function to parse Chamber's json
json_camara <- function(pag, data_frame = FALSE){

  dados <- pag %>%
    httr::content(type = "text", encoding = "UTF-8") %>%
    jsonlite::fromJSON(flatten = T) %>%
    .$dados

  if(data_frame){

    dados <- unlist(dados) %>%
      as.list() %>%
      as.data.frame(stringsAsFactors = FALSE)
  }

  dados
}


# Function to make requests to the Chamber's API
get_data <- function(api, query = NULL, single_page = TRUE, data_frame = FALSE){

  # GET
  pag <- httr::GET(url = api, query = query)


  # 1 scenario: single page
  if(single_page){

    dados <- json_camara(pag, data_frame)
  }


  # 2 scenario: multiple pages
  else {

    n_pag <- ceiling(as.numeric(httr::headers(pag)$`x-total-count`) / 100)
    dados <- vector("list", n_pag)

    for(i in 1:n_pag){

      query$pagina <- i
      dados[[i]] <- httr::GET(url = api, query = query) %>%
        json_camara(data_frame)
    }

    dados <- dplyr::bind_rows(dados)
  }


  # Return
  return(dados)
}


# Avoid the R CMD check note about magrittr's dot
utils::globalVariables(".")

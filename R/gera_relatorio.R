#' Produce a report of legislative activity in a given period
#'
#' @description
#' \code{gera_relatorio()} summarizes legislative data and outputs a Rmarkdown report.
#'
#' @param ini Starting date in the YYYY-MM-DD format (\code{character}).
#' @param end Ending date in the YYYY-MM-DD format (\code{character}).
#'
#' @return A report and its corresponding .Rmd file.
#'
#' @export

gera_relatorio <- function(ini, end) {
  rmarkdown::render(
    system.file("reports", "report_html.Rmd", package = "olb"),
    envir = new.env(),
    encoding = "UTF-8",
    params = list(
      ini = ini,
      end = end
    ),
    output_file = paste0("Relatorio -", ini, " - ", end, ".html")
  )
}





#' Produce a report of legislative activity in a given period
#'
#' @description
#' \code{gera_relatorio()} summarizes legislative data and outputs a Rmarkdown report.
#'
#' @param ini Starting date in the YYYY-MM-DD format (\code{character}).
#' @param end Ending date in the YYYY-MM-DD format (\code{character}).
#' @param titulo Title of the report.
#' @param autor Author of the report (defaults to OLB).
#' @param out_dir Output directory to store the report.
#'
#' @return A report and its corresponding .Rmd file.
#'
#' @export

gera_relatorio <- function(ini, end, titulo, autor, out_dir = getwd()) {

  rmarkdown::render(
    system.file("reports", "report_html.Rmd", package = "olb"),
    envir = new.env(),
    encoding = "UTF-8",
    params = list(ini = ini, end = end, set_author = autor, set_title = titulo),
    output_dir = out_dir,
    output_file = paste0("relatorio_", ini, "_", end, ".html")
  )
}





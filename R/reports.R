#' Build the OLB monitor
#'
#' @description
#' \code{build_monitor()} summarizes legislative data and outputs a Rmarkdown report.
#'
#' @param ini Starting date in the YYYY-MM-DD format (\code{character}).
#' @param end Ending date in the YYYY-MM-DD format (\code{character}).
#' @param out_dir Output directory to store the monitor.
#'
#' @return A OLB's Legislative Monitor website.
#'
#' @export

build_monitor <- function(ini, end, out_dir = getwd()) {


  rmarkdown::render(
    system.file("reports", "monitor_olb.Rmd", package = "olb"),
    envir = new.env(),
    encoding = "UTF-8",
    params = list(ini = ini, end = end),
    output_dir = out_dir,
    output_file = "index.html"
  )
}

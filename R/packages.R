use_hexsticker <- function() {
  if (is_package()) {
    cli::cli_alert_info(
      paste("{.fn parkR::use_package_hexsticker} requires a script for making",
            "a hex sticker if the working directory is a package")
    )
  }
}
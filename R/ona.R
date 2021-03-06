################################################################################
#
#'
#' Basic authentication to ONA with a username and password
#'
#' @param username ONA username.
#' @param password ONA password. Default is an interactive input of password.
#'
#' @return System environment variables for ONA_USERNAME and ONA_PASSWORD
#'
#' @examples
#' ona_auth_password(username = "validtrial", password = "zEF-STN-5ze-qom")
#'
#' @export
#'
#
################################################################################

ona_auth_password <- function(username, password = askpass::askpass()) {
  #withr::with_envvar(
  #  new = c("ONA_USERNAME" = username,
  #          "ONA_PASSWORD" = password),
  #  code = Sys.getenv(x = c("ONA_USERNAME", "ONA_PASSWORD"))
  #)
  Sys.setenv("ONA_USERNAME" = username,
             "ONA_PASSWORD" = password)
}


################################################################################
#
#'
#' Basic authentication to ONA with API authentication token
#'
#' @param token ONA API authentication token.
#'
#' @return System environment variables for ONA_TOKEN
#'
#' @examples
#' ona_auth_token(token = "a0cdd8bcb01ccf26092f7e14309ce8a77ad38d87")
#'
#' @export
#'
#'
#
################################################################################

ona_auth_token <- function(token) {
  #withr::with_envvar(
  #  new = c("ONA_TOKEN" = token),
  #  code = Sys.getenv(x = "ONA_TOKEN", names = TRUE)
  #)
  Sys.setenv("ONA_TOKEN" = token)
}


################################################################################
#
#'
#' Retrieve list of datasets available to specific user
#'
#' @param base_url ONA URL. Default is \url{https://api.ona.io}.
#' @param auth_mode Password or token? Default is token.
#'
#' @return A tibble of datasets available to specific user.
#'
#' @examples
#' ona_list_data()
#'
#' @export
#'
#'
#
################################################################################

ona_list_data <- function(base_url = "https://api.ona.io",
                          auth_mode = "token") {
  ##
  if(auth_mode == "password") {
    config <- httr::authenticate(user = Sys.getenv(x = "ONA_USERNAME"),
                                 password = Sys.getenv(x = "ONA_PASSWORD"))
  } else {
    config <- httr::add_headers("Authorization" = paste("Token",
                                                        Sys.getenv(x = "ONA_TOKEN"),
                                                        sep = " "))
  }

  ##
  resp <- httr::GET(url = base_url,
                    path = "api/v1/data",
                    config = config)

  ##
  x <- jsonlite::fromJSON(txt = httr::content(x = resp,
                                              as = "text",
                                              encoding = "UTF-8"))

  ##
  x <- tibble::tibble(x)

  ##
  return(x)
}


################################################################################
#
#'
#' Retrieve specific dataset by form ID from specific user
#'
#' @param base_url ONA URL. Default is \url{https://api.ona.io}.
#' @param auth_mode Password or token? Default is token.
#' @param form_id Form identifier.
#'
#' @return A tibble of retrieved dataset.
#'
#' @examples
#' ona_get_data(form_id = 276175)
#'
#' @export
#'
#'
#
################################################################################

ona_get_data <- function(base_url = "https://api.ona.io",
                         auth_mode = "token",
                         form_id) {
  ##
  if(auth_mode == "password") {
    config <- httr::authenticate(user = Sys.getenv(x = "ONA_USERNAME"),
                                 password = Sys.getenv(x = "ONA_PASSWORD"))
  } else {
    config <- httr::add_headers("Authorization" = paste("Token",
                                                        Sys.getenv(x = "ONA_TOKEN"),
                                                        sep = " "))
  }

  ##
  resp <- httr::GET(url = base_url,
                    path = paste("api/v1/data", form_id, sep = "/"),
                    config = config)

  ##
  x <- jsonlite::fromJSON(txt = httr::content(x = resp,
                                              as = "text",
                                              encoding = "UTF-8"))

  ##
  x <- tibble::tibble(x)

  ##
  return(x)
}


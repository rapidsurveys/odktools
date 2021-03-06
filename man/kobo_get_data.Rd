% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/kobo.R
\name{kobo_get_data}
\alias{kobo_get_data}
\title{Retrieve specific dataset by form ID from specific user}
\usage{
kobo_get_data(
  base_url = "https://kf.kobotoolbox.org",
  auth_mode = "token",
  asset_id
)
}
\arguments{
\item{base_url}{KoBo Toolbox URL. Default is \url{https://kf.kobotoolbox.org}.}

\item{auth_mode}{Password or token? Default is token.}

\item{asset_id}{Unique asset identifier.}
}
\value{
A tibble of datasets available to specific user.
}
\description{
Retrieve specific dataset by form ID from specific user
}
\examples{
kobo_auth_token(token = "e9b39da128ff1b0bd4366b015c9e8ebad35b5fea")
kobo_get_data(asset_id = "aKJTpKiVUcPYim2epKkPvW")

}

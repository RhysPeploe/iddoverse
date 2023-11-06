% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PREP_DS_OUT_VL.R
\name{PREP_DS_OUT_VL}
\alias{PREP_DS_OUT_VL}
\title{Prepare the DS Domain for VL outcome analysis.}
\usage{
PREP_DS_OUT_VL(DATA_DS)
}
\arguments{
\item{DATA_DS}{The DS domain data frame, as named in the global environment.}
}
\value{
Two functions which each create a data frame focusing on outcome
measures for VL
}
\description{
Prepare the Disposition (DS) domain for use in outcome analysis data sets
studying Visceral Leishmaniasis. Takes a IDDO-SDTM curated DS domain,
transforms and pivots it in order to merge it into an outcome analysis data
set with other domains using the ANALYSE_OUTCOME() function.
}
\author{
Rhys Peploe
}
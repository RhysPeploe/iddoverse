% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PREP_SA_MV_FU.R
\name{PREP_SA_MV_FU}
\alias{PREP_SA_MV_FU}
\title{Further prepare the SA domain for follow up analysis specifically for Malaria
and VL variables.}
\usage{
PREP_SA_MV_FU(DATA_SA)
}
\arguments{
\item{DATA_SA}{The SA domain data frame, as named in the global environment.}
}
\value{
Data frame with one row per USUBJID/subject per day, with Malaria and VL
specific SATERMs as columns
}
\description{
Prepare the Clinical and Adverse Effects (SA) domain for use in follow up
analysis data sets focusing on Malaria and Visceral Leishmaniasis. Takes a
IDDO-SDTM curated SA domain, transforms and pivots it in order to merge it
into a follow up analysis data set with other domains using the
ANALYSE_FOLLOW_UP() function. PREP_SA_BL() and PREP_SA_MV_BL() would be merged
in the ANALYSE_FOLLOW_UP() function.
}
\author{
Rhys Peploe
}

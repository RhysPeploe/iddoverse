% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DERIVE_AP_EMPTY_TIME.R
\name{DERIVE_AP_EMPTY_TIME}
\alias{DERIVE_AP_EMPTY_TIME}
\title{Create EMPTY_TIME variable which is populated only for rows without core
timing variables.}
\usage{
DERIVE_AP_EMPTY_TIME(DATA)
}
\arguments{
\item{DATA}{Data frame which contains a SDTM domain.}
}
\value{
Data frame with additional column for EMPTY_TIME
}
\description{
EMPTY_TIME is a dummy variable which is used to pivot the data one when rows
do not have any of VISITNUM, VISITDY, DAY (and --STDY & --ENDY in appropriate
domains). Every row before the pivot will have either some timing variables
populated or EMPTY_TIME. When pivoting, EMPTY_TIME is included so that each
row is pivoted and no informative row is dropped during the transformation.
}
\details{
This is used in creating follow up analysis datasets.
}
\author{
Rhys Peploe
}

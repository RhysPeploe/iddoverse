% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PREP_RP_BL.R
\name{PREP_RP_BL}
\alias{PREP_RP_BL}
\title{Prepare the RP domain for baseline analysis.}
\usage{
PREP_RP_BL(DATA_RP, VARS = NULL)
}
\arguments{
\item{DATA_RP}{The RP domain data frame, as named in the global environment.}

\item{VARS}{Specify additional variables to be included in the output
dataset. Character string. Use controlled terminology for RPTESTCD as
specified in the RP section of the 'IDDO SDTM Implementation Manual'. i.e.
c("LMPSTDTC").}
}
\value{
Wide data frame containing a row per USUBJID/subject, with RPTESTCDs
and the units as columns.
}
\description{
Prepare the Reproductive System Findings (RP) domain for use in baseline
analysis data sets. Takes a IDDO-SDTM curated RP domain, transforms and
pivots it in order to merge it into a baseline analysis data set with other
domains using the ANALYSE_BASELINE() functions. Default variables are:
"PREGIND" & "EGESTAGE" (renamed as "EGA")
}
\author{
Rhys Peploe
}

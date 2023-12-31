% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DOMAIN_TABLE.R
\name{DOMAIN_TABLE}
\alias{DOMAIN_TABLE}
\title{Tabulate function to display variables in a given domain}
\usage{
DOMAIN_TABLE(DOMAIN_CODE, DOMAIN_FILE, by_STUDYID = FALSE)
}
\arguments{
\item{DOMAIN_CODE}{The two letter code for the domain which matches the DOMAIN_FILE.
Character string. Domains included: "DM", "LB", "RP", "MB", "MP", "SA", "IN", "VS", "DS", "RS".}

\item{DOMAIN_FILE}{The name of the SDTM domain dataset in the global environment.}

\item{by_STUDYID}{Split by STUDYID if TRUE. Default is FALSE.}
}
\value{
For Demographics (DM) domain, a character list with the column names.
For all other domains, a table class object listing the variables under --TESTCD
or INTRT, MPLOC, DSDECOD; where -- is the two letter domain name.
}
\description{
Uses table() to display the variables contained within an SDTM formatted data frame.
Additionally can be split by STUDYID to display the options across multiple studies.
}
\author{
Rhys Peploe
}

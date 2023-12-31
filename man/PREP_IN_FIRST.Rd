% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PREP_IN_FIRST.R
\name{PREP_IN_FIRST}
\alias{PREP_IN_FIRST}
\title{Prepare the IN domain for analysis on the first occurrence of events.}
\usage{
PREP_IN_FIRST(DATA_IN, DISEASE = "", VARS = NULL)
}
\arguments{
\item{DATA_IN}{The IN domain data frame, as named in the global environment.}

\item{DISEASE}{The name of the disease theme being analysed. Character
string. Default is empty (selects base variables). Select from: "MALARIA",
"VL" or "EBOLA". If selection is missing or misspelt, then the base
variables will be used.}

\item{VARS}{Specify additional variables to be included in the output
dataset. Character string. Use controlled terminology for INDECOD as
specified in the IN section of the 'IDDO SDTM Implementation Manual'. i.e.
c("PARACETAMOL").}
}
\value{
Dataframe containing a row per USUBJID/subject, with IN terms and the
day of first occurrence of each as columns.
}
\description{
Prepare the Treatments and Interventions (IN) domain for use in first occurrence
analysis data sets. Takes a IDDO-SDTM curated IN domain, transforms and
pivots it in order to merge it into a first occurrence analysis data set with other
domains using the ANALYSE_FIRST() function.
}
\author{
Rhys Peploe
}

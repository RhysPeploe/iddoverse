% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/PREP_SA_BL.R
\name{PREP_SA_BL}
\alias{PREP_SA_BL}
\title{Prepare the SA domain for baseline analysis.}
\usage{
PREP_SA_BL(
  DATA_SA,
  DISEASE = "",
  VARS = NULL,
  inc_DUR = FALSE,
  inc_TIME = FALSE
)
}
\arguments{
\item{DATA_SA}{The SA domain data frame, as named in the global environment.}

\item{DISEASE}{The name of the disease theme being analysed. Character
string. Default is empty (selects base variables). Select from: "MALARIA",
"VL" or "EBOLA". If selection is missing or misspelt, then the default
variables will be used.}

\item{VARS}{Specify additional variables to be included in the output
dataset. Character string. Use controlled terminology for SADECOD as
specified in the SA section of the 'IDDO SDTM Implementation Manual'. i.e.
c("CRONAVIR").}

\item{inc_DUR}{Should the analysis dataset include the duration of the event?
This is the time from the start of the event till the end. Boolean, default
is FALSE.}

\item{inc_TIME}{Should the analysis dataset include the time since the event?
This is the time since the end of the event. Boolean, default is FALSE.}
}
\value{
Data frame with one row per USUBJID/subject, with SATERMs as columns
}
\description{
Prepare the Clinical and Adverse Effects (SA) domain for use in baseline
analysis data sets. Takes a IDDO-SDTM curated SA domain, transforms and
pivots it in order to merge it into a baseline analysis data set with other
domains using the ANALYSE_BASELINE() function. Default variables are:
"FEVER", "ANEMIA", "HIV", with disease specific defaults in 'Details'
}
\details{
Default variables:

Malaria: "FEVER", "ANEMIA", "HIV", "ANOREXIA",
"DIARRHOEA", "NAUSEA", "VOMITING", "ABDOMINAL PAIN", "DIZZINESS", "SHORTNESS
OF BREATH", "JAUNDICE", "DARK URINE", "ENLARGED SPLEEN", "ENLARGED LIVER"

VL: "FEVER", "ANEMIA", "HIV"

Ebola: "FEVER", "LOSS OF APPETITE", "VOMITING", "NAUSEA AND
VOMITING","HEADACHE", "DIARRHOEA", "ABDOMINAL PAIN", "BLEEDING", "DIFFICULTY
SWALLOWING", "HICCOUGHS", "DIFFICULTY BREATHING", "PAIN IN THROAT",
"FATIGUE", "MUSCLE PAIN", "JOINT PAIN", "GENERALIZED ACHES AND PAIN",
"ERUPTION OF SKIN"
}
\author{
Rhys Peploe
}

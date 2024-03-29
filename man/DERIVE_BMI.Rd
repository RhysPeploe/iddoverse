% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/DERIVE_BMI.R
\name{DERIVE_BMI}
\alias{DERIVE_BMI}
\title{Derive BMI and replace contributor provided result if HEIGHT and WEIGHT are
given.}
\usage{
DERIVE_BMI(DATA)
}
\arguments{
\item{DATA}{Data frame containing HEIGHT and WEIGHT variables, typically the
Vital Signs (VS) domain.}
}
\value{
Data frame with additional columns for BMI & BMI_UNITS, if BMI did not previously
exist. If BMI existed previously, the BMI is recalculated using the WEIGHT
and HEIGHT provided. The existing value will only be used if there is an NA
value in the recalculated column, the existing column is then discarded.
}
\description{
Calculates the Body Mass Index of subjects if WEIGHT and HEIGHT are in the
data frame. Initially creates a new variable which calculates the BMI of
those with valid WEIGHT and HEIGHT variables, then where NAs exist, the
variable is populated with existing BMI results, along with the relevant
units. This new variable then replaces the existing BMI column.
}
\author{
Rhys Peploe
}

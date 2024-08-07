#' Prepare the SC domain for follow up analysis.
#'
#' Prepare the Subject Characteristics (SC) domain for use in follow up analysis
#' data sets. Takes a IDDO-SDTM curated SC domain, transforms and pivots it in
#' order to merge it into a follow up analysis data set with other domains using
#' the ANALYSE_FOLLOW_UP() function.
#'
#' @param DATA_SC The SC domain data frame, as named in the global environment.
#' @param VARS Specify additional variables to be included in the output
#'   dataset. Character string. Use controlled terminology for SCTESTCD as
#'   specified in the SC section of the 'IDDO SDTM Implementation Manual'. i.e.
#'   c("ADEVAIND").
#'
#' @return Wide data frame with one row per USUBJID/subject per day, with
#'   SCTESTCDs as columns.
#'
#' @export
#'
#' @author Rhys Peploe
#'
PREP_SC_FU <- function(DATA_SC, VARS = NULL) {
  SC_VARS <- c(str_to_upper(VARS))

  DATA_SC <- DATA_SC %>%
    convert_blanks_to_na() %>%
    filter(.data$SCTESTCD %in% SC_VARS) %>%
    mutate(
      SCSTRES = as.character(str_to_upper(.data$SCSTRESC)),
      SCORRES = as.character(str_to_upper(.data$SCORRES)),
      DAY = .data$SCDY,
      SCUNITS = as.character(str_to_upper(.data$SCSTRESN)),
      SCORRESU = as.character(str_to_upper(.data$SCORRESU))
    )

  DATA_EMPTY <- DATA_SC %>%
    filter(is.na(.data$VISITDY) & is.na(.data$VISITNUM) & is.na(.data$DAY)) %>%
    DERIVE_EMPTY_TIME()

  DATA <- DATA_SC %>%
    left_join(DATA_EMPTY)

  DATA[which(is.na(DATA$SCSTRES)), "SCSTRES"] <-
    DATA[which(is.na(DATA$SCSTRES)), "SCORRES"]

  DATA[which(is.na(DATA$SCUNITS)), "SCUNITS"] <-
    DATA[which(is.na(DATA$SCUNITS)), "SCORRESU"]

  if ("DSTHOSP" %in% SC_VARS) {
    DATA <- DATA %>%
      filter(.data$SCTESTCD == "DSTHOSP") %>%
      pivot_wider(
        id_cols = c(
          .data$STUDYID, .data$USUBJID, .data$VISITDY,
          .data$VISITNUM, .data$DAY, .data$EMPTY_TIME
        ),
        names_from = .data$SCTESTCD, values_from = c(.data$SCSTRES, .data$SCUNITS),
        names_sort = T, names_vary = "slowest",
        values_fn = first
      )
  } else {
    DATA <- DATA %>%
      filter(.data$SCTESTCD != "DSTHOSP") %>%
      pivot_wider(
        id_cols = c(
          .data$STUDYID, .data$USUBJID, .data$VISITDY,
          .data$VISITNUM, .data$DAY, .data$EMPTY_TIME
        ),
        names_from = .data$SCTESTCD, values_from = .data$SCSTRES,
        names_sort = T, names_vary = "slowest",
        values_fn = first
      )
  }

  DATA <- DATA %>%
    clean_names(case = "all_caps")

  return(DATA)
}

#' Prepare the DS Domain for VL outcome analysis.
#'
#' Prepare the Disposition (DS) domain for use in outcome analysis data sets
#' studying Visceral Leishmaniasis. Takes a IDDO-SDTM curated DS domain,
#' transforms and pivots it in order to merge it into an outcome analysis data
#' set with other domains using the ANALYSE_OUTCOME() function.
#'
#' All disposition records should be inspected to check the data (expand_cols =
#' TRUE) as events may have occurred multiple times before the final record. For
#' example, a subject may be lost to follow up, but have three different records
#' stating this, so the final disposition date may not be the actual date that
#' contact with the subject was lost.
#'
#' @param DATA_DS The DS domain data frame, as named in the global environment.
#' @param expand_cols Boolean option to include all DS entries for each subject.
#'   Default is FALSE, which will display the last recorded disposition event
#'   and the associated VISITNUM, VISITDY and DAY. If TRUE, all disposition
#'   events will be listed as DISP_NUMBER_, along with the associated VISITNUM,
#'   VISITDY and DAY.
#'
#' @return Dataframe containing a row per USUBJID, with DS terms as columns.
#'
#' @export
#'
#' @author Rhys Peploe
#'
PREP_DS_OUT_VL <- function(DATA_DS, expand_cols = FALSE) {
  DATA_DS <- DATA_DS %>%
    convert_blanks_to_na() %>%
    mutate(
      DSSTRES = str_to_upper(as.character(.data$DSDECOD)),
      DSMODIFY = str_to_upper(as.character(.data$DSMODIFY)),
      DSTERM = str_to_upper(as.character(.data$DSTERM)),
      DAY = .data$DSDY,
      START_DAY = .data$DSSTDY
    )

  DATA_DS[which(is.na(DATA_DS$DSSTRES)), "DSSTRES"] <-
    DATA_DS[which(is.na(DATA_DS$DSSTRES)), "DSMODIFY"]
  DATA_DS[which(is.na(DATA_DS$DSSTRES)), "DSSTRES"] <-
    DATA_DS[which(is.na(DATA_DS$DSSTRES)), "DSTERM"]

  if (expand_cols == FALSE) {
    DATA <- DATA_DS %>%
      pivot_wider(
        id_cols = c(.data$STUDYID, .data$USUBJID),
        names_from = .data$DOMAIN,
        values_from = c(.data$DSSTRES, .data$VISITNUM, .data$VISITDY, .data$DAY, .data$START_DAY),
        values_fn = last
      ) %>%
      rename(
        "FINAL_DISP" = "DSSTRES_DS",
        "FINAL_DISP_VISITDY" = "VISITDY_DS",
        "FINAL_DISP_VISITNUM" = "VISITNUM_DS",
        "FINAL_DISP_DAY" = "DAY_DS",
        "FINAL_DISP_START_DAY" = "START_DAY_DS"
      )
  } else if (expand_cols == TRUE) {
    DATA <- DATA_DS %>%
      group_by(.data$STUDYID, .data$USUBJID) %>%
      mutate(ROWN = row_number()) %>%
      pivot_wider(
        id_cols = c(.data$STUDYID, .data$USUBJID),
        names_from = c(.data$ROWN), names_glue = "DISP_{ROWN}_{.value}",
        values_from = c(.data$DSSTRES, .data$VISITNUM, .data$VISITDY, .data$DAY), names_vary = "slowest"
      )

    colnames(DATA) <- str_replace_all(colnames(DATA), "DSDY", "DAY")
    colnames(DATA) <- str_replace_all(colnames(DATA), "_DSSTRES", "")
  }

  return(DATA)
}

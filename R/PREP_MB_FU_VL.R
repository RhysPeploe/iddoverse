#' Further prepare the MB domain for follow up analysis specifically for VL.
#'
#' Prepare the Microbiology (MB) domain for use in follow up analysis data sets
#' with specific actions for Visceral Leishmaniasis. Takes a IDDO-SDTM curated
#' MB domain, transforms and pivots it in order to merge it into a follow up
#' analysis data set with other domains using the ANALYSE_FOLLOW_UP() function.
#' PREP_MB_FU() and PREP_MB_VL_FU() would be merged in the ANALYSE_FOLLOW_UP()
#' function.
#'
#' @param DATA_MB The MB domain data frame, as named in the global environment.
#'
#' @return Data frame with one row per USUBJID/subject per day, with VL specific
#'   MBTESTCDs as columns
#'
#' @export
#'
#' @author Rhys Peploe
#'
PREP_MB_FU_VL = function(DATA_MB){
  MB_VARS = c("LSHMANIA", "LDONOV", "LMAJOR")

  DATA_MB = DATA_MB %>%
    convert_blanks_to_na() %>%
    filter(.data$MBTESTCD %in% MB_VARS) %>%
    mutate(MBSTRES = str_to_upper(as.character(.data$MBSTRESN)),
           MBUNITS = str_to_upper(as.character(.data$MBSTRESU)),
           MBSTRESC = str_to_upper(as.character(.data$MBSTRESC)),
           MBMODIFY = str_to_upper(as.character(.data$MBMODIFY)),
           MBORRES = str_to_upper(as.character(.data$MBORRES)),
           DAY = .data$MBDY) %>%
    CLEAN_MB_VL()

  DATA_EMPTY = DATA_MB %>%
    filter(is.na(.data$VISITDY) & is.na(.data$VISITNUM) & is.na(.data$DAY)) %>%
    DERIVE_EMPTY_TIME()

  DATA = DATA_MB %>%
    left_join(DATA_EMPTY)

  DATA[which(is.na(DATA$MBSTRES)), "MBSTRES"] =
    DATA[which(is.na(DATA$MBSTRES)), "MBSTRESC"]
  DATA[which(is.na(DATA$MBSTRES)), "MBSTRES"] =
    DATA[which(is.na(DATA$MBSTRES)), "MBMODIFY"]
  DATA[which(is.na(DATA$MBSTRES)), "MBSTRES"] =
    DATA[which(is.na(DATA$MBSTRES)), "MBORRES"]

  DATA[which(is.na(DATA$MBUNITS)), "MBUNITS"] =
    DATA[which(is.na(DATA$MBUNITS)), "MBORRESU"]

  DATA$MBSTRES = str_replace_all(DATA$MBSTRES, "01-Oct", "1-10")
  DATA$MBSTRES = str_replace_all(DATA$MBSTRES, "01-OCT", "1-10")

  DATA = DATA %>%
    pivot_wider(id_cols = c(.data$STUDYID, .data$USUBJID, .data$VISITDY, .data$VISITNUM,
                            .data$DAY, .data$EMPTY_TIME), names_from = .data$MBTESTCD,
                values_from = c(.data$MBSTRES, .data$MBUNITS, .data$MBLOC, .data$MBSPEC),
                names_glue = "{MBTESTCD}_{.value}", names_sort = T, names_vary = "slowest",
                values_fn = first) %>%
    mutate(DATA_LSHMANIA = NA,
           DATA_MAJOR = NA,
           DATA_LDONOV = NA)

  colnames(DATA) = gsub("_MBSTRES", "", colnames(DATA))
  colnames(DATA) = gsub("MBUNITS", "UNITS", colnames(DATA))
  colnames(DATA) = gsub("MBLOC", "LOC", colnames(DATA))
  colnames(DATA) = gsub("MBSPEC", "SPEC", colnames(DATA))

  for(i in 1:nrow(DATA)){
    if("LSHMANIA" %in% names(DATA)){
      if(!is.na(DATA$LSHMANIA[i]) | !is.na(DATA$LSHMANIA_UNITS[i]) |
         !is.na(DATA$LSHMANIA_SPEC[i]) | !is.na(DATA$LSHMANIA_LOC[i])){
        DATA$DATA_LSHMANIA[i] = "LSHM"
      }
    }
    if("LDONOV" %in% names(DATA)){
      if(!is.na(DATA$LDONOV[i]) | !is.na(DATA$LDONOV_UNITS[i]) |
         !is.na(DATA$LDONOV_SPEC[i]) | !is.na(DATA$LDONOV_LOC[i])){
        DATA$DATA_LDONOV[i] = "LDON"
      }
    }
    if("LMAJOR" %in% names(DATA)){
      if(!is.na(DATA$LMAJOR[i]) | !is.na(DATA$LMAJOR_UNITS[i]) |
         !is.na(DATA$LMAJOR_SPEC[i]) | !is.na(DATA$LMAJOR_LOC[i])){
        DATA$DATA_MAJOR[i] = "LMAJ"
      }
    }
  }

  DATA = DATA %>%
    unite(.data$DATA_LSHMANIA, .data$DATA_LDONOV, .data$DATA_MAJOR, col = "SPECIES",
          na.rm = TRUE, remove = TRUE, sep = " + ") %>%
    relocate(.data$SPECIES, .after = .data$USUBJID) %>%
    mutate(SPECIES = convert_blanks_to_na(.data$SPECIES)) %>%
    clean_names(case = "all_caps")

  DATA = DATA %>%
    clean_names(case = "all_caps")

  return(DATA)
}

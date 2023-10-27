#' Calculate WHO growth standards using the anthro() package.
#'
#' Calculates the Height for Age, Weight for Age and Weight for Height z-scores
#' which are used to measure growth against the WHO population standards. This
#' is only for children less than 5 years old.
#'
#' Note the function can be applied to a dataset with subjects greater than 5
#' years old too, but those subjects will have NA in these columns.
#'
#' @param DATA Data frame contain the AGE, AGE_DAYS, WEIGHT & HEIGHT variables,
#'   typically held in the Demographics (DM) and Vital Signs (VS) domains.
#'
#' @return Data frame with additional columns for WAZ, HAZ and WHZ scores,
#'   along with flags for each.
#' @export
#'
#' @importFrom anthro anthro_zscores
#'
DERIVE_ANTHRO = function(DATA){
  DATA_ANTHRO = DATA %>%
    filter(AGE < 5 | AGE_DAYS < 1826)

  BIND_ANTHRO = cbind(DATA_ANTHRO,
                      anthro_zscores(
                        sex = DATA_ANTHRO$SEX,
                        age = as.numeric(DATA_ANTHRO$AGE_DAYS),
                        weight = as.numeric(DATA_ANTHRO$WEIGHT),
                        lenhei = as.numeric(DATA_ANTHRO$HEIGHT)) %>%

                        dplyr::select(zlen, flen, zwei, fwei, zwfl, fwfl)) %>%

    rename("HAZ" = "zlen",
           "HAZ_FLAG" = "flen",
           "WAZ" = "zwei",
           "WAZ_FLAG" = "fwei",
           "WHZ" = "zwfl",
           "WHZ_FLAG" = "fwfl")

}
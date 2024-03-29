# iddoverse 0.3.1
* Data exported with package as opposed to read.csv 
* Data documented
* Resolved uninitiated DISEASE variable in ANALYSE functions
* Creation of PREP_DS_OUT_EVD (Ebola Virus Disease)

# iddoverse 0.3.0
* Units have been including alongside all variable which having a --ORRESU or --STRESU is possible (issue #18). Units are now matched with the equivalent result so STRESU will be used if STRESC or STRESN are and likewise if MODIFY or ORRES are reported in the output, ORRESU will be the units
* Error in DERIVE_ANTHRO when there is no under 5s, issue #19
* Removed SPECIES from MB domains 

# iddoverse 0.2.2
* Vignette created
* str_to_upper(AGEU) in DERIVE_AGE_YEARS & DERIVE_AGE_DAYS
* for loop added into PREP_SA_BL to convert SAOCCUR & SAPRESP

# iddoverse 0.2.1
* All variable names are defined relative to the corresponding dataset using the .data$ function or calling the dataframe name before the $
* Removed dependence on LB domain in ANALYSE_FOLLOW_UP()
* Increased use for as.character and str_to_upper for consistency 

# iddoverse 0.2.0
* Significant changes to VL outcome including function name changes, rewriting of code to match other PREP functions, removal of domain dependency and generally a clear look
* Documentation updates to reflect change

# iddoverse 0.1.2
* Enhanced ANALYSE_FOLLOW_UP by not depending on LB domain. Fixed by creating a empty dataset in the absence of LB, and removing empty rows at the end of merging
* Uploaded test data STUDYID: RPTESTB
* Added AGE_DAYS as a DM default for FU analysis too to track growth standards at any point

# iddoverse 0.1.1
* Resolved coercing error in DERIVE_BMI by removing as.numeric
* Added JOIN_ functions into ANALYSE_FOLLOW_UP

# iddoverse 0.1.0

* Added a `NEWS.md` file to track changes to the package.
* All current functions now uploaded to iddoverse github
* changed names of certain functions for standardised nomenclature:
*   namely:
* +    PREP_DS_OUT_VL <- PREP_DS_VL_OUT,
* +    PREP_MB_BL_MAL <- PREP_MB_MAL_BL, 
* +    PREP_MB_BL_VL <- PREP_MB_VL_BL,
* +    PREP_MB_FU_MAL <- PREP_MB_MAL_FU,
* +    PREP_MB_FU_VL <- PREP_MB_VL_FU,
* +    PREP_RS_OUT_VL <- PREP_RS_VL_OUT
* citation and documentation improved

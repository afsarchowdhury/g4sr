# Clean student details functions ---------------------------

## Clean general student details
#' Get clean general student details.
#'
#' Returns clean general student details for chosen academic year.
#' @param academicYear academic year as integer.
#' @examples
#' gfs_clean_student_details_general(2021)
#' @export
gfs_clean_student_details_general <- function(academicYear) {
  ## Mesaage
  message(cat(crayon::cyan("Generating clean student details")))

  ## School details
  my_school <- gfs_school()

  ## Define variables
  my_school_name <- my_school$name
  my_school_years <- my_school$academic_years
  my_school_years_current <- my_school$current_academic_year

  ## Import data
  df_students <- gfs_student_details(academicYear)
  df_students_general <- gfs_student_general(academicYear)
  df_students_details <- gfs_student_edu_details(academicYear)
  df_students_sensitive <- gfs_student_sensitive(academicYear)

  message(cat(crayon::silver("Tidy datasets")))

  ## Tidy general
  df_students_general_02 <- dplyr::select(df_students_general, c(student_id, name, value))
  df_students_general_02 <- dplyr::filter(df_students_general_02,
                                          grepl(pattern = "admission|leaving|uci|hml|sen|key|caf|young|permission",
                                                x = name, ignore.case = TRUE))
  df_students_general_02 <- tidyr::pivot_wider(df_students_general_02, names_from = name, values_from = value)
  df_students_general_02 <- data.frame(df_students_general_02, check.names = TRUE)
  df_students_general_02 <- dplyr::select(df_students_general_02,
                                          c(student_id, "Ad.No" = Admission.number, UCI, HML.Band, "SEN" = X3...SEN.Code,
                                            "SEN.Notes" = X4..SEN.Notes, "Keyworker" = X5..Keyworker.Name, CP.CAF, Young.Carer,
                                            "Date.Admission" = Admission.date, "Date.Leaving" = Leaving.date))
  df_students_general_02 <- unique(df_students_general_02)

  ## Tidy sensitive
  df_students_sensitive_02 <- dplyr::select(df_students_sensitive, c(student_id, name, value))
  df_students_sensitive_02 <- tidyr::pivot_wider(df_students_sensitive_02, names_from = name, values_from = value)
  df_students_sensitive_02 <- data.frame(df_students_sensitive_02, check.names = TRUE)
  df_students_sensitive_02 <- dplyr::select(df_students_sensitive_02, c(student_id, "LAC" = Looked.after, Ethnicity, EAL, FSM,
                                                                        "PP" = Pupil.Premium.Indicator))
  df_students_sensitive_02 <- unique(df_students_sensitive_02)

  ## Tidy details
  df_students_details_02 <- dplyr::select(df_students_details, c(student_id, upn, national_curriculum_year, registration_group))

  message(cat(crayon::silver("Merge datasets")))

  ## Merge datasets
  df <- dplyr::left_join(df_students, df_students_details_02, by = c("id" = "student_id"))
  df <- dplyr::left_join(df, df_students_general_02, by = c("id" = "student_id"))
  df <- dplyr::left_join(df, df_students_sensitive_02, by = c("id" = "student_id"))

  message(cat(crayon::silver("Compute metadata")))

  ## Create
  df$Surname.Forename.Reg <- paste0(toupper(df$preferred_last_name), " ", df$preferred_first_name, " (", df$registration_group, ")")
  df <- dplyr::mutate(df, WBr.PP = ifelse(grepl(pattern = "english|scottish|welsh", x = Ethnicity, ignore.case = TRUE) & PP == "True", "True", "False"))

  message(cat(crayon::silver("Clean final output")))

  ## Clean and filter
  df <- dplyr::select(df, c("Year.Group" = national_curriculum_year, "UPN" = upn, "GFSID" = id, Surname.Forename.Reg,
                            "Surname" = preferred_last_name, "Forename" = preferred_first_name, "Gender" = sex,
                            Ethnicity, EAL, FSM, PP, WBr.PP, HML.Band, Ad.No, UCI, SEN, SEN.Notes, Keyworker, LAC, CP.CAF,
                            Young.Carer, Date.Admission, Date.Leaving))
  df <- dplyr::mutate_all(df, .funs = as.character)
  df <- dplyr::mutate_at(df, .vars = c("Date.Admission", "Date.Leaving"), .funs = lubridate::mdy_hms)
  df$Stay <- lubridate::as.duration(df$Date.Leaving - df$Date.Admission)
  df <- unique(df)
}

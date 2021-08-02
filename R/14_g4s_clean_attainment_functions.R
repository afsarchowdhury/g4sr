# Clean attainment functions ---------------------------

## Clean exam results
#' Get external examination results.
#'
#' Returns clean details of external examination results in the chosen academic year for chosen
#' year group.
#' @param academicYear academic year as integer.
#' @param yearGroup year group as string.
#' @examples
#' gfs_clean_exam_results(2020, "11")
#' gfs_clean_exam_results(2020, "11", type = "gcse")
#' gfs_clean_exam_results(2020, "11", type = c("gcse", "btec"))
#' @export
gfs_clean_exam_results <- function(academicYear, yearGroup, type = NULL) {
  ## Mesaage
  message(cat(crayon::cyan("Generating clean external examination results")))

  ## Import data
  df_att_exam_results <- gfs_attainment_exam_results(academicYear, yearGroup)
  df_students <- gfs_student_details(academicYear)
  df_students_details <- gfs_student_edu_details(academicYear)
  df_students_general <- gfs_student_general(academicYear)
  df_students_sensitive <- gfs_student_sensitive(academicYear)
  df_subjects <- gfs_teaching_subjects(academicYear)
  df_teaching_groups <- gfs_teaching_groups(academicYear)
  df_teaching_groups_students <- gfs_teaching_groups_students(academicYear)
  df_teaching_groups_teachers <- gfs_teaching_groups_teachers(academicYear)
  df_teachers <- gfs_teaching_teachers(academicYear)

  message(cat(crayon::silver("Tidy datasets")))

  ## Tidy general
  df_students_general_02 <- dplyr::select(df_students_general, c(student_id, name, value))
  df_students_general_02 <- dplyr::filter(df_students_general_02,
                                          grepl(pattern = "hml", x = name, ignore.case = TRUE))
  df_students_general_02 <- tidyr::pivot_wider(df_students_general_02, names_from = name, values_from = value)
  df_students_general_02 <- data.frame(df_students_general_02, check.names = TRUE)
  df_students_general_02 <- dplyr::select(df_students_general_02, c(student_id, HML.Band))
  df_students_general_02 <- unique(df_students_general_02)

  ## Tidy sensitive
  df_students_sensitive_02 <- dplyr::select(df_students_sensitive, c(student_id, name, value))
  df_students_sensitive_02 <- dplyr::filter(df_students_sensitive_02,
                                            grepl(pattern = "premium", x = name, ignore.case = TRUE))
  df_students_sensitive_02 <- tidyr::pivot_wider(df_students_sensitive_02, names_from = name, values_from = value)
  df_students_sensitive_02 <- data.frame(df_students_sensitive_02, check.names = TRUE)
  df_students_sensitive_02 <- dplyr::select(df_students_sensitive_02, c(student_id, "PP" = Pupil.Premium.Indicator))
  df_students_sensitive_02 <- unique(df_students_sensitive_02)

  message(cat(crayon::silver("Merge datasets")))

  ## Merge
  df <- dplyr::left_join(df_att_exam_results, df_subjects, by = c("subject_id" = "id"))
  df <- dplyr::left_join(df, df_students, by = c("student_id" = "id"))
  df <- dplyr::left_join(df, df_students_details, by = c("student_id" = "student_id"))
  df <- dplyr::left_join(df, df_students_general_02, by = c("student_id" = "student_id"))
  df <- dplyr::left_join(df, df_students_sensitive_02, by = c("student_id" = "student_id"))
  df_02 <- dplyr::left_join(df_teaching_groups, df_teaching_groups_students, by = c("id" = "group_id"))
  df_02 <- dplyr::left_join(df_02, df_subjects, by = c("subject_id" = "id"))
  df_02 <- dplyr::left_join(df_02, df_teaching_groups_teachers, by = c("id" = "group_id"))
  df_02 <- dplyr::left_join(df_02, df_teachers, by = c("teacher_ids" = "id"))
  df_02 <- dplyr::select(df_02, c("Class" = name.x, student_ids, "Subject.Code" = code.y, "Teacher" = initials))
  df_02 <- unique(df_02)
  df <- dplyr::left_join(df, df_02, by = c("student_id" = "student_ids", "code" = "Subject.Code"))

  message(cat(crayon::silver("Compute metadata")))

  ## Create
  df$Surname.Forename.Reg <- paste0(toupper(df$preferred_last_name), " ", df$preferred_first_name, " (", df$registration_group, ")")
  df$Grade.Type <- paste0("External examination")

  message(cat(crayon::silver("Clean final output")))

  ## Tidy
  df <- dplyr::select(df, c(Teacher, "Year.Group" = year_group, "Qualification.Title" = qualification_title.x,
                            "Subject" = name, Class, "UPN" = upn, "GFSID" = student_id, Surname.Forename.Reg,
                            "Surname" = preferred_last_name, "Forename" = preferred_first_name,
                            "Reg" = registration_group, "Gender" = sex, PP, HML.Band, Grade.Type, "Grade" = grade))
  df <- unique(df)

  ## Qualification type
  if (is.null(type)) {
    df <- df
  } else {
    my_query <- c(type)
    my_query <- glue::glue_collapse(x = my_query, sep = "|", last = "")
    df <- dplyr::filter(df, grepl(pattern = my_query, x = Qualification.Title, ignore.case = TRUE))
  }

  ## Return
  return(df)
}

# Clean behaviour functions ---------------------------

## Clean behaviour events
#' Get clean behaviour events.
#'
#' Returns clean behaviour events over a range of dates within in the chosen
#' academic year.
#' @param academicYear academic year as integer.
#' @param goDateStart start date of range as string in the form yyyy-mm-dd.
#' @param goDateEnd end date of range as string in the form yyyy-mm-dd.
#' @examples
#' gfs_clean_behaviour_events_range(2021, "2021-07-12", "2021-07-16")
#' @export
gfs_clean_behaviour_events_range <- function(academicYear, goDateStart, goDateEnd) {
  ## Mesaage
  message(cat(crayon::cyan("Generating clean behaviour events for", goDateStart, "to", goDateEnd)))

  ## Import data
  df_behaviour_events <- gfs_behaviour_events_range(academicYear, goDateStart, goDateEnd)
  df_behaviour_event_types <- gfs_behaviour_event_types(academicYear)
  df_behaviour_classification <- gfs_behaviour_classification(academicYear)
  df_students <- gfs_student_details(academicYear)
  df_students_details <- gfs_student_edu_details(academicYear)
  df_subjects <- gfs_teaching_subjects(academicYear)
  df_teaching_groups <- gfs_teaching_groups(academicYear)
  df_teaching_groups_students <- gfs_teaching_groups_students(academicYear)
  df_staff <- gfs_users_staff()

  message(cat(crayon::silver("Merge datasets")))

  ## Merge
  df <- dplyr::left_join(df_behaviour_events, df_behaviour_event_types, by = c("event_type_id" = "id"))
  df <- dplyr::left_join(df, df_behaviour_classification, by = c("event_classification_id" = "id"))
  df <- dplyr::left_join(df, df_students, by = c("student_ids" = "id"))
  df <- dplyr::left_join(df, df_students_details, by = c("student_ids" = "student_id"))
  df <- dplyr::left_join(df, df_staff, by = c("created_by" = "id"))
  df_02 <- dplyr::left_join(df_teaching_groups, df_teaching_groups_students, by = c("id" = "group_id"))
  df_02 <- dplyr::left_join(df_02, df_subjects, by = c("subject_id" = "id"))
  df_02 <- dplyr::left_join(df_02, df_students, by = c("student_ids" = "id"))
  df_02 <- dplyr::select(df_02, c("Class" = name.x, "subject_code" = code.y, student_ids))
  df_02 <- unique(df_02)
  df <- dplyr::left_join(df, df_02, by = c("subject_code", "student_ids"))

  message(cat(crayon::silver("Compute metadata")))

  ## Create
  df$Surname.Forename.Reg <- paste0(toupper(df$preferred_last_name), " ", df$preferred_first_name, " (", df$registration_group, ")")

  message(cat(crayon::silver("Clean final output")))

  ## Tidy
  df <- dplyr::select(df, c("Staff" = display_name, "Email.Staff" = email_address,
                            "Year.Group" = national_curriculum_year, "Subject" = subject_code, Class, "Room" = room_name,
                            "UPN" = upn, "GFSID" = student_ids, Surname.Forename.Reg,
                            "Surname" = preferred_last_name, "Forename" = preferred_first_name,
                            "Reg" = registration_group, "Gender" = sex,
                            "Date" = event_date, "Timestamp" = created_timestamp,
                            "Event.Code" = code, "Event.Name" = name.x, "Event.Classification" = name.y, "Polarity" = significance,
                            "School.Notes" = school_notes))
  df <- unique(df)
  df$Email.Staff <- tolower(df$Email.Staff)

  ## Return
  return(df)
}

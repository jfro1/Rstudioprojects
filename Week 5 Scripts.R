f <- file.choose()
attendance_data <- read.csv(f)
#creating a weekend dummy variable, and then a data frame of just weekend games
attendance_data$weekend_game <- with(attendance_data, ifelse(attendance_data$day == 'Sat' | attendance_data$day == 'Sun', 1, 0))
weekend_attendance <- attendance_data[attendance_data$weekend_game == 1, ]

summary(attendance_data$attendance)
summary(weekend_attendance$attendance)

#creating regression of attendance on weekend dummy
projected_attendance <- lm(attendance_data$attendance ~ attendance_data$weekend_game)

anova(projected_attendance)
coefficients(projected_attendance)

#Part 2:
#Looking at how Justin Verlander affects Tigers' attendance
#dummy variable for Justin Verlander's home games
attendance_data$VerlanderPitching <- with(attendance_data, ifelse(attendance_data$home_starting_pitcher_name == 'Justin Verlander', 1, 0))

#creating a new data frame of just Tigers home games
Tigers_attendance <- attendance_data[attendance_data$home == 'DET',]

#regression of Tigers attendance on weekend dummy and Verlander dummy
Tigers_projected_attendance <-lm(Tigers_attendance$attendance ~ Tigers_attendance$weekend_game + Tigers_attendance$VerlanderPitching)

#displaying regression results
Tigers_projected_attendance
#showing the 95% confidence interval for each variable
confint(Tigers_projected_attendance, level = 0.95)

#adding the fitted variable and the residuals to the Tigers dataframe
Tigers_attendance$projected_attendance <- with(Tigers_attendance, fitted(Tigers_projected_attendance))
Tigers_attendance$projected_attendance_error <- with(Tigers_attendance, residuals(Tigers_projected_attendance))
summary(Tigers_attendance$projected_attendance_error)

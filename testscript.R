
#Part 2:
#Looking at how Justin Verlander affects Tigers' attendance
#dummy variable for Justin Verlander's home games
attendance_data$VerlanderPitching <- with(attendance_data, ifelse(attendance_data$home_starting_pitcher_name == 'Justin Verlander', 1, 0))

#creating a new data frame of just Tigers home games
Tigers_attendance <- attendance_data[attendance_data$home == 'DET',]

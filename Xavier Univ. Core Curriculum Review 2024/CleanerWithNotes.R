library(tidyverse)

# I renamed all the variables in my data frame to be shorter and easier to work with. No spaces, no weird characters, nothing.

# I made another column in the data to store the Semester Number as a character. 
data$SemesterNum2 <- as.character(data$SemNum)

# This creates another column that has the Cohort as a numeric value without the cohort code on the end. 
data$Cohort2 <- as.numeric(substr(data$Cohort, 1, 6))

# This filters out anyone who has not had the opportunity to be at XU for four years. 
filter(Cohort2 <202009) 

# This uses only the classes that were actually completed for credit and passed. 
filter(Grade == "A" | Grade == "A-" | Grade == "B+" | Grade == "B" | Grade == "B-" | Grade == "C+" | Grade == "C" 
       | Grade == "C-" | Grade == "D+" | Grade == "D")

# This filters out any retakes to make the data a little cleaner. 
filter(!grepl("RETAKE", Course, ignore.case = TRUE))

# This recodes the Semester Number to use 1, 2, 3, 4, 5, 6, 7, 8, 9+, and Summer for better readability and more accuracy. 
data %>% 
  select(SemesterNum2) %>% 
  mutate(
    SemesterNum2 = case_when(
      as.numeric(SemesterNum2) >= 2000 ~ "Summer",
      as.numeric(SemesterNum2) > 8 ~ "9+",
      TRUE ~ SemesterNum2
    )
  )

# This creates a bar graph that shows the percent of core classes taken in each semester at XU. 
# The commented line shows the count if you want to replace the percent. We found percent to be more helpful. 
data %>% 
  select(SemesterNum2) %>% 
  mutate(
    SemesterNum2 = case_when(
      as.numeric(SemesterNum2) >= 2000 ~ "Summer",
      as.numeric(SemesterNum2) > 8 ~ "9+",
      TRUE ~ SemesterNum2
    )
  ) %>% 
  ggplot(aes(x = SemesterNum2)) +
  # geom_bar(stat = "count", fill = 'purple', color = 'black') +
  geom_bar(aes(y = after_stat(count)/sum(after_stat(count))*100), fill = 'purple', color = 'black') +
  labs(title = "What Percent of Core Classes are Taken in Each Semester?", x = "Semester Number", y = "Percent (%)")

# This does the same as above, but it uses a specific core requirement instead of all of them. 
# Per class
data %>% 
  select(SemesterNum2, ORCO) %>% # put the class you want to explore in this line instead of CREP
  filter(ORCO == 1) %>% # change CREP to the class you are exploring
  mutate(
    SemesterNum2 = case_when(
      as.numeric(SemesterNum2) >= 2000 ~ "Summer",
      as.numeric(SemesterNum2) > 8 ~ "9+",
      TRUE ~ SemesterNum2
    )
  ) %>% 
  ggplot(aes(x = SemesterNum2)) +
  # geom_bar(stat = "count", fill = 'purple', color = 'black') +
  geom_bar(aes(y = after_stat(count)/sum(after_stat(count))*100), fill = 'navy', color = 'black') +
  labs(title = "What Percent of a Sepecific Class per Semester?", x = "Semester Number", y = "Percent (%)")

# How are students fulfilling the Oral Communication requirement?
data %>%
  filter(Cohort2 < 201909 & Cohort2 > 201505) %>%
  filter(Grade == "A" | Grade == "A-" | Grade == "B+" | Grade == "B" | Grade == "B-" | Grade == "C+" | Grade == "C" 
         | Grade == "C-" | Grade == "D+" | Grade == "D") %>%
  # filter(Major == "BIMS") %>% 
  filter(ORCO == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  ggplot(aes(x = fct_infreq(Course))) +
  geom_bar(stat = "count", fill = 'pink', color = 'pink') +
  # theme(panel.background = element_rect(fill = 'grey')) +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%"))) +
  labs(title = "How do students fulfill ORCO?", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

# What students are taking COMM 101 to fulfill ORCO?
data %>%
  filter(Cohort2 < 201909 & Cohort2 > 201505) %>%
  filter(Grade == "A" | Grade == "A-" | Grade == "B+" | Grade == "B" | Grade == "B-" | Grade == "C+" | Grade == "C" 
         | Grade == "C-" | Grade == "D+" | Grade == "D") %>%
  filter(ORCO == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  filter(Course == "COMM 101") %>% 
  ggplot(aes(x = fct_infreq(Major))) +
  geom_bar(stat = "count", fill = 'lightblue', color = 'navy') +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%"))) +
  labs(title = "Who is taking COMM 101?", x = "Major", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))


# Number of Students in each major
# Step 1: Remove duplicates based on Student and Major
unique_students <- unique(data[, c("Student", "Major")])
# Step 2: Count the number of students in each major
major_counts <- table(unique_students$Major)
# Step 3: Convert the table to a data frame and sort by counts in descending order
major_counts_df <- data.frame(
  Major = names(major_counts),
  Count = as.numeric(major_counts),
  stringsAsFactors = FALSE
)
major_counts_df <- major_counts_df[order(-major_counts_df$Count), ]
# Step 4: Create a bar chart using ggplot2
ggplot(major_counts_df, aes(x = reorder(Major, -Count), y = Count)) +
  geom_bar(stat = "identity", fill = "skyblue") +
  labs(
    title = "Number of Students in Each Major",
    x = "Major",
    y = "Number of Students"
  ) +
  geom_text(aes(label = paste0(round(Count / sum(Count) * 100, 1), "%")),
            vjust = -0.5, hjust = 0.2, size = 2) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) 



# Box plots that show when students are fulfilling each Core Requirement
data %>% 
  filter(SemNum <= 8) %>% 
  pivot_longer(cols = (12:33), names_to = "Requirement", values_to = "Met") %>% 
  filter(Met == 1) %>% 
  ggplot(aes(x = SemNum, y = reorder(Requirement,SemNum, mean))) +
  geom_boxplot(fill = 'yellow', color = 'blue') +
  theme_minimal() +
  # theme(panel.background = element_rect(fill = 'lightgrey')) +
  scale_x_continuous(breaks = seq(1,8, by = 1)) +
  # theme(axis.text.x = element_text(angle = 45, hjust = 1)) +  # Rotate x-axis labels for better readability
  labs(title = "When are Students taking each Course?", x = "Semester Number at XU", y = "Core Requirement")


library(tidyverse)

valid_majors <- c("MACS", "BIOC", "BSFB", "BIOL", "BIMS", "BIOP", "CHEM", "DSCI", "ENPH", "ENVS", "MATH", "PHYS", 
                  "ADVE", "ARTS", "CLHU", "CMST", "DIFT", "DIME", "ECSS", "ENGL", "FREN", "GDST", "GRAP", "HIST", "INST", "MUED", 
                  "MUSC", "MUTR", "PHIL", "PPPU", "POLI", "PUBL", "SOCI", "SPAN", "THTR", "THED", "THEO", "EXPL", "LART",
                  "NURE", "NURS",
                  "CJUS", "EXES", "HSEA", "PSYC", "SOCW", "SPMG", "SPMK",
                  "MCED", "MONT", "ECED", "SPEC", "ELEM", "TLSC", "SEDU",
                  "ACCT", "BAIS", "BUUN", "ECON", "ENTR", "FINC", "INBU", "MGMT", "MKTG")

stem_majors <- c("MACS", "BIOC", "BSFB", "BIOL", "BIMS", "BIOP", "CHEM", "DSCI", "ENPH", "ENVS", "MATH", "PHYS")

hume_majors <- c("ADVE", "ARTS", "CLHU", "CMST", "DIFT", "DIME", "ECSS", "ENGL", "FREN", "GDST", "GRAP", "HIST", "INST", "MUED", 
                 "MUSC", "MUTR", "PHIL", "PPPU", "POLI", "PUBL", "SOCI", "SPAN", "THTR", "THED", "THEO", "EXPL", "LART")

nurse_majors <- c("NURE", "NURS")

cps_majors <- c("CJUS", "EXES", "HSEA", "PSYC", "SOCW", "SPMG", "SPMK")

edu_majors <- c("MCED", "MONT", "ECED", "SPEC", "ELEM", "TLSC", "SEDU")

business_majors <- c("ACCT", "BAIS", "BUUN", "ECON", "ENTR", "FINC", "INBU", "MGMT", "MKTG")

# all_majors <- my_data %>% 
#   filter(Major %in% valid_majors)
# #View(commons)

all_majors <- data %>%
  filter(Major %in% valid_majors)
#View(commons)

stem_data <- all_majors %>% 
  filter(Major %in% stem_majors)

hume_data <- all_majors %>% 
  filter(Major %in% hume_majors)

nurse_data <- all_majors %>% 
  filter(Major %in% nurse_majors)

cps_data <- all_majors %>% 
  filter(Major %in% cps_majors)

edu_data <- all_majors %>% 
  filter(Major %in% edu_majors)

business_data <- all_majors %>% 
  filter(Major %in% business_majors)




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





# EDUCATION MAJORS

# How are Education students fulfilling the Oral Communication requirement?
edu_data %>%
  # filter(Grade == "A" | Grade == "A-" | Grade == "B+" | Grade == "B" | Grade == "B-" | Grade == "C+" |
  #          Grade == "C" | Grade == "C-" | Grade == "D+" | Grade == "D") %>%
  # filter(Major == "ECED") %>% 
  filter(ORCO == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  ggplot(aes(x = fct_infreq(Course))) +
  geom_bar(stat = "count", fill = 'pink', color = 'hotpink') +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%"))) +
  labs(title = "How do Education students fulfill ORCO?", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

# What Education majors are taking COMM 101 to fulfill ORCO?
edu_data %>%
  # filter(Grade == "A" | Grade == "A-" | Grade == "B+" | Grade == "B" | Grade == "B-" | Grade == "C+" | 
  #   Grade == "C" | Grade == "C-" | Grade == "D+" | Grade == "D") %>%
  filter(ORCO == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  filter(Course == "COMM 101") %>% 
  ggplot(aes(x = fct_infreq(Major))) +
  geom_bar(stat = "count", fill = 'lightblue', color = 'blue') +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%"))) +
  labs(title = "Who is taking COMM 101?", x = "Major", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

# How are Education students fulfilling the Humanities requirement?
# Not much insight...
edu_data %>%
  # filter(Cohort2 < 201909 & Cohort2 > 201505) %>%
  # filter(Grade == "A" | Grade == "A-" | Grade == "B+" | Grade == "B" | Grade == "B-" | Grade == "C+" | 
  # Grade == "C" | Grade == "C-" | Grade == "D+" | Grade == "D") %>%
  filter(Major == "SPEC" | Major == "TLSC" | Major == "SEDU") %>% 
  filter(HUME == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  ggplot(aes(x = fct_infreq(Course))) +
  geom_bar(stat = "count", fill = 'limegreen', color = 'darkgreen') +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%"))) +
  labs(title = "How do Education students fulfill the Humanities Elective?", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

# How are Education students fulfilling the Creative Perspectives requirement?
edu_data %>%
  # filter(Cohort2 < 201909 & Cohort2 > 201505) %>%
  # filter(Grade == "A" | Grade == "A-" | Grade == "B+" | Grade == "B" | Grade == "B-" | Grade == "C+" |
  # Grade == "C" | Grade == "C-" | Grade == "D+" | Grade == "D") %>%
  # filter(Major == "ECED") %>% 
  filter(CREP == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  ggplot(aes(x = fct_infreq(Course))) +
  geom_bar(stat = "count", fill = 'purple', color = 'black') +
  # geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%"))) +
  labs(title = "How do Education students fulfill CREP?", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))

# How are Education students fulfilling the ERS requirement?
edu_data %>%
  # filter(Cohort2 < 201909 & Cohort2 > 201505) %>%
  # filter(Grade == "A" | Grade == "A-" | Grade == "B+" | Grade == "B" | Grade == "B-" | Grade == "C+" |
  # Grade == "C" | Grade == "C-" | Grade == "D+" | Grade == "D") %>%
  filter(Major == "MCED" | Major == "SPEC") %>% 
  filter(ERS == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  ggplot(aes(x = fct_infreq(Course))) +
  geom_bar(stat = "count", fill = 'purple', color = 'black') +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%")), 
            vjust = -0.5, hjust = 0.4, position = position_dodge(width = 0.5)) +
  labs(title = "How do Education students fulfill ERS?", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))







# BUSINESS

# Calculus

business_data %>% 
  filter(MATP == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  ggplot(aes(x = fct_infreq(Course))) +
  geom_bar(stat = "count", fill = 'purple', color = 'black') +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%")), 
            vjust = -0.5, hjust = 0.4, position = position_dodge(width = 0.5)) +
  labs(title = "How do Business students fulfill MATP?", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
# WCB students are taking Math 140 for Calc

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

business_data %>% 
  filter(Course == "MATH 140") %>% 
  filter(SemNum <= 8) %>% 
  ggplot(aes(x = SemNum)) +
  geom_boxplot(fill = "orange") +
  theme_minimal() +
  scale_x_continuous(breaks = seq(1,8, by = 1)) +
  labs(title = "When do WCB Students take MATH 140?", x = "Semester Number at XU")




nurse_data %>% 
  filter(HUME == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  ggplot(aes(x = fct_infreq(Course))) +
  geom_bar(stat = "count", fill = 'hotpink', color = 'black') +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%")), 
            vjust = -0.5, hjust = 0.15, position = position_dodge(width = 0.5)) +
  labs(title = "How do Nursing students fulfill HUME?", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
# 11.7% of Nursing students use THEO 312 to fulfill their HUME credit.

nurse_data %>% 
  filter(THEP == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  ggplot(aes(x = fct_infreq(Course))) +
  geom_bar(stat = "count", fill = 'red', color = 'black') +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%")), 
            vjust = -0.5, hjust = 0.15, position = position_dodge(width = 0.5)) +
  labs(title = "How do Nursing students fulfill THEP?", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
# 21.9% of Nursing students use THEO 312 to fulfill their HUME credit.

all_majors %>% 
  filter(Course == "THEO 312") %>% 
  ggplot(aes(x = fct_infreq(Major))) +
  geom_bar(stat = "count", fill = "pink") +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%")),
            vjust = -0.5, hjust = 0.15, #position = position_stack(vjust = 0.5)
            ) +
  labs(title = "Who is taking THEO 312?", x = "Major", y = "Count") + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
# 53.4% of students taking THEO 312 are Nursing students. 

nurse_data %>% 
  filter(CREP == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  ggplot(aes(x = fct_infreq(Course))) +
  geom_bar(stat = "count", fill = 'orange', color = 'black') +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%")), 
            vjust = -0.5, hjust = 0.15, position = position_dodge(width = 0.5)) +
  labs(title = "How do Nursing students fulfill CREP?", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
# 12.9% of Nursing students take ARTS 111 to fulfill CREP.

all_majors %>% 
  filter(Course == "ARTS 111") %>% 
  ggplot(aes(x = fct_infreq(Major))) +
  geom_bar(stat = "count", fill = "yellow") +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%")),
            vjust = -0.5, hjust = 0.15, #position = position_stack(vjust = 0.5)
  ) +
  labs(title = "Who is taking ARTS 111?", x = "Major", y = "Count") + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
# 24% of students taking ARTS 111 are Nursing students. 

nurse_data %>% 
  filter(ERS == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  ggplot(aes(x = fct_infreq(Course))) +
  geom_bar(stat = "count", fill = 'green', color = 'black') +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%")), 
            vjust = -0.5, hjust = 0.15, position = position_dodge(width = 0.5)) +
  labs(title = "How do Nursing students fulfill ERS?", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
# 19.7% of Nursing students take THEO 312 to fulfill ERS.

View(all_majors)

# MARKETING MAJORS
all_majors %>% 
  filter(Major == "MKTG") %>% 
  filter(HUME == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  ggplot(aes(x = fct_infreq(Course))) +
  geom_bar(stat = "count", fill = 'hotpink') +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%")), 
            vjust = -0.5, hjust = 0.15, position = position_dodge(width = 0.5)) +
  labs(title = "How do MKTG students fulfill HUME?", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
# 6.1% of MKTG majors take EDCH 324 to fulfill HUME. 

all_majors %>% 
  filter(Course == "EDCH 324") %>% 
  ggplot(aes(x = fct_infreq(Major))) +
  geom_bar(stat = "count", fill = "pink") +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%")),
            vjust = -0.5, hjust = 0.15, #position = position_stack(vjust = 0.5)
  ) +
  labs(title = "Who is taking EDCH 324?", x = "Major", y = "Count") + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
# 6.8% of EDCH 324 students are MKTG majors. 

all_majors %>% 
  filter(Major == "MKTG") %>% 
  filter(THEP == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  ggplot(aes(x = fct_infreq(Course))) +
  geom_bar(stat = "count", fill = 'red', color = 'black') +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%")), 
            vjust = -0.5, hjust = 0.15, position = position_dodge(width = 0.5)) +
  labs(title = "How do MKTG students fulfill THEP?", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
# 7.2% of MKTG majors take THEO 264 to fulfill THEP.

all_majors %>% 
  filter(Course == "THEO 264") %>% 
  ggplot(aes(x = fct_infreq(Major))) +
  geom_bar(stat = "count", fill = "pink") +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%")),
            vjust = -0.5, hjust = 0.15, #position = position_stack(vjust = 0.5)
  ) +
  labs(title = "Who is taking THEO 264?", x = "Major", y = "Count") + 
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
# 10.8% of THEO 264 students are MKTG majors. 

all_majors %>% 
  filter(Major == "MKTG") %>% 
  filter(CREP == 1 & !grepl("RETAKE", Course, ignore.case = TRUE)) %>% 
  ggplot(aes(x = fct_infreq(Course))) +
  geom_bar(stat = "count", fill = 'orange', color = 'black') +
  geom_text(stat = "count", aes(label = paste0(round(after_stat(count)/sum(after_stat(count))*100, 1), "%")), 
            vjust = -0.5, hjust = 0.15, position = position_dodge(width = 0.5)) +
  labs(title = "How do MKTG students fulfill CREP?", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))
# 6.4% of MKTG students take MUSC 117 to fulfill CREP. 

business_data %>% 
  length(unique(Student))

length(unique(business_data$Student))

business_data %>% 
  filter(THEO.111 == 0) %>% 
  length(unique(Student))

business_data %>%
  #filter(THEO.111 == 1) %>%
  summarise(n_distinct(Student))

library(tidyverse)

# freebies <- data %>% 
#   filter(
#     (
#       Major == "MACS" & (
#         MATP == 1 | QRFull == 1 | SOCS == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "BIOC" & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "BSFB" & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | ERS == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "BIOL" & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | ERS == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "BIOP" & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "CHEM" & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | MATP == 1 | QRFull == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "CSCI" & (
#         ERS == 1 | MATP == 1 | QRFull == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "DSCI" & (
#         ERS == 1 | MATP == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "ENPH" & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | MATP == 1 | QRFull == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "ENVS" & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | ERS == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | THEP == 1 | SOCS == 1 | HUME == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "MATH" & (
#         MATP == 1 | QRFull == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "PHYS" & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | MATP == 1 | QRFull == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "ADVE" & (
#         ERS == 1 | DivF == 1 | QRFull == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "ARTS" & (
#         ERS == 1 | DivF == 1 | CREP == 1 | QRFull == 1 
#       )
#     ) | (
#       Major == "CLHU" & (
#         LMI == 1 | ERS == 1 | DivF == 1 | CREP == 1 | HISP == 1 | SOCS == 1 | HUME == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "CMST" & (
#         ERS == 1 | DivF == 1 | QRFull == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "DIFT" & (
#         ERS == 1 | DivF == 1 | CREP == 1 | QRFull == 1 | HUME == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "DIME" & (
#         ERS == 1 | QRFull == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "ECSS" & (
#         ERS == 1 | DivF == 1 | QRFull == 1 | THEP == 1 | HUME == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "ENGL" & (
#         LMI == 1 | ERS == 1 | CREP == 1 | QRFull == 1 | HUME == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "FREN" & (
#         ERS == 1 | DivF == 1 | HUME == 1
#       )
#     ) | (
#       Major == "GDST" & (
#         ERS == 1 | DivF == 1 | SOCS == 1 | HUME == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "GRAP" & (
#         ERS == 1 | CREP == 1 | HUME == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "HIST" & (
#         ERS == 1 | DivF == 1 | HISP == 1 | HUME == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "INST" & (
#         ERS == 1 | DivF == 1 | CREP == 1 | SOCS == 1 | HUME == 1 | ORCO == 1
#       )
#     ) | (
#       Major == "MUED" & (
#         CREP == 1 | QRFull == 1 | SOCS == 1 | HUME == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "MUSC" & (
#         CREP == 1 | QRFull == 1
#       )
#     ) | (
#       Major == "MUTR" & (
#         CREP == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "ORGL" & (
#         DivF == 1 | SOCS == 1
#       )
#     ) | (
#       Major == "PHIL" & (
#         PHIL.100 == 1 | ERS == 1 | DivF == 1 | PHIP == 1 | HUME == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "PPPU" & (
#         PHIL.100 == 1 | ENGL.101.115 == 1 | DivF == 1 | HISP == 1 | MATP == 1 | QRFull == 1 | PHIP == 1 | SOCS == 1 | HUME == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "POLI" & (
#         ERS == 1 | DivF == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "PUBL" & (
#         ERS == 1 | DivF == 1 | QRFull == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "SOCI" & (
#         ERS == 1 | DivF == 1 | SOCS == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "SPAN" & (
#         LMI == 1 | ERS == 1 | HUME == 1 | ORCO == 1
#       )
#     ) | (
#       Major == "THTR" & (
#         CREP == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "THED" & (
#         CREP == 1 | SOCS == 1 | HUME == 1
#       )
#     ) | (
#       Major == "THEO" & (
#         THEO.111 == 1 | ERS == 1 | THEP == 1 | HUME == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "ACCT" & (
#         ERS == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "BAIS" & (
#         ERS == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "BUUN" & (
#         ERS == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "ECON" & (
#         ERS == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "ENTR" & (
#         ERS == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "FINC" & (
#         ERS == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "INBU" & (
#         LMI == 1 | ERS == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "MGMT" & (
#         ERS == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "MKTG" & (
#         ERS == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "CJUS" & (
#         SPLect == 1 | SPLab == 1 | DivF == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "EXES" & (
#         DivF == 1 | QRFull == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "HSEA" & (
#         ERS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "PSYC" & (
#         SPLect == 1 | SPLab == 1 | ERS == 1 | DivF == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "SOCW" & (
#         ERS == 1 | DivF == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "SPMG" & (
#         ERS == 1 | DivF == 1 | CREP == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "SPMK" & (
#         ERS == 1 | DivF == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "MCED" & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | SOCS == 1 | HUME == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "MONT" & (
#         ERS == 1 | DivF == 1 | CREP == 1 | SOCS == 1 | HUME == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "ECED" & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | ERS == 1 | DivF == 1 | CREP == 1 | QRFull == 1 | SOCS == 1 | HUME == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "SPEC" & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | DivF == 1 | QRFull == 1 | SOCS == 1
#       )
#     ) | (
#       Major == "ELEM" & (
#         ERS == 1 | DivF == 1 | CREP == 1 | SOCS == 1 | HUME == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "TLSC" & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | ERS == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       Major == "SEDU" & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | ERS == 1 | DivF == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) | (
#       (Major == "NURE" | Major == "NURS") & (
#         SPLect == 1 | SPLab == 1 | NSLect == 1 | NSLab == 1 | DivF == 1 | MATP == 1 | QRFull == 1 | SOCS == 1 | ORCO == 1 | WRIT == 1
#       )
#     ) 
#   )


temp_extras <- anti_join(data, freebies)

valid_majors <- c("MACS", "BIOC", "BSFB", "BIOL", "BIMS", "BIOP", "CHEM", "DSCI", "ENPH", "ENVS", "MATH", "PHYS", 
                  "ADVE", "ARTS", "CLHU", "CMST", "DIFT", "DIME", "ECSS", "ENGL", "FREN", "GDST", "GRAP", "HIST", "INST", "MUED", 
                  "MUSC", "MUTR", "ORGL", "PHIL", "PPPU", "POLI", "PUBL", "SOCI", "SPAN", "THTR", "THED", "THEO", "EXPL", "LART",
                  "NURE", "NURS",
                  "CJUS", "EXES", "HSEA", "PSYC", "SOCW", "SPMG", "SPMK",
                  "MCED", "MONT", "ECED", "SPEC", "ELEM", "TLSC", "SEDU",
                  "ACCT", "BAIS", "BUUN", "ECON", "ENTR", "FINC", "INBU", "MGMT", "MKTG")

extras <- temp_extras %>% 
  filter(Major %in% valid_majors)

# install.packages("writexl")
library(writexl)

write_xlsx(x = freebies, path = "inMajors.xlsx", col_names = TRUE)
write_xlsx(x = extras, path = "notInMajors.xlsx", col_names = TRUE)

library(readxl)
reqs <- read_xlsx("CoursesInMajors.xlsx")
View(reqs)

valid_majors <- c("MACS", "BIOC", "BSFB", "BIOL", "BIMS", "BIOP", "CHEM", "DSCI", "ENPH", "ENVS", "MATH", "PHYS", 
                  "ADVE", "ARTS", "CLHU", "CMST", "DIFT", "DIME", "ECSS", "ENGL", "FREN", "GDST", "GRAP", "HIST", "INST", "MUED", 
                  "MUSC", "MUTR", "ORGL", "PHIL", "PPPU", "POLI", "PUBL", "SOCI", "SPAN", "THTR", "THED", "THEO", "EXPL", "LART",
                  "NURE", "NURS",
                  "CJUS", "EXES", "HSEA", "PSYC", "SOCW", "SPMG", "SPMK",
                  "MCED", "MONT", "ECED", "SPEC", "ELEM", "TLSC", "SEDU",
                  "ACCT", "BAIS", "BUUN", "ECON", "ENTR", "FINC", "INBU", "MGMT", "MKTG")


reqs$RowSums <- rowSums(reqs[, 4:25], na.rm = TRUE)
View(reqs)

reqs$Major <- factor(reqs$Major, levels = reqs$Major[order(-reqs$RowSums, reqs$Category)])

# What percent of the Core is fulfilled in each major?
reqs %>% 
  filter(Major != "NURS" & Major != "ORGL") %>% 
  ggplot(aes(x = reorder(Major, -RowSums), y = (RowSums/22), fill = Category)) +
  geom_bar(stat = "identity") +
  labs(x = "Major", y = "Proportion of Requirements", title = "Requirements Fulfilled by Majors") +
  scale_y_continuous(breaks = seq(0,0.6, by = 0.1)) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) +
  scale_fill_manual(values = c("Stem" = "green", "Hum/SocSci" = "purple", "Business" = "blue", "CPS" = "red", "Education" = "orange", "Nursing" = "yellow"))



# What percent of majors fulfill each Core Requirement?
reqs2 <- reqs %>% 
  filter(Major != "NURS")

reqs2 <- reqs2[, 4:25]

# Step 1: Calculate column sums
ColSums <- colSums(reqs2)

# Calculate percentages relative to a total of 63
percentages <- (ColSums / 63) * 100

# Step 2: Combine column names and percentages into a data frame
summary_data <- data.frame(ColNames = colnames(reqs2), Percent = percentages)

summary_data$ColNames <- factor(summary_data$ColNames, levels = summary_data$ColNames[order(summary_data$Percent, decreasing = FALSE)])


# Step 3: Plot using ggplot2
ggplot(summary_data, aes(x = Percent, y = ColNames)) +
  geom_bar(stat = "identity", fill = "hotpink") +
  labs(x = "Percent of Majors (%)", y = "Requirement", title = "What Percent of Majors Fulfill each Core Requirement") +
  theme_minimal()

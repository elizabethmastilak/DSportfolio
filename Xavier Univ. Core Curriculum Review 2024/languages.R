library(tidyverse)

data %>% 
  filter(LANG == 1) %>% 
  filter(Major != "SPAN" & Major != "FREN" & Major != "GERM") %>% 
  filter(CohortCode == "NF") %>% 
  # filter(Cohort2 <202009) %>% 
  filter(Grade == "A" | Grade == "A-" | Grade == "B+" | Grade == "B" | Grade == "B-" | Grade == "C+" | Grade == "C" | Grade == "C-" | Grade == "D+" | Grade == "D") %>%
  ggplot(aes(x = Course)) +
  geom_bar(stat = "count", fill = 'pink', color = 'black') +
  labs(title = "Languages", x = "Course", y = "Count") +
  theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))


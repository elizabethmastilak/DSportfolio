#### Load packages ####
library(tidyverse)  # The tidyverse collection of packages
library(httr)       # Useful for web authentication
library(rvest)      # Useful tools for working with HTML and XML
library(magrittr)   # Piping output easily with loops

# Setting user configuration for scraping
set_config(user_agent("<mastilake@xavier.edu>; +https://www.xavier.edu/business-analytics-program"))

test_url <- read_html("https://www.unigo.com/colleges/auburn-university")

reviewer_name <- 
  test_url %>% 
  html_elements("div.reviews-list") %>% 
  html_nodes("strong") %>% 
  html_text2()

review_date <- 
  test_url %>% 
  html_elements("div.reviews-list") %>% 
  html_nodes("span") %>% 
  html_text2()

review_text <- 
  test_url %>% 
  html_elements("div.reviews-list") %>% 
  html_nodes("p") %>% 
  html_text2()

schools_names <- c("Auburn University",
                   "Emory University",
                   "Louisiana State University", 
                   "Michigan State University",
                   "Pennsylvania State University",
                   "Purdue University", 
                   "University of Cincinnati")

schools_ids <- c("auburn-university",
                 "emory-university",
                 "louisiana-state-university-and-agricultural-and-mechanical-college",
                 "michigan-state-university",
                 "pennsylvania-state-university-main-campus",
                 "purdue-university-main-campus",
                 "university-of-cincinnati-main-campus")

unigo_url <- "https://www.unigo.com/colleges/"

create_urls <- function(base_url, school_id) {
  urls_to_scrape <- paste(base_url, school_id, sep="")
  return(urls_to_scrape)
}

scrape_university <- function(uni_url) {
  uni_html <- read_html(uni_url)
  
  reviewer_name <- 
    uni_html %>% 
    html_elements("div.reviews-list") %>% 
    html_nodes("strong") %>% 
    html_text2()
  
  review_date <- 
    uni_html %>% 
    html_elements("div.reviews-list") %>% 
    html_nodes("span") %>% 
    html_text2()
  
  review_text <- 
    uni_html %>% 
    html_elements("div.reviews-list") %>% 
    html_nodes("p") %>% 
    html_text2()
  
  uni_df <- tibble(reviewer_name, review_date, review_text)
  
  return(uni_df)
}





scrape_unigo <- function(base_unigo, school_ids, school_names) {
  all_reviews <- data.frame()
  
  for(i in seq_along(school_ids)) {
    url_to_scrape <- create_url(base_unigo, school_ids[i])
    
    all_reviews <- 
      scrape_university(url_to_scrape) %>% 
      mutate(school_name = school_names[i]) %>% 
      bind_rows(all_reviews)
    
    Sys.sleep(2)
  }
  
  return(all_reviews)
}

university_reviews <- scrape_unigo(unigo_url, schools_ids, schools_names)

write_csv(university_reviews, "unigo_data.csv")


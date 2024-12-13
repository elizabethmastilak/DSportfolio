#### Load Packages ####
library(tidyverse)          # for dplyr and data wrangling
library(httr)               # for web authentication
library(rvest)              # for html tools
library(magrittr)           # for piping and loops

# Setting user configuration for scraping Goodreads
set_config(user_agent("<mastilake@xavier.edu>; +https://www.xavier.edu/business-analytics-program"))

#### Trying one page ####

hf_html <- 
  read_html("https://www.goodreads.com/shelf/show/historical-fiction")

bookTitle <- 
  hf_html %>% 
  html_elements("a.bookTitle") %>% 
  html_text2()

authorName <- 
  hf_html %>% 
  html_nodes('[itemprop="name"]') %>% 
  html_text2()

messyRatings <- 
  hf_html %>% 
  html_nodes('.greyText.smallText') %>% 
  html_text2()

hf_data_messy <- 
  tibble(bookTitle, authorName, messyRatings)

hf_data <- hf_data_messy %>%
  separate(messyRatings, 
           into = c("rating_info", "count_info", "published_info"), 
           sep = " — ", 
           extra = "merge", 
           fill = "right")

hf_data <- hf_data %>%
  mutate(rating = str_extract(rating_info, "\\d+\\.\\d+|\\d+") %>% as.numeric()) %>% 
  select(-rating_info)

hf_data <- hf_data %>% 
  mutate(ratingsCount = str_replace(count_info, " ratings$", "")) %>% 
  select(-count_info)

hf_data <- hf_data %>% 
  mutate(ratingsCount = str_replace_all(ratingsCount, ",", "") %>% 
           as.numeric())

hf_data <- hf_data %>% 
  mutate(yearPublished = str_sub(published_info, -4, -1) %>% 
           as.numeric()) %>% 
  select(-published_info)

hf_data <- hf_data %>% 
  mutate(genre = "Historical Fiction")


#### Function and Loop ####

genres <- c("biography", "classics", "historical-fiction", "mystery")
gr_html <- "https://www.goodreads.com/shelf/show/"


# Function to get the data from one page, do some data wrangling, and 
# return a data frame. 
GR_collect <- function(url) {
  
  # Create a variable for the url to scrape
  #url_to_scrape <- paste(url, genre, sep="")
  gr_html <- read_html(url)
  
  # Get book names
  bookTitle <- 
    gr_html %>% 
    html_elements("a.bookTitle") %>% 
    html_text2()
  
  # Get author names
  authorName <- 
    gr_html %>% 
    html_nodes('[itemprop="name"]') %>% 
    html_text2()
  
  # Get info about ratings and publishing
  messyRatings <- 
    gr_html %>% 
    html_nodes('.greyText.smallText') %>% 
    html_text2()
  
  # Turn it into a data frame
  gr_data_messy <- 
    tibble(bookTitle, authorName, messyRatings)
  
  # Clean up ratings and publishing
  gr_data <- gr_data_messy %>%
    separate(messyRatings, 
             into = c("rating_info", "count_info", "published_info"), 
             sep = " — ", 
             extra = "merge", 
             fill = "right")
  
  # Rating
  gr_data <- gr_data %>%
    mutate(rating = str_extract(rating_info, "\\d+\\.\\d+|\\d+") %>% as.numeric()) %>% 
    select(-rating_info)
  
  # Number of ratings
  gr_data <- gr_data %>% 
    mutate(ratingsCount = str_replace(count_info, " ratings$", "")) %>% 
    select(-count_info)
  
  gr_data <- gr_data %>% 
    mutate(ratingsCount = str_replace_all(ratingsCount, ",", "") %>% 
             as.numeric())
  
  # Publication year
  gr_data <- gr_data %>% 
    mutate(yearPublished = str_sub(published_info, -4, -1) %>% 
             as.numeric()) %>% 
    select(-published_info)
  
  return(gr_data)
  
}



# Function to loop through the genres and scrape the data from each page. 

GR_scrape <- function(base_url, genre_list) {
  all_books <- data.frame()
  
  for (i in seq_along(genre_list)) {
    
    print(paste("Collecting page",i))
    
    all_books <- 
      GR_collect(paste(base_url, genre_list[i], sep="")) %>% 
      mutate(Genres = genre_list[i]) %>% 
      bind_rows(all_books)
    
    
    print(paste(genre_list[i], "collected"))
    print(paste(nrow(all_books), "books collected so far"))
    
    if (i != length(genre_list)) {
      Sys.sleep(runif(1,2,7))
    }
    
    
  }
  return(all_books)
}



gr_test_df <- GR_scrape(gr_html, genres)


#write_csv(gr_test_df, "goodreads_data.csv")




# Load Packages
library(tidyverse)
library(rvest)

# Get the rushing data
# 2a-c

espnRawList <- read_html(x="https://www.espn.com/college-football/team/stats/_/id/213/penn-state-nittany-lions") %>%
  html_elements(css="table")%>%
  html_table()

# 2 d

espnRushingRaw <- bind_cols(espnRawList[[3]], espnRawList[[4]])

# Get roster data

#3 a-c 

psuRawList <- read_html(x="https://gosusports.com/sports/football/roster?view=table") %>%
  html_elements(css="table")%>%
  html_table()


# 3 d
psuRosterRaw <- psuRawList[[1]]


# clean data

#2 e (espn data)
# drop "total" row
# separate name from position of player

espnRushing <- espnRushingRaw %>%
                filter(Name !="Total") %>%
                separate_wider_delim(
                  cols = Name,
                  delim=" ",
                  names= c("First","Last","Position1"),
                  too_many="merge"
                ) %>%
                seperate_wider_delim(
                  cols= Position1,
                  delim=" ",
                  names= c("last1","Position"),
                  too_few="align_end"
                ) %>%
                unite(
                  cols="name",
                  First,
                  Last,
                  last1,
                  sep= " ",
                  na.rm=TRUE
                )

#3 e (psu data)
psuRoster <- psuRosterRaw %>%
            dplyr::select('#',Name,Position,weight) %>%
            remane("Number" = "#") %>%
            mutate(
              Number = paste0("#",Number)
            )

# 4 Combining data
psuRushing <- left_join(
              x= espnRushing,
              y=psuRoster,
              by= join_by(Name==Name, Position==Position)
)
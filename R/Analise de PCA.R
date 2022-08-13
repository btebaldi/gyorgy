

# Setup -------------------------------------------------------------------

rm(list = ls())

library(readxl)



db <- read_excel("../Simulacao GYORGY.xlsx", 
                 col_types = c("date", "numeric", "numeric", 
                               "numeric", "numeric", "numeric", 
                               "numeric", "numeric", "numeric", 
                               "numeric", "numeric", "numeric", 
                               "numeric", "numeric", "numeric", 
                               "numeric", "numeric", "numeric"), 
                 skip = 1)

db$Data <- as.Date(db$Data)
db

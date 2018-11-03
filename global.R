##-------- Global Script ---------

## Package Loading
library(tidyverse)
library(shiny)
library(shinydashboard)
library(magick)

## Data Importing
gin.cocktail <- read.csv("https://s3-ap-southeast-2.amazonaws.com/koki25ando/Gin_Main.csv", stringsAsFactors=FALSE)

## Data Transforming for recommendation system

cocktail.reco <- gin.cocktail[,c(2,10,12:15)] %>% 
  na.omit() %>% 
  unique()

# cocktail.reco <- gin.tidy %>% 
#   spread(key = Ingredient, value = Element)



## Data setting for whisky recommendation page

whisky <- read.csv("http://outreach.mathstat.strath.ac.uk/outreach/nessie/datasets/whiskies.txt")
whisky <- whisky[2:14]

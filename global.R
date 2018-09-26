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
  unique() %>% 
  spread(key = Ingredient, value = Element)
<<<<<<< HEAD



## Data setting for whisky recommendation page

whisky <- read.csv("http://outreach.mathstat.strath.ac.uk/outreach/nessie/datasets/whiskies.txt")
whisky <- whisky[2:14]
=======
>>>>>>> 7a7f6b6506b46391507f7c574d725b4e471f0e26

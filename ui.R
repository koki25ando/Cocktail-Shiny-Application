##-------- UI Script ---------

###-------- Header ---------

header <- dashboardHeader(
  title = "Gin-Cocktail Recipe"
)

###-------- Sidebar ---------

sidebar <- dashboardSidebar(
  sidebarMenu(
    menuItem("Search Cocktail", tabName = "coktail_search", icon = icon("search")),
    menuItem("Cocktail Recommendation", tabName = "cocktail_recommendation", icon = icon("glass")),
    menuItem("Whisky Recommendation", tabName = "whisky_recommendation", icon = icon("thumbs-up")),
    menuItem("Information", tabName = "information", icon = icon("info"))
  )
)

###-------- Body ---------

body <- dashboardBody(
  tabItems(
    tabItem(tabName = "coktail_search",
      fluidRow(
        box(
          selectInput(
            inputId = "base_liquor",
            label = "Select Base Liquour: ",
            choices = c("Gin"),
            selected = "Gin"
          ),
          selectizeInput(
            inputId = "cocktail_name",
            label = "Type Cocktail Name",
            choices = unique(gin.cocktail$Name),
            selected = "Gin Tonica"
          ),
          submitButton("Seach Cocktail!"),
          width = 4, height = 250
        ),
        box(
          width = 3, height = 300,
          title = HTML(paste0("Cocktail Image: ", 
                              strong(em(textOutput(outputId = "selected_cocktail_name"))))),
          imageOutput("img", width = "100%", height = "100%")
        ),
        box(
          width = 5, height = 250,
          title = HTML(paste0("Cocktail Recipe: ", 
                              strong(em(textOutput(outputId = "selected_cocktail_name2"))))),
          tableOutput(outputId = "recipe_table")
        )
      )
    ),
    
    tabItem(tabName = "cocktail_recommendation",
      fluidRow(
        box(
          selectInput(
            inputId = "base_liquor",
            label = "Select Base Liquour: ",
            choices = c("Gin"),
            selected = "Gin"
          ),
          submitButton("Seach Cocktail!"),
          # width = 4, height = 250
          width = 4, height = 250
        ),
        box(
          tableOutput(outputId = "ranking_table"),
          width = 12, height = 400
        )
      )
    ),
    tabItem(tabName = "whisky_recommendation",
      fluidRow(
        box(
          selectInput(
            inputId = "FirstPref",
            label = "Select your 1st Preference:",
            choices = names(whisky[,-1]),
            selected = "Body"
          ),
          selectInput(
            inputId = "SecondPref",
            label = "Select your 2nd Preference:",
            choices = names(whisky[,-1]),
            selected = "Sweetness"
          ),
          selectInput(
            inputId = "ThirdPref",
            label = "Select your 3rd Preference:",
            choices = names(whisky[,-1]),
            selected = "Smoky"
          ),
          submitButton("Seach Whisky!"),
          width = 5, height = 400),
        box(
          plotOutput(outputId = "score_viz"),
          width = 7, height = 400
          ),
        box(
          DT::dataTableOutput(outputId = "whisky_table"),
          width = 12, height = 330
        ))
      ),
    tabItem(tabName = "information")
  )
)
  

##--------- Wrap Up --------

ui <- dashboardPage(header, sidebar, body)

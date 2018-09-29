##-------- Server Script ---------

server <- function (input, output){
  
  ### Cocktail name text rendering
  output$selected_cocktail_name <- renderText(
    toString(input$cocktail_name)
  )
  output$selected_cocktail_name2 <- renderText(
    toString(input$cocktail_name)
  )
   
  ### Image Transforming script
  image <- reactive({
    image_read(
      subset(gin.cocktail, Name == as.character(input$cocktail_name))[1,3] %>% 
        as.character()
    )
  })
  
  output$img <- renderImage({
    tmpfile <- image() %>%
      image_write(tempfile(fileext='jpg'), format = 'jpg')
    list(src = tmpfile, contentType = "image/jpeg", 
         width = "100%", height = "100%")
  })
  
  ### Table output rendering
  output$recipe_table <- renderTable(
    subset(gin.cocktail, Name == as.character(input$cocktail_name))[10:12] %>% 
      arrange(Ingredient) %>%
      na.omit()
  )
  
  ## -------------- Cocktail recommendation ---------
  
  output$ranking_table <- renderTable(
    cocktail.reco %>% 
      arrange(desc(rating), desc(rating.count)) %>% 
      head(5)
  )
  
  ###------------- Whisky Recommendation ----------------------
  
  selected_whisky <- reactive({
    req(input$FirstPref)
    req(input$SecondPref)
    req(input$ThirdPref)
    whisky %>% 
      group_by(Distillery) %>% 
      arrange(desc(UQ(sym(input$FirstPref))),
              desc(UQ(sym(input$SecondPref))),
              desc(UQ(sym(input$ThirdPref)))) %>% 
      head(5)
  })
  
  selected_whisky_score <- reactive({
    selected_whisky() %>% 
      gather(key = Review.point, value = Score, Body:Floral)
  })
  
  output$score_viz <- renderPlot(
    
    selected_whisky_score() %>% 
      ggplot(aes(x=Review.point, y = Score, fill = Review.point)) + 
      geom_bar(stat = "identity") + 
      theme(legend.position = c(.85, .25),
            axis.title.x=element_blank(),
            axis.text.x=element_blank(),
            axis.ticks.x=element_blank(),
            strip.text = element_text(size=12),
            legend.text = element_text(size = 15)) +
      guides(fill = guide_legend(nrow = 6)) +
      facet_wrap(~ Distillery)
    
  )
  
  ## Ranking table
  
  output$whisky_table <- DT::renderDataTable(
      selected_whisky()
  )
  
}
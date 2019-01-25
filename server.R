function(input, output){
  filtered_data_1 <- reactive({
    filter(
      df_filt,
      Series == input$series_ui)})
  filtered_data_2 <- reactive({
    as.data.frame(table(filter(
      df_filt,
      Publisher == input$publisher_ui)$Genre))})
  filtered_data_3 <- reactive({
    filter(
      df_filt,
      Year >= min(input$range) & Year <= max(input$range))})
  filtered_data_4 <- reactive({top_sales(input$sys)})
  filtered_data_5 <- reactive({
    df_out <- df_filt %>% 
      filter(Genre == input$gen) %>% 
      group_by(Platform) %>% 
      summarise(n=n())
    df_out
  })
  filtered_text <- reactive(input$sys)
  output$scatter <- renderPlotly({
    ggplotly(
      ggplot(
        filtered_data_1(),
        aes_string(
          x = "Platform",
          y = input$region_ui)) +
        geom_point(aes(colour = Genre, text=Name)) +
        theme_classic() +
        theme(axis.text.x = element_text(angle = 60, hjust = 1)))}
  )
  output$bar <- renderPlot({
    ggplot(
      data = filtered_data_2(),
      aes(
        x = Var1,
        y = Freq,
        fill = Var1)) +
      geom_col() +
      labs(
        title = names(input$publisher_ui),
        x = "Genre",
        y = "Frequency") +
      scale_fill_hue(h = c(0,360)) +
      theme_classic() +
      theme(axis.text.x = element_text(angle = 60, hjust = 1))}
  )
  output$gen_bar <- renderPlot({
    ggplot(
      data = filtered_data_5(),
      aes(
        x = Platform, 
        y = n, 
        fill = Platform
      )
    ) + 
      geom_col() + 
      labs(x = "System", y = "Games") +
      scale_fill_hue(h = c(0,360)) +
      theme_classic() +
      theme(axis.text.x = element_text(angle = 60, hjust = 1))
  })
  output$table <- renderTable(
    {
      tb <- filtered_data_3() %>%
        group_by(Platform) %>%
        summarise(NA_Sales = n()) %>%
        arrange(desc(NA_Sales))
      tb
    },
    striped = TRUE, 
    hover = TRUE
  )
  output$table_bar <- renderPlot(
    {
      ggplot(
        data = filtered_data_3(),
        aes(
          x = Platform,
          y = NA_Sales,
          fill = Platform)
      ) +
        geom_col() +
        labs(x = "System", y = "Sales") +
        scale_fill_hue(h = c(0,360)) +
        theme_classic() +
        theme(axis.text.x = element_text(angle = 60, hjust = 1))
    }
  )
  output$img <- renderImage({
    filename <- normalizePath(file.path('./www',
                                        str_c(filtered_text(),'.jpg')))
    
    # Return a list containining the filename
    list(src = filename)
  },deleteFile = FALSE )
  output$txt <- renderText(
    includeMarkdown(
      str_c('Systems/',filtered_text(),'.md')))
  output$tbl <- renderTable(
    {filtered_data_4()},
    striped = TRUE,
    hover = TRUE
  )
}
navbarPage(
  title = "Video Games",
  tabPanel(title = "Readme",
           includeMarkdown("readme.md")
  ),
  tabPanel(title = "Scatterplot",
           sidebarLayout(
             sidebarPanel(
               radioButtons(
                 inputId = "region_ui",
                 label = "Select Region",
                 choices = names(region_sales),
                 selected = names(region_sales[1]),
                 inline = TRUE),
               selectInput(
                 inputId = "series_ui",
                 label = "Select Series",
                 choices = unique(df_filt$Series),
                 selected = unique(df_filt$Series)[2])
             ),
             mainPanel(
               h2(str_c("Scatterplot of Global Sales by Platform",
                        " for a given series")),
               plotlyOutput(outputId = "scatter")
             )
           )
  ),
  tabPanel(title = "Publisher Sales Chart",
           sidebarLayout(
             sidebarPanel(
               selectInput(
                 inputId = "publisher_ui",
                 label = "Select Publisher",
                 choices = unique(df_filt$Publisher),
                 selected = unique(df_filt$Publisher)[1])
             ),
             mainPanel(
               h2("Barchart of frequency of genre for a given publisher"),
               plotOutput(outputId = "bar")
             )
           )
  ),
  tabPanel(title = "Console Sales Table",
           sidebarLayout(
             sidebarPanel(
               sliderInput(
                 inputId = "range",
                 label = "Year range",
                 min = min(df_filt$Year),
                 max = max(df_filt$Year),
                 value = c(1995, 2005),
                 sep = ""
               )
             ),
             mainPanel(
               h2("Console game sales throughout the years"),
               splitLayout(
                 tableOutput(outputId = "table"),
                 plotOutput(outputId = "table_bar"))))
  ),
  tabPanel(title = 'Sales by Genre',
           sidebarLayout(
             sidebarPanel(
               selectInput(
                 inputId = 'gen',
                 label = "Select Genre",
                 choices = unique(df_filt$Genre),
                 selected = unique(df_filt$Genre)[1]
               )
             ),
             mainPanel(
               h2("Plot of genre sales by platform"),
               plotOutput(
                 outputId = 'gen_bar'
               )
             )
           )
  ),
  tabPanel(title = "Facts",
           sidebarLayout(
             sidebarPanel(
               selectInput(
                 inputId = "sys",
                 label = "Select System",
                 choices = unique(df_filt$Platform))
             ),
             mainPanel(
               tabsetPanel(
                 tabPanel(title = "Facts & Info",
                          imageOutput(outputId = "img"),
                          htmlOutput(outputId = "txt")
                 ),
                 tabPanel(title = "Table",
                          tableOutput(outputId = "tbl")
                 )
               )
             )
           )
  )
)
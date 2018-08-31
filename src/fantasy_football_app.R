source('~/dev/fantasy_football/src/build_env.R')
source('~/dev/fantasy_football/src/functions.R')

# build shiny visual

ui <- fluidPage(
  
  # App title ----
  titlePanel("Fantasy Football 2018"),
  
  # Sidebar layout with input and output definitions ----
  fluidRow(
    
    # Sidebar panel for inputs ----
    column(width = 3,
      helpText('Select the position breakdown'),
      
      selectInput(label = 'Choose a position:',
                  inputId = 'playerPosition',
                  choices = list(#'All',
                                 'Quarterback',
                                 'Running Back',
                                 'Wide Reciever',
                                 'Tight End',
                                 'Kicker',
                                 'Defense'),
                  selected = 'Quarterback'),
      
      selectInput(inputId = 'startTier',
                  label = "Choose highest tier of interest",
                  choices = 1:12,
                  selected = 1),
      
      selectInput(inputId = 'endTier',
                  label = "Choose worst tier of interest",
                  choices = 1:12,
                  selected = 3),
      
      radioButtons(inputId = 'spreadType',
                   label = 'Spread',
                   choices = list('StdDev', 
                                  'Range'))
    

      # selectInput(inputId = 'spreadType',
      #             label = "Choose type of spread",
      #             choices = list('StdDev', 'Range'),
      #             selected = 'StdDev')
      
    ),
      
      
      
    # Main panel for displaying outputs ----
    column(width = 9,
           plotOutput('cluster_plot')
    )
    
  ),
  
  fluidRow(
    
    # Sidebar panel for inputs ----
    column(width = 3,
           helpText('Select players already picked'),
           
           checkboxGroupInput(inputId = 'pickedList',
                              label = 'Players already picked',
                              choices = unique(ov$Name)
                              )
           ),
    
    column(width = 3,
           helpText('Select my players'),
           
           checkboxGroupInput(inputId = 'myPlayers',
                              label = 'My team:',
                              choices = unique(ov$Name))
  ), 
  
  column(width = 6,
         tableOutput('top_player_summary')
  ), 
  
  column(width = 2,
         tableOutput('my_draft_score'))
)
)




# Define server logic required to draw a histogram ----
server <- function(input, output) {
  output$cluster_plot <- renderPlot({
    viz_function(playerPosition = input$playerPosition,
                 startTier = input$startTier,
                 endTier = input$endTier,
                 pickedList = input$pickedList,
                 spreadType = input$spreadType)
  })
  output$top_player_summary <- renderTable({
    top_k_summary(reduce_to_available(ov, input$pickedList), 'StdDev', 3)
  })
  output$my_draft_score <- renderTable({
    calc_my_grade(input$myPlayers)
  })
}

shinyApp(ui, server)

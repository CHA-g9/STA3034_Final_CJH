library(shiny)
library(ggcorrplot)

df <- read.csv("./data/corr_data.csv")

# Define UI for app that draws a histogram ----
ui <- fluidPage(
  titlePanel(
    h1("Final Shiny_2018311063_Cha Ji Hwan"), br()),
  sidebarLayout(
    sidebarPanel(
      helpText("Note : Choose the name of plots."),
      selectInput("num",
                  label = "Choose a plots to display",
                  choices = list("plot 1", "plot 2", "plot 3", "plot 4", "plot 5", "plot 6", "plot 7"),
                  selected = "plot1"),
      sliderInput("count",
                  label = "Choose the number of variables",
                  min = 2, max = 9,
                  value = 9)
      
    ),
    mainPanel(
      h3(textOutput("selected_var"), align = 'center'),
      p(),
      p(imageOutput("show_plot"), align = "center"),
      plotOutput("show_corr")
      
    )
  )
  
)
  


# Define server logic required to draw a histogram ----
server <- function(input, output) {
  output$selected_var <- renderText({paste("You have selected", input$num)})
  output$show_plot <- renderImage({

    # When input$n is 3, filename is ./images/image3.jpeg
    filename <- normalizePath(file.path('./www',
                                        paste(input$num, '.png', sep='')))
    
    # Return a list containing the filename and alt text
    list(src = filename,
         alt = paste("Image number", input$num),
         height = 400,
         width = 1000
         )
    
  }, deleteFile = FALSE)
  output$show_corr <- renderPlot({
    corr <- round(cor(df[,2:(input$count+1)]),1)
    ggcorrplot(corr)
  })

 
}

shinyApp(ui = ui, server = server)

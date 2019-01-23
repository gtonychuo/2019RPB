library(shiny)
library(shinydashboard)
ui <- fluidPage(
  dashboardPage(
    dashboardHeader(title = "text"),
    dashboardSidebar(
      sidebarMenu(id = 'MenuTabs',
                  menuItem("Tab1", tabName = "tab1", selected = TRUE),
                  # menuItem("Tab1", tabName = "tab2")
                  uiOutput('ui')
      )
    ),
    dashboardBody(
      tabItems(
        tabItem("tab1",
                actionButton("newplot", "New plot"),
                actionButton("show", "Show")),
        tabItem("tab2",
                plotOutput('Plot'))
      )
    )
  )
)


server <- function(input, output, session){
  
  output$Plot <- renderPlot({
    input$newplot
    # Add a little noise to the cars data
    cars2 <- cars + rnorm(nrow(cars))
    plot(cars2)
  })
  
  
  output$ui <- renderUI({
    if(input$show == 0) return()
    print(input$show)
    sidebarMenu(id = 'MenuTabs',
                menuItem("Tab1", tabName = "tab2")
    )
  })
}


shinyApp(ui, server)
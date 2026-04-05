library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)


big_data <- read.csv("data.csv", stringsAsFactors = TRUE)

# --- STEP 2: THE UI ---
ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "Pulse-Point AI"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("National Overview", tabName = "overview", icon = icon("globe")),
      menuItem("Risk Analysis", tabName = "risk", icon = icon("heartbeat")),
      # This slider now filters based on the real Age column in your CSV
      sliderInput("age_filter", "Filter by Age:", 
                  min(big_data$Age), max(big_data$Age), 
                  value = c(min(big_data$Age), max(big_data$Age)))
    )
  ),
  dashboardBody(
    tabItems(
      tabItem(tabName = "overview",
              fluidRow(
                valueBox(nrow(big_data), "Records Loaded", icon = icon("database"), color = "aqua"),
                valueBox(round(mean(big_data$Risk_Score),1), "Avg Risk Score", icon = icon("heart"), color = "red"),
                valueBox("Local CSV", "Data Source", icon = icon("file-csv"), color = "green")
              ),
              fluidRow(
                box(title = "Risk vs. Age (Data from CSV)", width = 12, plotlyOutput("trendPlot"))
              )
      )
    )
  )
)

# --- STEP 3: THE SERVER ---
server <- function(input, output) {
  output$trendPlot <- renderPlotly({
    # Filter the data loaded from your local file
    filtered <- big_data %>%
      filter(Age >= input$age_filter[1] & Age <= input$age_filter[2])
    
    # Create the plot using columns from your CSV (Age and Risk_Score)
    p <- ggplot(filtered, aes(x = Age, y = Risk_Score, color = Department)) +
      geom_point(alpha = 0.5) +
      geom_smooth(method = "lm", color = "black") + 
      theme_minimal()
    
    ggplotly(p)
  })
}

shinyApp(ui, server)

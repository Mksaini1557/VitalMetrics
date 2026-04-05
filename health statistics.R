library(shiny)
library(shinydashboard)
library(tidyverse)
library(plotly)

# --- STEP 1: DATA INGESTION ---
# Ensure your data.csv is in the same folder
big_data <- read.csv("data.csv", stringsAsFactors = TRUE)

# --- STEP 2: THE UI ---
ui <- dashboardPage(
  skin = "purple",
  dashboardHeader(title = "VitalMetrics"),
  
  dashboardSidebar(
    sidebarMenu(
      # Rebranded from National Overview to Global Insights
      menuItem("Global Insights", tabName = "overview", icon = icon("globe")),
      menuItem("Risk Analysis", tabName = "heartbeat", icon = icon("heartbeat")),
      
      # Dynamic Age Filter
      sliderInput("age_filter", "Filter by Age Range:", 
                  min = min(big_data$Age), 
                  max = max(big_data$Age), 
                  value = c(min(big_data$Age), max(big_data$Age)))
    )
  ),
  
  dashboardBody(
    tabItems(
      # Tab 1: Global Insights
      tabItem(tabName = "overview",
              fluidRow(
                valueBox(nrow(big_data), "Total Records", icon = icon("database"), color = "aqua"),
                valueBox(round(mean(big_data$Risk_Score), 1), "Avg Risk Score", icon = icon("heart"), color = "red"),
                valueBox("Active", "System Status", icon = icon("check-circle"), color = "green")
              ),
              fluidRow(
                box(title = "Global Risk Trends by Age", width = 12, status = "primary",
                    plotlyOutput("trendPlot"))
              )
      ),
      
      # Tab 2: Risk Analysis
      tabItem(tabName = "heartbeat",
              fluidRow(
                box(title = "Distribution Analysis", width = 12, status = "danger",
                    plotlyOutput("distPlot"))
              )
      )
    )
  )
)

# --- STEP 3: THE SERVER ---
server <- function(input, output) {
  
  # Reactive Data Filtering
  filtered_data <- reactive({
    big_data %>%
      filter(Age >= input$age_filter[1] & Age <= input$age_filter[2])
  })
  
  # Trend Plot for Global Insights
  output$trendPlot <- renderPlotly({
    p <- ggplot(filtered_data(), aes(x = Age, y = Risk_Score, color = Department)) +
      geom_point(alpha = 0.5) +
      geom_smooth(method = "lm", color = "black", se = FALSE) + 
      theme_minimal() +
      labs(y = "Calculated Risk Score", x = "Patient Age")
    
    # ggplotly conversion with logo removal
    ggplotly(p) %>% config(displaylogo = FALSE)
  })
  
  # Distribution Plot for Risk Analysis
  output$distPlot <- renderPlotly({
    p <- ggplot(filtered_data(), aes(x = Department, y = Risk_Score, fill = Department)) +
      geom_boxplot() +
      theme_minimal() +
      labs(title = "Risk Distribution by Department")
    
    ggplotly(p) %>% config(displaylogo = FALSE)
  })
}

shinyApp(ui, server)

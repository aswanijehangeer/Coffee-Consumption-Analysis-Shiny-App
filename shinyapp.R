#### Installing the required packages

# install.packages("shiny")
# install.packages("tidyverse")
# install.packages("readxl")
# install.packages("janitor")

library(shiny)
library(tidyverse)
library(readxl)
library(janitor)

# Sourcing global.R script
source("global.R")

# Define UI Interface
ui <- fluidPage(
  titlePanel("Coffee Consumption Analysis"),
  sidebarLayout(
    sidebarPanel(
      selectInput("drink_type", "Drink Type", 
                  choices = unique(coffee_data$product)),
      numericInput("drinks_per_day", "Drinks per Day", 
                   value = 2, min = 1, max = 100)
    ),
    mainPanel(
      plotOutput("bar_plot")
    )
  )
)

# Server Logic
server <- function(input, output) {
  
  # Calculating total caffeine per day for each chain based on drink size
  total_caffeine_per_day <- reactive({
    coffee_data %>%
      filter(product == input$drink_type) |> 
      group_by(chain) %>%
      mutate(total_caffeine_per_day = (caffeine_mg * input$drinks_per_day)) %>%
      summarise(total_caffeine_per_day = sum(total_caffeine_per_day))
  })
  
  output$bar_plot <- renderPlot({
    
    data <- total_caffeine_per_day()
    
    # Bar plot
    data |> 
      ggplot(aes(x = reorder(chain, -total_caffeine_per_day), 
                 y = total_caffeine_per_day, 
                 fill = factor(total_caffeine_per_day >= 400))) +
      geom_bar(stat = "identity") +
      scale_fill_manual(values = c("lightblue", "red")) +
      geom_hline(yintercept = 400, linetype = "dashed", color = "black") +
      geom_text(aes(label = paste(total_caffeine_per_day, "mg per day"), 
                    y = 0),
                vjust = 1.05, hjust = -0.2, 
                color = "black", size = 3.5, fontface = "bold") +
      labs(title = "Are you drinking a safe amount of Caffeine?",
           subtitle = "The US FDA advises a daily caffeine limit of 400 mg, roughly 4 cups of coffee.",
           caption = "Data Source: Which? created by: aswanijehangeer",
           x = NULL, y = NULL) + # Removed x and y-axis labels
      theme(plot.caption = element_text(face = "bold", hjust = 0.5, size = 12),
            legend.position = "none") +
      coord_flip() 
    
  })
}

# ShinyApp
shinyApp(ui, server)

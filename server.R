#
# This is the user-interface definition for the Movies Budget and Ratings Investigation Tool app
#

library(shiny)
library(ggplot2)
require(markdown)

# Load the movie data and strip out unneeded columns
data_path <- "data/movies.tab"
movies <- read.table(data_path, sep="\t", header=TRUE, quote="", comment="")
movies <- movies[, -(7:17)]
genres <- movies[, 7:13]
get_genre <- function(x){which(x == "1", arr.ind = TRUE)[1]}

# Create column with Genre names
genre_codes <- data.frame(apply(genres, 1, get_genre))
colnames(genre_codes) <- c("genre_code")
genre_codes[is.na(genre_codes)] <- "None"
genre_codes$genre_code[genre_codes$genre_code == 1] <- "Action"
genre_codes$genre_code[genre_codes$genre_code == 2] <- "Animation"
genre_codes$genre_code[genre_codes$genre_code == 3] <- "Comedy"
genre_codes$genre_code[genre_codes$genre_code == 4] <- "Drama"
genre_codes$genre_code[genre_codes$genre_code == 5] <- "Documentary"
genre_codes$genre_code[genre_codes$genre_code == 6] <- "Romance"
genre_codes$genre_code[genre_codes$genre_code == 7] <- "Short"
movies$Genre <- genre_codes$genre_code
movies <- movies[, -(7:13)]

# Get the genres
genres <- sort(unique(movies$Genre))


shinyServer(
      
      function(input, output) {  
            
            values <- reactiveValues()
            values$genres <- genres
            
            data.reactive = reactive({
                  a = subset(movies, Genre %in% input$genres)
                  a = subset(a, year > input$year[1])
                  a = subset(a, year < input$year[2])
                  return(a)
            })
      
            # Add observer on select-all button
            observe({
                  if(input$selectAll == 0) return()
                  values$genres <- genres
            })
            
            # Add observer on clear-all button
            observe({
                  if(input$clearAll == 0) return()
                  values$genres <- c() 
            })
            
            output$genres <- renderUI({
                  checkboxGroupInput('genres', 'Genre:', genres, selected = values$genres)
            })
      
      
            output$movies_data <- renderDataTable({data.reactive()}, options = list(pageLength = 10))
      
            output$ratingByBudget <- renderPlot({
                  plot <- qplot(budget, rating, data = data.reactive()) 
                  plot <- plot + geom_point(aes(color = Genre))
                  plot <- plot + labs(title = "Average Rating By Budget") + labs(x = "Budget", y = "Average Rating")
                  plot
            })
            
            output$budgetByYear <- renderPlot({
                  plot <- ggplot(data.reactive(), aes(x = year, y = budget))
                  plot <- plot + geom_point(aes(color = Genre))
                  plot <- plot + labs(title = "Budget By Year") + labs(x = "Year", y = "Budget")                  
                  plot
            })

      }
)

library(shiny)
library(ggplot2)
library(plotly)

shinyServer(function(input, output) {
        output$plot1 <- renderPlotly({
                # List of Inputs
                stocks <- c(ifelse(input$get_CAC, "CAC", ""),
                            ifelse(input$get_DAX, "DAX", ""),
                            ifelse(input$get_FTSE, "FTSE", ""),
                            ifelse(input$get_SMI, "SMI", ""))
                minYear <- input$in_period[1]
                maxYear <- input$in_period[2]

                # Filter Stocks Based on Given Inputs
                data(EuStockMarkets)
                data <- as.data.frame(EuStockMarkets) %>% gather(index, price) %>%
                        mutate(time = rep(time(EuStockMarkets), 4))
                data <- data[data$index %in% stocks, ]
                if(minYear == maxYear)
                        data <- data[ceiling(data$time) == minYear, ]
                else {
                        data <- data[data$time > minYear, ]
                        data <- data[data$time < maxYear + 1, ]
                }

                # Output
                final <- ggplot(data = data, aes(x = time, y = price)) +
                        geom_line(size = .5) +
                        geom_smooth(aes(colour = index), method = "lm", size = .5,
                                    linetype = 2, se = FALSE, show.legend = FALSE) +
                        facet_wrap(~index, ncol = 1)
                finalPlotly <- ggplotly(final)
                finalPlotly
        })
})

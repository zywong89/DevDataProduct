library(shiny)

shinyUI(fluidPage(
        titlePanel("Trend Analysis of EU Stock Markets"),
        sidebarLayout(
                sidebarPanel(
                        h4("Stock Charts"),
                        checkboxInput("get_CAC", "CAC", value = TRUE),
                        checkboxInput("get_DAX", "DAX", value = TRUE),
                        checkboxInput("get_FTSE", "FTSE", value = TRUE),
                        checkboxInput("get_SMI", "SMI", value = TRUE),
                        sliderInput("in_period", "Pick Minimum and Maximum Year",
                                    1991, 1998, value = c(1991, 1998))
                ),
                mainPanel(
                        h6("This application performs a simple trend analysis on European stock markets (CAC, DAX, FTSE and SMI) over a given period by the user. The values of each data points are available at the interactive graphs. By default, this application plots the markets seperately and fits an overall linear trend for each market. Instead of all periods, user can choose to view the trends over two years (e.g. 1993-1995) via adjusting the slider. Also, user can choose to compare certain markets of interest by ticking the checkboxes accordingly. The objective of this app is to give useful trend insights across different markets over different periods."),
                        plotlyOutput("plot1")
                )
        )
))

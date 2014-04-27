library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Databáze přijemců dotací"),
  p("Zevrubná datová analýza databáze přijemců dotací:"),
  fluidRow(
          column(2,textInput("project",
                               "Jméno projektu obsahuje:")
                  ),
           column(2,textInput("zadatel",
                              "Jméno žadatele obsahuje:")
           ),
           column(2,textInput("ico",
                              "IČO obsahuje:")
           ),
           column(2,textInput("organ",
                              "Jméno řídícího orgánu obsahuje:")
           ),
           column(2,textInput("rok",
                              "rok")
           ),
           column(2,textInput("stav",
                              "rok")
           )
    ),
  fluidRow(column(2,sliderInput("alok_min", label = "Minimální alokovaná částka u projektu",
                                min = 0, max = 100000000, value = 0))
    ),
  fluidRow(column(6,
      tableOutput("data")),
      column(6,
      tableOutput("entity"))
    ),
  p("Tabulka kofinancování v jednotlivých operačních programech"),
  fluidRow(column(12,
                  tableOutput("kofinancovani"))
  ),
  p("Náhled nalezených dat"),
  fluidRow(column(12,
                  tableOutput("data_peek"))
  ),
  p("Source: ministry of regional development, data were kindly provided by Frank Bold society")
  )
)
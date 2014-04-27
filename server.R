library(shiny)
library(data.table)
library(stringr)
library(reshape)

a <- data.table(read.csv("data/fondy_adicionalita.csv", quote="\'"))
a[,estimated_start:=as.IDate(strptime(as.character(start), "%Y-%m-%d"))]
a[,estimated_end:=as.IDate(strptime(as.character(end), "%Y-%m-%d"))]
a[,zadatel_ico:=as.integer(as.character(zadatel_ico))]

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  data <- reactive({
    a[alokovano>(input$alok_min*1000)][try(str_detect(as.character(zadatel_ico), input$ico))][try(str_detect(as.character(zadatel_nazev), input$zadatel))][try(str_detect(as.character(ridici_organ), input$organ))][try(str_detect(as.character(project_name), input$project))]
    })
  
  output$data_peek <- renderTable({
    data()[1:10]
  })
  
  output$data <- renderTable({
    data()[zdroj_financovani=="EU - Příspěvek Společenství", list(paid=sum(proplaceno)), by=op_id]
  })
  output$entity <- renderTable({
    data()[zdroj_financovani=="EU - Příspěvek Společenství", list(paid=sum(proplaceno)), keyby=zadatel_nazev][1:10]
  })
  
  output$kofinancovani <- renderTable({
    cast(data()[,list(paid=sum(proplaceno)), keyby=list(op_id, zdroj_financovani)][data()[,list(paid_celkem=sum(proplaceno)), keyby=list(op_id)]][,list(procento=paid/paid_celkem), keyby=list(op_id, zdroj_financovani)], op_id ~ zdroj_financovani)  
  })
  
  
  
})
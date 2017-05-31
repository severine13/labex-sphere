# December 2016
# S. Martini
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# This application allows to plot the data in an easy/fast way after collecting bioluminescence kinetic spectra from the integrative sphere.

library(shiny)
library(ggplot2)
# Define UI for application that draws a histogram
ui <- fluidPage(
   
   # Application title
   titlePanel("Fast observation of the black-sphere dataset"),
   
   # Sidebar with a slider input for number of bins 
   sidebarLayout(
      sidebarPanel(
         fileInput("file1",label="Load a file from the dark sphere"),
         sliderInput("span",label="Span",min=0,max=0.2,value=0.1),
        # selectInput("variable1",label="Variable 1 to plot",choices=c("Raw_Amp"="Raw_Amp","Log_Amp"="Log_Amp","Prog_Amp"="Prog_Amp","HighV"="HighV")),
        # selectInput("variable2",label="Variable 2 to plot",choices=c("Raw_Amp"=Raw_Amp,"Log_Amp"=Log_Amp,"Prog_Amp"=Prog_Amp,"HighV"=HighV)),
         numericInput("start","start",value=0),
         numericInput("end","end",value=17)
          ),
      
      # Show a plot of the generated distribution
      mainPanel(
       #  plotOutput("plot1"),
        # plotOutput("plot2"),
         plotOutput("plot3"),
         tableOutput("contents")
      ))
)



# Define server logic required to draw a histogram
server <- function(input, output){
  # observe({
  #   
  # file1=input$file1
  # data1 = read.csv(file1$datapath)
  # })
  # 
  # output$plot <- renderPlot({
  #   plot(data1[,1],data1[,2])
  # })
  
  output$contents <- renderTable({
    
    # input$file1 will be NULL initially. After the user selects
    # and uploads a file, it will be a data frame with 'name',
    # 'size', 'type', and 'datapath' columns. The 'datapath'
    # column will contain the local filenames where the data can
    # be found.
    
    inFile <- input$file1
    
    if (is.null(inFile))
      return(NULL)
    
    read.csv(inFile$datapath)
  })
  # 
  # output$plot1 <- renderPlot({
  #   file1=input$file1
  #   data1 = read.table(file1$datapath,skip=2)
  #   names(data1)=c("Time_s","Raw_Amp","Log_Amp","Prog_Amp","HighV")
  #   ggplot(data1,aes(x=Time_s,y=Raw_Amp))+geom_line()+geom_smooth(span=0.01)
  #   
  # })
  # output$plot2 <- renderPlot({
  #   file1=input$file1
  #   data1 = read.table(file1$datapath,skip=2)
  #   names(data1)=c("Time_s","Raw_Amp","Log_Amp","Prog_Amp","HighV")
  #   ggplot(data1,aes(x=Time_s,y=Log_Amp))+geom_line()+geom_smooth(span=0.01)
  # })
  output$plot3 <- renderPlot({
    file1=input$file1
    data1 = read.table(file1$datapath,skip=2)
    names(data1)=c("Time_s","Raw_Amp","Log_Amp","Prog_Amp","HighV")
    ggplot(data1,aes(x=Time_s,y=Prog_Amp))+geom_line()+geom_smooth(span=input$span)+geom_line(aes(y=Log_Amp),linetype = "dashed",colour="red")+xlab("Time (s)")+xlim(input$start,input$end)
    
  })
}

# Run the application 
shinyApp(ui = ui, server = server)

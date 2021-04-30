# Produce basic shell for the site

#---------------------------------------

# Load packages (only matters for publishing on shiny.io)
library(tidyverse)
library(shinyjs)
library(DT)

#-------------------------------

# Basic Layout

ui <- navbarPage("Montgomery County Public Safety",
                 
                 
                 
                 
                 #--------------------------------------
                 
                 # Third Level Content
                 # Tab setup for tracker "pages"
                 tabsetPanel(type="tabs",
                             tabPanel(h4(style="color:black;","MontoCo-Progress Tracker"), 
                                      "test test", 
                                      dataTableOutput("tbPriorities"), 
                                      downloadButton(style="border:none;padding-left:0px;margin-top:24px;","downloadActions", HTML("<p>Download this data (csv)</p>"))),
                             tabPanel(h4(style="color:black;","RPS Reports Updated"),
                                      HTML("dfsdfsdfsd")
                             ),
                             tabPanel(h4(style="color:black;","Message from the RPS team"), "efdfsdfsd" ),
                             tabPanel(h4(style="color:black;","Resources & Feedback"), 
                                      "dfsdfsdf",
                                      HTML('<iframe src="https://docs.google.com/forms/d/e/1FAIpQLScjKePIaoUjUeI1-2Q9vvINtFdFl9ZGivr19BP6M9Hd6kdyhg/viewform?embedded=true" width="100%" height="360px" frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>')
                             )
                 ),
                 
                 #--------------------------------------
                 
                 h4(),
                 hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 1px solid", "#fdb927", ";")),
                 div(style="display: flex; flex-direction:row;justify-content: space-between;",
                     tags$i(h4("Designed by the CMU Policy Lab Team-Gisselt Gomez,Laknath Gunathilake,Mary Kubinski, Brian Martin")),
                     h4(style="font-size:20px;",
                        #Be sure to replace these with your organization's links.
                        a(style="padding-left:1px;", href='https://twitter.com/MayorBMScott', icon("twitter")), "  ",
                        a(style="padding-left:1px;", href='https://www.facebook.com/MayorBMScott',icon("facebook-square")), "  ",
                        a(style="padding-left:1px;", href='https://www.youtube.com/channel/UCasQyO1K4yMq3Hi_0RQ0jfA',icon("youtube-square")), "  ",
                        a(style="padding-left:1px;", href='https://mayor.baltimorecity.gov/connect',icon("envelope-square")), "  ",
                        a(style="padding-left:1px;", href='https://mayor.baltimorecity.gov/subscribe/MDBALT_25',icon("rss-square")))),
                 h2())
    
server <- function(input, output)  {}




# Run the application 
shinyApp(ui = ui, server = server)



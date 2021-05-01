# Produce basic shell for the site

#---------------------------------------

# Load packages (only matters for publishing on shiny.io)
library(tidyverse)
library(shinyjs)
library(DT)
library(ggplot2)

#-------------------------------

# Basic Layout

ui <- navbarPage("Montgomery County Public Safety",
                 
                 # Style
                 tags$link(rel = "stylesheet", type = "text/css", href = "css/roboto.css"),
                 tags$style(paste0("
                                   * {
                                   font-family: 'Roboto', sans-serif; padding: 0px; margin: 0px;
                                   }
                                   .col-sm-12 {
                                   padding: 0px;
                                   }
                                   .tracker-container {
                                   max-width: 800px;
                                   margin: auto;
                                   padding-left: 24px;
                                   padding-right:24px;
                                   }
                                   h1 {
                                   font-size: 42px;
                                   }
                                   p {
                                   font-size: 18px; 
                                   line-height:1.3em;
                                   color:black;
                                   }
                                   .tab-header {margin-top:1em; margin-bottom: 1em;}
                                   table.dataTable tr.selected td, table.dataTable td.selected, table.dataTable tr.selected {background-color: white !important;}
                                   table thead.selected td {background-color: white !important;}
                                   table.dataTable.hover tbody tr:hover, table.dataTable.display tbody tr:hover {background-color: white !important;}
                                   .tabbable {
                                   margin-top: 24px;
                                   }
                                   .tabbable h4 {
                                   font-size: 18px;
                                   font-weight: 600;
                                   }
                                   ul.nav-tabs {
                                   border-bottom: 1px solid ","#fdb927",";
                                   }
                                   .nav-tabs li a {
                                   padding: 0px 12px 0px 12px;
                                   }
                                   .nav-tabs li.active a, .nav-tabs li.active a:focus, .nav-tabs li.active a:hover {
                                   border: 1px solid ","#fdb927",";
                                   border-bottom: 1px solid white;
                                   }
                                   table.dataTable thead th {
                                   padding: 8px 10px !important;
                                   }
                                   #DataTables_Table_0_filter {
                                   float: right;
                                   }
                                   #DataTables_Table_0_filter input {
                                   border: 1px solid #ccc;
                                   border-radius: 4px;
                                   }
                                   .fab, .fa {
                                   color: black;
                                   }
                                   .priorities-hierarchy-2 div {
                                   margin-right: 6px;
                                   }
                                   
                                   .goog-te-gadget {
                                   font-family: Roboto!important;
                                   }
                                   .goog-te-gadget-simple  {
                                   border: 0px solid white !important;
                                   padding: 0px!important;
                                   border-radius: 0px!important;
                                   cursor: pointer;
                                   }
                                   .goog-te-menu-value span:nth-child(5) {
                                   // display:none;
                                   color: ","#fdb927","!important;
                                   font-size: 12px!important;
                                   }
                                   .goog-te-menu {
                                   border: 1px solid ","#fdb927",";
                                   }
                                   .goog-te-menu-value span:nth-child(3) {
                                   display:none;
                                   }
                                   .goog-te-menu-value span {
                                   // float: right;
                                   text-align:right;
                                   font-size: 15px!important;
                                   font-weight: 500!important;
                                   }
                                   .goog-te-menu-value {
                                   margin: 0px;
                                   }
                                   .goog-te-gadget-icon {
                                   display:none;
                                   }
                                   .legend {
                                   margin-left: 1px;
                                   display:flex;
                                   flex-direction:row;
                                   flex-wrap:nowrap;
                                   justify-content:flex-start;
                                   align-items:baseline;
                                   align-content:flex-start;
                                   }
                                   .legend p {
                                   font-size: 14px!important;
                                   font-weight: 400;
                                   color: dimGrey!important;
                                   margin-right: 0.75em;
                                   }
                                   .legend div { 
                                   margin-right: 0.35em;
                                   width: 11px;
                                   height: 11px;
                                   }
                                   "
                 )),
                 
                 #-------------------------------
                 
                 
                 
                 # Second level content
                 # Welcome comment from Mayor
                 div(style='margin-bottom:12px;margin-top:18px;',
                     img(src = "photos/countyseal.png",
                         style="margin-left: 2px; margin-top: 4px; margin-right:24px;margin-bottom:8px;float:left;" ,
                         height = 130),
                     "Introduction about the RPS"),
                 
                 
                 
                 # Overview progress and day trackers 
                 div(style='padding:1px;max-width:900px;margin-top:24px;' ,
                     div(p(style="max-width:900px;font-weight:600;", textOutput("timelineText", container=span), " ")),
                     div(style='margin-left:-4px;margin-right:-4px;margin-bottom:50px;', class="small-tracker", 
                         plotOutput("plotTimeline", width="100%", height="48px")),
                     htmlOutput("timelineLegend"),
                     div(p(style="max-width:900px;font-weight:600;",
                           "", " ")),
                     div(style='margin-left:-4px;margin-right:-4px;margin-bottom:0px', class="small-tracker", 
                         plotOutput("plotProgress", width="100%", height="48px")),
                     htmlOutput("progressLegend")
                 ),
                 
                 
                 #--------------------------------------
                 
                 # Third Level Content
                 # Tab setup for tracker "pages"
                 tabsetPanel(type="tabs",
                             tabPanel(h4(style="color:black;","MontoCo-Progress Tracker"), 
                                      "Basic Overview of the Tracker", 
                                      dataTableOutput("tbPriorities")),
                             
                             
                             
                             
                             tabPanel(h4(style="color:black;","RPS Reports Updated"),
                                    HTML("This would be a place where will upload the PDF files of Rmarkdown Reports that can be downloaded")
                             ),
                             
                             
                             tabPanel(h4(style="color:black;","Message from the RPS team"), "This is an optional Tab to include anything else, or we could remove this" ),
                             
                             
                             
                            tabPanel(h4(style="color:black;","Resources & Feedback"), 
                                      "This is the community feedback tab where we would include the a google survey",
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
    
server <- function(input, output)  {
  #Load the data  
  library(readxl)
  library(dplyr)
  #Tracker Outputs
  #set up sheets
  pg1 <- read_excel("data/dummyprogress.xlsx")
  
  tbPriorities <- pg1 %>%
    mutate(Progress = factor(Progress, levels=c("Complete", "In Progress", "Not Yet Started"))) %>% 
    arrange(`Focus Group`, Progress)
  
    
    #This table then nests all actions into a table of the committees to make it possible later
    #to have an expand/contract table button for each committee
    tbActionsNested <- tbPriorities %>% 
      mutate(ActionProgressParties = mapply(c, Action, 
                                            Progress,
                                            `Parties Responsible`, 
                                            SIMPLIFY = F)) %>% 
      select(c("Focus Group", "ActionProgressParties")) %>% 
      group_by(`Focus Group`) %>%
      summarise(ActionProgressParties = list(unique(ActionProgressParties))) 
    
  #Load the progress tracker output
  output$plotProgress <- renderPlot({
    tbPriorities %>%
      ggplot(aes(fill = Progress, x = Count, y = "")) +
      geom_bar(position = position_fill(reverse = TRUE),
               stat = "identity",
               width = 1) +
      coord_flip() +
      theme(
        legend.position = "none",
        # legend.justification = "right",
        plot.title = element_text(size=18, face="bold", margin=margin(c(0,0,8,0))),
        panel.spacing = margin(c(0,0,0,0)),
        panel.border = element_rect(colour = "black", fill=NA, size=0.5),
        axis.title.x = element_blank(),
        axis.title.y = element_blank(),
        axis.ticks.x=element_blank(),
        axis.ticks.y=element_blank(),
        axis.text.x = element_blank(),
        panel.background = element_blank()
      ) +
      scale_x_discrete(expand = c(0, 0)) +
      scale_y_discrete(expand = c(0, 0)) 
  }, height = "auto")
  
  # Text for timeline vis description
  output$timelineText <- renderText({
    
    # Refresh every minute
    #invalidateLater(60000, session)
    
    # Return text explaining when the 100 Days of Action began, and if
    # they are still happening, the current date and number. If they are
    # no longer happening, return the date they ended.
    ifelse(which(Sys.Date() == Sys.Date())<=100,
           paste0("The RPS recomendations were implemented on Insert Date, And Todays Date is ",Sys.Date()
           )
    )
  })  
  
  
  
  
  
  
}




# Run the application 
shinyApp(ui = ui, server = server)



# Produce basic shell for the site

#---------------------------------------

# Load packages (only matters for publishing on shiny.io)
library(tidyverse)
library(shinyjs)
library(DT)
library(ggplot2)
library(readxl)
#-------------------------------
# Loading Data
df <- read_xlsx("data/RPS Tracker Data.xlsx")

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
                         HTML('
                <div id="google_translate_element"></div>
                              <script>
                              function googleTranslateElementInit() {
                              new google.translate.TranslateElement({
                              pageLanguage: \'en\', 
                              includedLanguages: \'en,es,fr,ko,am,vi,zh-CN,ar\', 
                              layout: google.translate.TranslateElement.InlineLayout.SIMPLE, autoDisplay: false}, 
                              \'google_translate_element\');
                              }
                              </script>
                              <script src="//translate.google.com/translate_a/element.js?cb=googleTranslateElementInit"></script>
                              '
                              ),
                         
                         height = 130),
                     "The Reimagining Public Safety Task Force proposed 87 recommendations across 6 issue areas. 
                     The County’s overall progress towards completing the recommendations within each of these issue areas is captured by the 
                     color-coded progress bars below. To see the work Montgomery County is doing to reimagine public safety task by task, click the downward facing arrow icon to the right of the progress bar."),
                 
                
                 
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
                             
                             
                             
                             
                             tabPanel(h4(style="color:black;","RPS Reports and Data"),
                                    HTML("This would be a place where will upload the PDF files of Rmarkdown Reports that can be downloaded"),
                                    dataTableOutput(outputId = "datasummary")
                             ),
                             
                             
                             tabPanel(h4(style="color:black;","Message from the RPS team"), 
                                      "Message from the Co-Chairs of the Montgomery County Task Force on Reimagining Public Safety

                                      We have been honored to serve as the Co-Chairs of the Montgomery County Task Force on Reimagining Public Safety. We and our many colleagues have strived in recent months to produce an analysis and vision for change in our county in how we achieve our public safety goals, and this report represents the product of that process. The community members of this task force have provided these recommendations; county staff participated as helpful resources, but did not take part in the final recommendation presented within our report. 
                                      
                                      The  tragic killing of George Floyd in Minneapolis in 2020 triggered a national outpouring of emotion and advocacy centered on the centuries-long tensions existing between law enforcement agencies and Black communities in particular. Notably, this movement was broadly based, encompassing multi-racial protests at the community level, soul-searching within corporate America, and sustained media focus on the origins and challenges posed by racial injustice. 
                                      
                                      The history of law enforcement in this country is unfortunately a story that all too often has demonstrated a lack of concern, or outright racism, towards communities of color. For many years, a key failing of law enforcement was its under-enforcement of the law in Black communities. Problems of crime and disorder in those communities went largely unaddressed unless they spilled over into white and propertied neighborhoods. Flowing out of the modern- day civil rights movement, pressure was put on police agencies to recognize their obligations to address problems in all communities. But in recent decades that attention has often developed into massive over-policing of Black communities, as exemplified by the racially disparate implementation of stop-and-frisk policies, the war on drugs, and racial profiling. 
                                      
                                      In Montgomery County, tensions have surfaced between law enforcement and County residents even before the death of George Floyd. Black residents including Peter Ayompeuh Njang, Emmanuel Okutuga, Robert White, Mikyas Tegegne, Finnan Berhe, and most recently Kwamena Ocran, have been killed by police in Montgomery County, creating a sense of urgency to transform the way we think of public safety from a “warrior” to a “guardian” mindset. 
                                      
                                      Montgomery County has its own uncomfortable truth regarding the lack of concern towards members of Black communities. Our history includes using local militia to fight off escaped slaves in 1845, the lynching of George Peck in 1880, the lynching of Sidney Randolph in 1896, racial profiling in traffic stops resulting in a 2000 Memorandum of Agreement between the Department of Justice and the Police Department. Further, the County’s Office of Legislative Oversight findings reveal further disproportionate treatment of Black residents from law enforcement. 
                                      
                                      In response to the nationwide and local furor over racial justice, County Executive Marc Elrich established this task force in mid-year 2020. He appointed the two of us to co-chair a 41- member group of community residents designed to develop a strategy for improving public safety outcomes in the County along with a mandate to challenge and eliminate the racial bias that has plagued our criminal justice system, as it has throughout the country. 
                                      
                                      Montgomery County has much to be proud of. As a relatively wealthy county it has invested resources in a range of initiatives to enhance education, to provide opportunity, and to bring social services resources to communities in need. At the same time, the County is also experiencing the broad implications of the dramatically growing social and economic inequality that has been a hallmark of the nation for the past half century. Despite efforts to address these issues, the County experiences a large achievement gap in its school population, a growing housing crisis for lower-income residents, and glaring racial disparities at every level of the criminal justice system. 
                                      
                                      The goal of reimagining public safety is critical for a number of reasons. First, as a matter of justice we need to ensure that all residents who come before the law are treated fairly and equitably. Second, we know that law enforcement agencies can only be effective if they establish a sense of trust and confidence in the communities they serve. When individuals lose faith in these institutions they become less likely to cooperate with policing agencies and to perceive the law as just. A lack of faith may fuel negative behavior that can trigger mental health issues or engagement of criminal activity; in a worst-case scenario, this can result in a civilian death at the hands of police. 
                                      
                                      The criminal justice system in the United States is now coming under great scrutiny after decades of “tough on crime” policies have produced a world-record prison population with glaring racial disparities. And while proponents of these policies have premised their development as a crime control strategy, in fact a broad range of research has documented the relatively limited impact of expanded punishment on enhancing public safety. 
                                      
                                      Given these developments, our task force has attempted to produce a strategy for public safety that prioritized social and economic development over punishment and that fosters public safety regardless of ethnicity or economic background. Within the justice system we have attempted to lay out a series of steps that County policymakers can adopt to both address the racial disparities that plague our system and produce better public safety outcomes. 
                                      
                                      We are not unaware of the challenges facing the County at this moment. As is true in every community, the Covid-19 crisis and its disastrous effect on the economy has altered local government and all our lives in previously unimagined ways. But as we hope to work our way out of this environment in the coming year it behooves us to reimagine how we structure our daily life in all its aspects, including promoting public safety. Some of the recommendations that we propose in this report are long-term goals and strategies, which in many cases will involve a substantial shift in allocating resources. That process will take some time, but can only be successful if we begin now. Other measures can be implemented more quickly and clearly can put us on the road to better policy outcomes. 
                                      
                                      We are grateful to have had the opAportunity to engage in this effort, and we are appreciative of both the hard work of our task force members as well as the many County staff who informed our work and served as strong collaborators. We look forward to ongoing conversations with the broader community in this ongoing process of reimagining public safety
                                      
                                      Thank you, 
                                      Bernice Mireku-North & Marc Mauer
                                      
                                      " ),
                             
                             
                             
                            tabPanel(h4(style="color:black;","Resources & Feedback"), 
                                      "Community feedback is vital to the success of the Reimagining Public Safety initiative. The County invites you to get involved by sharing your comments and questions. To do so, please complete the survey form below. Thank you for your input. 
",
                                      HTML('<iframe src="https://docs.google.com/forms/d/1udozX6mm0NO9NceFe8fbQQpmzyHh0NMUE73BVlOP7RA/viewform?embedded=true" width="100%" height="360px" frameborder="0" marginheight="0" marginwidth="0">Loading…</iframe>')
                             )
                 ),
                 
                 #--------------------------------------
                 
                 h4(),
                 hr(style=paste0("margin:16px 0px 12px 0px;padding:0px;border-top: 1px solid", "#fdb927", ";")),
                 div(style="display: flex; flex-direction:row;justify-content: space-between;",
                     tags$i(h4("Designed by the CMU Policy Lab Team-Gisselt Gomez,Laknath Gunathilake,Mary Kubinski, Brian Martin")),
                     h4(style="font-size:20px;",
                        #Be sure to replace these with your organization's links.
                        a(style="padding-left:1px;", href=' https://twitter.com/MontgomeryCoMD', icon("twitter")), "  ",
                        a(style="padding-left:1px;", href='https://www.facebook.com/montgomerycountyinfo',icon("facebook-square")), "  ",
                        a(style="padding-left:1px;", href='https://www.youtube.com/channel/UC5NXwF1EDfbecNogLVlrALw',icon("youtube-square")), "  ",
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
           paste0("There Are  X number of recommendations completed so far, and X number  are in progress as of ",Sys.Date()
           )
    )
  })
  
  
  output$datasummary <- DT::renderDataTable(DT::datatable(data = df, 
                                                          options = list(pageLength = 10), 
                                                          rownames = FALSE))
  
  
  
  
  
  
}




# Run the application 
shinyApp(ui = ui, server = server)



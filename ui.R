shinyUI(fluidPage(theme = "Hospital.css",
                  titlePanel("Hospital Professional Nursing Care Salary Prediction Dashboard"),
                  
                  sidebarLayout(position = "right",
                                sidebarPanel(
                                        
                                        # dropdown to chose the role
                                        selectInput("role", label = h3("Hospital job function"),
                                                    choices = list("Nurse Technician" = 1,
                                                                   "Nursing Assistant" = 2,
                                                                   "Registered Nurse" = 3,
                                                                   "Nurse Manager"=4,
                                                                   "Nurse Practioner"=5),
                                                    selected = 4),
                                        
                                        # slider for years of experience (yoe)
                                        sliderInput("yoe", 
                                                    label = h3("Hospital experience (years)",align ="center"), 
                                                    value = 0, min = 0, max = 40, step = 1),
                                        
                                        # slider for salary
                                        sliderInput("salary", label = h3("Monthly Salary($)"),
                                                    min = 2000, max = 20000, step =1000, value = 2000),
                                        
                                        # explanatory text
                                        tags$hr(),
                                        h3  ("Prediction dashboard tool help"),
                                        tags$ol(tags$li("Job title from drop down menu"),
                                                tags$li("Slide to select the years of experience"),
                                                tags$li("Slide to select monthly salary you would like to offer to a candidate")),
                                        p("Popup: The purple dot in chart will show you the offer position and 
                                          difference from the average salary with years of experience.")
                      
                      ),
                    mainPanel(
                      
                      # ggplot output
                      plotOutput("hos"),
                      
                      # explanatory text
                      h3("Interactive Dashboard",align = "center"),
                      p("The interactive dashboard allows you to compare salary compensation to 
                        current compensation structures within a hospital job. It can be used to
                        prepare a fair salary offer for new candidates or in case of job promotions.
                        "),
                      
                      h3("Foot Notes"),
                      p("Dashboard uses simulated data set using normal distribution for prediction for testing app.Next step would be using a real hospital salary dataset.")
                    )
                  )
                  )
        )

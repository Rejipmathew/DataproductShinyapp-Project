generatehos <- function(n, minyoe, salmean, salsd, avginc) {
        
        # function to generate random peer salary depending on role parameters
        # n = number of peers, minyoe = minimum years of experience
        # salmean = mean of starting salary, salsd = std deviation of starting salary
        # avginc = average yearly increase of salary
        
        # uniform distribution of years of experience
        yoe <- runif(n, min = minyoe, max = 45-minyoe) 
        
        # normal distribution of salaries
        salary <- rnorm(n = n, salmean, salsd)
        
        # assign annual increases depending on years of experience
        salage <- salary*(1+avginc)^yoe
        
        # assign to data frame
        hos <- data.frame(yoe = yoe, salary = salage)
        
}

# generate five datasets
hos_Nursetechnician <- generatehos(n=35, minyoe=0, salmean = 2500, salsd = 150, avginc = 0.01)
hos_NurseAssistant <- generatehos(n=35, minyoe=3, salmean = 3000, salsd = 250, avginc = 0.02)
hos_RN <- generatehos(n=35, minyoe=5, salmean = 6000, salsd = 500, avginc = 0.03)
hos_Nursemanager <- generatehos(n=35, minyoe=7, salmean = 9000, salsd = 700, avginc = 0.05)
hos_NP <- generatehos(n=35, minyoe=9, salmean = 11000, salsd = 1100, avginc = 0.07)
library(shiny)
library(ggplot2)

shinyServer(function(input, output) {
        
        # generate ggplot output
        output$hos <- renderPlot({
                
                # chose peer data depending on role dropdown
                hos <- if(input$role == 1) {
                        hos_Nursetechnician
                } else if(input$role == 2) {
                        hos_NurseAssistant
                } else if(input$role == 3) {
                        hos_RN
                } else if(input$role == 4) {
                        hos_Nursemanager
                } else {
                        hos_NP
                }
                
                # create linear regression model on peer data
                mod <- lm(salary ~ yoe, data = hos)
                
                # predict ideal salary based on best fit model
                pred <- predict (mod, newdata = data.frame(yoe = input$yoe))
                
                # calculate difference to best fit and create label
                dif <- round(1-pred/input$salary, 2)*10
                diftext <- ifelse(dif>0, paste("+",dif,"%"),paste(dif,"%"))
                
                # assemble ggplot
                p <- ggplot(hos, aes(yoe, salary)) +
                        geom_point(shape = 5, color= "red3") +
                        geom_smooth(method=lm, se = FALSE) +
                        geom_point(aes_string(x = input$yoe, y = input$salary), size = 7, color = "purple") +
                        xlab("Experience in years") + ylab("Monthly base salary, $") +
                        annotate("text", x = input$yoe+2.5, y = input$salary, label = diftext)
                
                print(p)
        })
        
})

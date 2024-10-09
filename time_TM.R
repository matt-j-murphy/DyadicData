############################################################################################################
#Modeling the Time Course of Continuous Outcomes
##Note: The code assumes that the data file time.csv has been copied to your default directory
############################################################################################################

#clear environment 
rm(list=ls())

#set working directory 
setwd("...")

############################################################################################################
#load the nlme package
library(nlme)
# NOTE: The lme4-package can be an alternative here! 
############################################################################################################

############################################################################################################
#Read a csv file containing the data
time <- read.csv('time.csv')
############################################################################################################

############################################################################################################

#Plotting the intimacy data for participant 1
par(mfcol=c(1,1))
plot(time$time[time$id == 1], time$intimacy[time$id == 1],
     ylab="intimacy", xlab="time", type="o", pch=4,ylim=c(0,8), main="id = 1")

#Plotting the intimacy data for participant 2
par(mfcol=c(1,1))
plot(time$time[time$id == 2], time$intimacy[time$id == 2],
     ylab="intimacy", xlab="time", type="o", pch=4, ylim=c(0,8), main="id = 2")

#and so on... or: Use a for-loop!
#Figure 4.2: Panel plots for Control Group
par(mfcol=c(5,5), mar=c(2,2,2,2)) #you might need to adjust figure margins using mar
for (i in 1:25){
  plot(time$time[time$id==i], time$intimacy[time$id==i], 
  ylab="intimacy", xlab="time", type="o", pch=4, ylim=c(0,8), main=paste("id =", i, sep = " "))
}
mtext("Control Group", side=3, outer=TRUE, line=-1.2)

#Figure 4.2: Panel plots for Treatment Group
par(mfcol=c(5,5),mar=c(2,2,2,2))
for (i in 26:50){
  plot(time$time[time$id==i], time$intimacy[time$id==i], 
       ylab="intimacy", xlab="time", type="o", pch=4, ylim=c(0,8), main=paste("id =", i, sep = " "))
}
mtext("Treatment Group", side=3, outer=TRUE, line=-1.2)

# Put all the data in one plot 
par(mfcol=c(1,2), mar = c(5,5,2,1))
plot(time$time, time$intimacy, 
     ylab="initimacy", xlab="time", main = "Control", type="n", pch=4) 
for(i in 1:25){
  lines(time$time[time$id==i], time$intimacy[time$id==i])
}

plot(time$time, time$intimacy, 
     ylab="initimacy", xlab="time", main = "Treatment", type="n", pch=4) 
for(i in 26:50){
  lines(time$time[time$id==i], time$intimacy[time$id==i])
}

# Plot the aggreagted data (daily intimacy score averaged across all participants)
# might be useful to spot inital elevation, etc.
agg_intim <- aggregate(intimacy ~ time + treatment, data = time, mean)

par(mar = c(5,5,2,1), mfcol=c(1,2))
plot(agg_intim$time[agg_intim$treatment == 0], agg_intim$intimacy[agg_intim$treatment == 0], 
     ylab="(mean) intimacy", xlab="time", type="o", pch=20, ylim = c(0,8), main = "Control", cex.lab = 1, cex.main = 0.95) 

plot(agg_intim$time[agg_intim$treatment == 1], agg_intim$intimacy[agg_intim$treatment == 1], 
     ylab="(mean) intimacy", xlab="time", type="o", pch=20, ylim = c(0,8), main = "Treatment", cex.lab = 1, cex.main = 0.95) 

# using plots from the lattice package
library(lattice)

#control group
xyplot(intimacy ~ time | id, time[time$treatment == 0,], 
       pch = 20, type=c("p", "r"), xlab = "time", ylab = "time", layout = c(5,5))

#treatment group
xyplot(intimacy ~ time | id, time[time$treatment == 1,], 
       pch = 20, type=c("p", "r"), xlab = "time", ylab = "time", layout = c(5,5))


############################################################################################################


############################################################################################################

#random intercept model 
lgmodel_0 <- lme(fixed=intimacy ~ 1, data=time, random=~1 | id)
summary(lgmodel_0)
# ICC = 0.8049621 / (0.8049621+1.427089) = 0.3606
intervals(lgmodel_0) # to get the confidence intervals

#linear growth model with fixed time effect 
lgmodel_1 <- lme(fixed=intimacy ~ time01, data=time, random=~1 | id)
summary(lgmodel_1)
intervals(lgmodel_1)

#linear growth model with random time effect
lgmodel_11 <- lme(fixed=intimacy ~ time01, data=time, random=~time01 | id)
summary(lgmodel_11)
intervals(lgmodel_11)

#likelihood ratio test to compare models
anova(lgmodel_1, lgmodel_11)

#linear growth model differentiating between groupps with AR(1) errors 
lgmodel_2 <- lme(fixed=intimacy ~ time01 * treatment, data=time, random=~time01 | id, correlation = corAR1())
summary(lgmodel_2)
intervals(lgmodel_2)

############################################################################################################


############################################################################################################
#Figure 4.4: Panel plots for Control Group with Actual and Model-Predicted Time Course
par(mfcol=c(5,5), mar=c(2,2,2,2))
for (i in 1:25){
  plot(time$time[time$id==i], time$intimacy[time$id==i], 
       ylab="intimacy", xlab="time", type="o", pch=4, ylim=c(0,8), main=paste("id =", i, sep = " "))
  lines(time$time[time$id==i], fitted(lgmodel_2)[time$id==i])
}
mtext("Control Group", side=3, outer=TRUE, line=-1.2)

#Figure 4.4: Panel plots for Treatment Group with Actual and Model-Predicted Time Course
par(mfcol=c(5,5), mar=c(2,2,2,2))
for (i in 26:50){
  plot(time$time[time$id==i], time$intimacy[time$id==i], 
       ylab="intimacy", xlab="time", type="o", pch=4, ylim=c(0,8), main=paste("id =", i, sep = " "))
  lines(time$time[time$id==i], fitted(lgmodel_2)[time$id==i])
}
mtext("Treatment Group", side=3, outer=TRUE, line=-1.2)
############################################################################################################



############################################################################################################
#Figure 4.5: Spaghetti Plots for Control Group and Treatment Group

par(mfcol=c(1,2))
plot(time$time[time$treatment==0], time$intimacy[time$treatment==0], 
     ylab="intimacy", xlab="time", type="n", pch=4, ylim=c(0,8), main="Control")
for (i in 1:25){
  lines(time$time[time$id==i], fitted(lgmodel_2)[time$id==i])
}
predc<-2.8989745 + ((0.7352012)/15)*time$time

lines(time$time, predc, lwd=4)


plot(time$time[time$treatment==1], time$intimacy[time$treatment==1], 
     ylab="intimacy", xlab="time", type="n", pch=4, ylim=c(0,8), main="Treatment")
for (i in 26:50){
  lines(time$time[time$id==i], fitted(lgmodel_2)[time$id==i])
}
predt<-(2.8989745 - 0.0564426) + ((0.7352012 + 0.9214365)/15)*time$time
lines(time$time, predt, lwd=4)
############################################################################################################


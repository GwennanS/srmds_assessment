library(rio)
library(dplyr)
library(ggplot2)
library(emmeans)
library(pander)
library(tidyr)

d <- import("Computer_Science/Current_Courses/Seminar_RMDS/srmds_assessment/CourseworkB/data.csv")

# Preliminary analysis w/o controlling for any factors
m <- lm(score~ ., d)
pander(summary(m))
#pairs(emmeans(m, ~(TrD1 + TrD2 + TrD3 + TrD4 + TrD5 + TrD6 + TrD7 + TrD8)))
# Results show that the R^2 is very low (0.02). This model fails to capture majority of the variance in the dataset
ggplot() + geom_line(data = d, aes(y=mean(score), x = TeD)) 

data <- data.frame(TrDs)
data$TrDs <-  c("TrD1","TrD2","TrD3","TrD4","TrD5","TrD6","TrD7","TrD8")
TrDs <- c("TrD1","TrD2","TrD3","TrD4","TrD5","TrD6","TrD7","TrD8")
mean1 <- mean(d[d$TrD1 == 1 & d$TeD == "TeD7", "score"])
mean2 <- mean(d[d$TrD2 == 1 & d$TeD == "TeD7", "score"])
mean3 <- mean(d[d$TrD3 == 1 & d$TeD == "TeD7", "score"])
mean4 <- mean(d[d$TrD4 == 1 & d$TeD == "TeD7", "score"])
mean5 <- mean(d[d$TrD5 == 1 & d$TeD == "TeD7", "score"])
mean6 <- mean(d[d$TrD6 == 1 & d$TeD == "TeD7", "score"])
mean7 <- mean(d[d$TrD7 == 1 & d$TeD == "TeD7", "score"])
mean8 <- mean(d[d$TrD8 == 1 & d$TeD == "TeD7", "score"])
data$TeD7mean <-c (mean1, mean2, mean3, mean4, mean5, mean6, mean7, mean8)


x <- cbind(data$TrDs,data$TrDs,data$TrDs,data$TrDs,data$TrDs,data$TrDs,data$TrDs)
y <- cbind(data$TeD1mean, data$TeD2mean, data$TeD3mean, data$TeD4mean, data$TeD5mean, data$TeD6mean, data$TeD7mean)

library(ggplot2)
library(reshape2)
datamelt <- melt(data, id.vars="TrDs")

# Everything on the same plot
ggplot(datamelt, aes(TrDs,value, col=variable)) + 
  geom_line(aes(group = variable)) +
  geom_point() 
# Modeling with both the factors's interaction effect
m <- lm(score ~ (TrD1 + TrD2 + TrD3 + TrD4 + TrD5 + TrD6 + TrD7 + TrD8) * TeD, d)
pander(summary(m))
#pairs(emmeans(m, ~(TrD1 + TrD2 + TrD3 + TrD4 + TrD5 + TrD6 + TrD7 + TrD8) | TeD))

d %>% 
  gather('TrD', 'score', TrD1+TrD8 + TrD2+TrD7) %>%
  group_by(TrD) %>% 
  summarise(n = mean(score)) %>% 
  ggplot(aes(x = TrD, y = n)) +
  geom_col() +
  theme_classic()
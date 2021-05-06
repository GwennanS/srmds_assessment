library(AICcmodavg)

# Get data
filepath <- "courseworkA/set0.csv"
ds <- read.csv(file=filepath, header=TRUE)
ds <- data.frame(ds)

# set labels
ds$sessionF <- factor(ds$session, levels=c(0:49), labels=c(0:49))

# create models as given in slides lecture 4
model0 <- lm(formula=score~1, data=ds, na.action=na.exclude)
model1 <- lm(formula=score~sessionF, data=ds, na.action=na.exclude)

# analysis, see if predictor improves fitting
anova(model0,model1)
summary(model1)

models <- list(model0, model1)
model.names <- c("model0", "model1")
aictab(cand.set = models, modnames=model.names)

# #AIC
# smodel0 = summary(model0)
# llm0 <- sum(dnorm(ds$score, mean=predict(model0), sd=smodel0$sigma, log=TRUE))
# AIC_model0 <- -2*llm0 + 2*2
# AIC_model0
# 
# smodel1 = summary(model1)
# llm1 <- sum(dnorm(ds$score, mean=predict(model1), sd=smodel1$sigma, log=TRUE))
# AIC_model1 <- -2*llm1 + 2*3
# AIC_model1

# # examine estimators
# anova(model1)
# 
# # gives CI95%
# confint(model1)
# 
# # plot figures
# #plot(model1)
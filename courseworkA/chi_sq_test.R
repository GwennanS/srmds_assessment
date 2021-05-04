# Get data
filepath <- "set0.csv"
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

# examine estimators
anova(model1)

# gives CI95%
confint(model1)

# plot figures
#plot(model1)
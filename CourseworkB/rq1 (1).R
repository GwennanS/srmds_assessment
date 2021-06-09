library(rio)
library(dplyr)
library(ggplot2)
library(emmeans)
library(pander)

d <- import("data.csv")

# Preliminary analysis w/o controlling for any factors
m <- lm(score~model, d)
pander(summary(m))
pairs(emmeans(m, ~model))
# Results show that the R^2 is very low (0.02). This model fails to capture majority of the variance in the dataset

# Visualizing the factors
ggplot(d, aes(score, model)) + geom_boxplot(notch = FALSE) + facet_wrap(~TeD)
# Model performance varies with the TeD choice as well!

# Modeling with both the factors's interaction effect
m <- lm(score ~ model * TeD, d)
pander(summary(m))
pairs(emmeans(m, ~model | TeD))

library(rio)
library(dplyr)
library(ggplot2)

filepath <- "CourseworkB/data.csv"
d <- read.csv(filepath)
d <- data.frame(d)
d %>% count(model)



# 1: How much does transfer learning improve over typical non-transfer learning?

# check mean of models
d %>% group_by(model) %>% summarize(mean(score))

# create plot
ggplot(d, aes(score)) + geom_histogram(binwidth = 0.1) + facet_wrap(~model)

# separate without TrD (BX) and with TrD (S, MX) models
d$transfer <- with(d, ifelse((grepl("B", d$model, fixed=TRUE)), 0, 1))

# create plot
ggplot(d, aes(score)) + geom_histogram(binwidth = 0.1) + facet_wrap(~transfer)

# t-test on TrD vs no TrD
t.test(score ~ transfer, d)

# wilcoxon on TrD vs no TrD
wilcox.test(score ~ transfer, d)




# 2. RQ2: What is the effect of the TrD’s on the final model performance?

# set for each TrD
t1 <- subset(d, select=c(TrD1, score))
# t2 <- ...

# check mean
t1 %>% group_by(TrD1) %>% summarize(mean(score))

# plot TrD 0 vs 1
ggplot(t1, aes(score)) + geom_histogram(binwidth = 0.1) + facet_wrap(~TrD1)

# t-test
t.test(score ~TrD1, t1)

# wilcoxon test
wilcox.test(score ~ TrD1, t1)

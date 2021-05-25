# Importing libs and data file
library(rio)
library(ggplot2)
library(dplyr)
library(pander)
library(coin)

data <- import("data.csv")


# Inspecting some summary statistics

# counts of models
data %>% count(model)

# mean scores of models
data %>%
  group_by(model) %>%
  summarize(mean(score))


# Analysing the data distribution of models separately

typical <- select(filter(data, (model == 'B1') | (model == 'B2') | (model == 'B3')), c(model, score))
transfer <- select(filter(data, (model != 'B1') & (model != 'B2') & (model != 'B3')),c(model, score))

data$type <- data$model
data$type[(data$model == 'B1') | (data$model == 'B2') | (data$model == 'B3')] <- 'B1'


data$typeBin[(data$model == 'B1') | (data$model == 'B2') | (data$model == 'B3')] <- 'B'
data$typeBin[(data$model == 'M1') | (data$model == 'M2') | (data$model == 'M3') | (data$model == 'MN') | (data$model == 'MF') | (data$model == 'S')] <- 'M'

data$task <- 'Classification'
data$task[(data$TeD == 'TeD5')] <- 'Recommendation'
data$task[(data$TeD == 'TeD6') | (data$TeD == 'TeD7')] <- 'Regression'


ggplot(typical, aes(score)) +
  geom_histogram(binwidth = 0.05) +
  facet_wrap(~model)

ggplot(transfer, aes(score)) +
  geom_histogram(binwidth = 0.05) +
  facet_wrap(~model)

# Analysing the data distribution of Transfer learning vs Typical learning by aggregating the data across models

ggplot(typical, aes(score)) +
  geom_histogram(binwidth = 0.05)

ggplot(transfer, aes(score)) +
  geom_histogram(binwidth = 0.05)

# Performing Wilcoxon Statistical Test for comparison of means 

transfer$type = 'transfer'
typical$type = 'typical'
all <- rbind(transfer, typical)

all %>%
  group_by(type) %>%
  summarize(mean(score))

# independence_tests for the dataset
library(coin)

all$type <- as.factor(all$type)
data$type <- as.factor(data$type)
data$model <- as.factor(data$model)
data$TeD <- as.factor(data$TeD)
data$factorized <- NULL


independence_test(score ~ type, all)

independence_test(score ~ model*TeD, data)

independence_test(score ~ type, data)

summary(lm(score ~ type , data))

# wilcoxon tests for refined data
modelM1 = filter(data, model == "MN" | model == "M1")
modelM2 = filter(data, model == "MN" | model == "M2")
modelM3 = filter(data, model == "MN" | model == "M3")
modelMF = filter(data, model == "MN" | model == "MF")
modelM1F = filter(data, model == "M1" | model == "MF")
modelM12 = filter(data, model == "M1" | model == "M2")
modelM23 = filter(data, model == "M2" | model == "M3")
modelM3F = filter(data, model == "M3" | model == "MF")


pander(wilcox.test(score ~ model, modelM1, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ model, modelM2, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ model, modelM3, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ model, modelMF, conf.int = TRUE, conf.level = 0.95))

pander(wilcox.test(score ~ model, modelM1, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ model, modelM12, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ model, modelM23, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ model, modelM3F, conf.int = TRUE, conf.level = 0.95))

data %>%
  group_by(model, TeD) %>%
  summarize(mean(score))

ModelxTeD = summarise(group_by(data, model, TeD), mean(score))

# Wilcoxon test fro testing dataset types
modelCla = filter(data, task == "Classification" )
modelRec = filter(data, task == "Recommendation" )
modelReg = filter(data, task == "Regression" )

pander(wilcox.test(score ~ typeBin, modelCla, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ typeBin, modelRec, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ typeBin, modelReg, conf.int = TRUE, conf.level = 0.95))

summarise(group_by(data, typeBin, task), mean(score))




summary(lm(score ~ TeD, data))
summary(lm(score ~ type*TeD, data))
summary(lm(score ~ TrD1 + TrD2+ TrD3+ TrD4+ TrD5+ TrD6+ TrD7+ TrD8, data))
summary(lm(score ~ (TrD1 + TrD2+ TrD3+ TrD4+ TrD5+ TrD6+ TrD7+ TrD8)*TeD, data))
summary(lm(score ~ TrD1 * TrD2 * TrD3 * TrD4 * TrD5 * TrD6 * TrD7 * TrD8, data))


# Plotting data distributions for each TeD

ted1 <- select(filter(data, (TeD == 'TeD1') ), c(TeD, score))
ted2 <- select(filter(data, (TeD == 'TeD2') ), c(TeD, score))
ted3 <- select(filter(data, (TeD == 'TeD3') ), c(TeD, score))
ted4 <- select(filter(data, (TeD == 'TeD4') ), c(TeD, score))
ted5 <- select(filter(data, (TeD == 'TeD5') ), c(TeD, score))
ted6 <- select(filter(data, (TeD == 'TeD6') ), c(TeD, score))
ted7 <- select(filter(data, (TeD == 'TeD7') ), c(TeD, score))

ggplot(ted1, aes(score)) +
  geom_histogram(binwidth = 0.01) +
  facet_wrap(~TeD  )
ggplot(ted2, aes(score)) +
  geom_histogram(binwidth = 0.01) +
  facet_wrap(~TeD)
ggplot(ted3, aes(score)) +
  geom_histogram(binwidth = 0.01) +
  facet_wrap(~TeD)
ggplot(ted4, aes(score)) +
  geom_histogram(binwidth = 0.01) +
  facet_wrap(~TeD)
ggplot(ted5, aes(score)) +
  geom_histogram(binwidth = 0.01) +
  facet_wrap(~TeD)
ggplot(ted6, aes(score)) +
  geom_histogram(binwidth = 0.01) +
  facet_wrap(~TeD)
ggplot(ted7, aes(score)) +
  geom_histogram(binwidth = 0.01) +
  facet_wrap(~TeD)


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

library(coin)

all$type <- as.factor(all$type)
data$type <- as.factor(data$type)
data$model <- as.factor(data$model)
data$TeD <- as.factor(data$TeD)
data$factorized <- NULL

independence_test(score ~ type, all)

independence_test(score ~ model*TeD, data)

independence_test(score ~ type, data)

summary(lm(score ~ type, data))
summary(lm(score ~ TeD, data))
summary(lm(score ~ TeD*type, data))
summary(lm(score ~ TrD1 + TrD2+ TrD3+ TrD4+ TrD5+ TrD6+ TrD7+ TrD8, data))
summary(lm(score ~ (TrD1 + TrD2+ TrD3+ TrD4+ TrD5+ TrD6+ TrD7+ TrD8)*TeD, data))
summary(lm(score ~ TrD1 * TrD2 * TrD3 * TrD4 * TrD5 * TrD6 * TrD7 * TrD8, data))


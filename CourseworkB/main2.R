# Importing libs and data file
library(rio)
library(ggplot2)
library(dplyr)
library(pander)
library(coin)

#set up data
data <- import("data.csv")

data$type <- data$model
data$type[(data$model == 'B1') | (data$model == 'B2') | (data$model == 'B3')] <- 'B1'

data$typeBin[(data$model == 'B1') | (data$model == 'B2') | (data$model == 'B3')] <- 'B'
data$typeBin[(data$model == 'M1') | (data$model == 'M2') | (data$model == 'M3') | (data$model == 'MN') | (data$model == 'MF') | (data$model == 'S')] <- 'M'

data$task <- 'Classification'
data$task[(data$TeD == 'TeD5')] <- 'Recommendation'
data$task[(data$TeD == 'TeD6') | (data$TeD == 'TeD7')] <- 'Regression'

data$type <- as.factor(data$type)
data$model <- as.factor(data$model)
data$TeD <- as.factor(data$TeD)

# wilcoxon tests for refined data
modelM1 = filter(data, model == "MN" | model == "M1")
modelM2 = filter(data, model == "MN" | model == "M2")
modelM3 = filter(data, model == "MN" | model == "M3")
modelMF = filter(data, model == "MN" | model == "MF")
modelM1F = filter(data, model == "M1" | model == "MF")
modelM12 = filter(data, model == "M1" | model == "M2")
modelM23 = filter(data, model == "M2" | model == "M3")
modelM3F = filter(data, model == "M3" | model == "MF")

# ModelxTeD = summarise(group_by(data, model, TeD), mean(score))


pander(wilcox.test(score ~ model, modelM1, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ model, modelM2, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ model, modelM3, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ model, modelMF, conf.int = TRUE, conf.level = 0.95))

pander(wilcox.test(score ~ model, modelM1, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ model, modelM12, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ model, modelM23, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ model, modelM3F, conf.int = TRUE, conf.level = 0.95))


# Wilcoxon test fro testing dataset types
modelCla = filter(data, task == "Classification" )
modelRec = filter(data, task == "Recommendation" )
modelReg = filter(data, task == "Regression" )

pander(wilcox.test(score ~ typeBin, modelCla, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ typeBin, modelRec, conf.int = TRUE, conf.level = 0.95))
pander(wilcox.test(score ~ typeBin, modelReg, conf.int = TRUE, conf.level = 0.95))

# TypeBinxTask = summarise(group_by(data, typeBin, task), mean(score))
library(ggplot2)
library(sm)

# Get data
filepath <- ("courseworkA/set0.csv")
ds <- read.csv(file=filepath, header=TRUE)
ds <- data.frame(ds)

# boxplot score overall distribution (session independent)
#boxplot(ds$score)

# set labels
ds$sessionF <- factor(ds$session, levels=c(0:49), labels=c(0:49))

# boxplot score per session
#boxplot(score~sessionF, data=ds, main="Score", xlab="session", ylab="score")

p <- ggplot(ds, aes(x=score)) + geom_density()
p + geom_vline(aes(xintercept=mean(score)), color="blue", linetype="dashed",size=1)

# ggplot score per session
#hp <- ggplot(ds, aes(x=session, y=score)) + geom_point(shape=1) + geom_smooth(method=lm)
#hp
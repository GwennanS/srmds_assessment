library(rethinking)

# Get data
filepath <- ("courseworkA/set0.csv") # change path when you put it in Rmd (delete "courseworkA")
ds <- read.csv(file=filepath, header=TRUE)
ds <- data.frame(ds)
ds <- ds[!(ds$Subject>99),] # select first 100 subjects
ds$Subject <- ds$Subject +1 # increase subject number with 1 to overcome Stan zero index problem

mean(ds$score) # check mean
sd(ds$score) # check standard deviation

ds$sessionF <- factor(ds$session, levels=c(0:49), labels=c(0:49))
ds$subjF <- factor(ds$Subject, levels=c(1:100), labels=c(1:100))

da <- subset(ds, select=c(score, sessionF))
da1 <- subset(ds, select=c(score, subjF))

# create model with fixed intercept (i)
m0 <- map2stan(
  alist(
    score ~ dnorm(mu, sigma),
    mu <- a,
    a ~dnorm(125,30), # mean and sd from what we found above
    sigma ~dunif(0.001,40)
  ), data = da, iter = 10000, chains = 4, cores = 4
)

# create model extended with an adaptive prior for subject id (ii)
m1 <- map2stan(
  alist(
    score ~ dnorm(mu, sigma),
    mu <- a[subjF],
    a[subjF] ~ dnorm(125,sigma_subj),
    sigma_subj ~ dcauchy(0,10),
    sigma ~dunif(0.001,40)
  ), data = da1, iter = 10000, chains = 4, cores = 4
)

# create model with session as a factor (iii)
m2 <- map2stan(
  alist(
    score ~ dnorm(mu, sigma),
    mu <- a[sessionF],
    a[sessionF] ~ dnorm(125,30),
    sigma ~dunif(0.001,40)
  ), data = da, iter = 10000, chains = 4, cores = 4
)
compare(m0,m1,m2,func=WAIC)
library(rethinking)

# Get data
filepath <- ("courseworkA/set0.csv") # change path when you put it in Rmd (delete "courseworkA")
ds <- read.csv(file=filepath, header=TRUE)
ds <- data.frame(ds)

ds$sessionF <- factor(ds$session, levels=c(0:49), labels=c(0:49))

# subset with the variables we'll be using
da <- subset(ds, select=c(score, sessionF)) # change this to also include only first 100 participants

# create model with fixed intercept (i)
m0 <- map2stan(
  alist(
    score ~ dnorm(mu, sigma),
    mu <- a,
    a ~dnorm(50,25),
    sigma ~dunif(0.001,40)
  ), data = da, iter = 10000, chains = 4, cores = 4
)

# # create model extended with an adaptive prior for subject id (ii)
# m1 <- map2stan() # not sure how...

# # create model with session as a factor (iii)
# m2 <- map2stan(
#   alist(
#     score ~ dnorm(mu, sigma),
#     mu <- a[sessionF],
#     a[sessionF] ~ dnorm(50,25),  # numbers copied from example, not sure if they can stay the same
#     sigma ~dunif(0.001,40)  # numbers copied from example, not sure if they can stay the same
#   ), data = da, iter = 10000, chains = 4, cores = 4  # numbers copied from example, not sure if they can stay the same
# )

# # Model comparison
# plot(compare(m0,m2,func=WAIC))
# plot(precis(m2, depth=2, prob=.95))
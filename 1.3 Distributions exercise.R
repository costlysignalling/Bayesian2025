# a person asking 10 people on dates repeatedly for 100 times
sec.dates=rep(NULL, 100)
for(i in 1:100){
  sec.dates[i]=sum(rbinom(10,1,0.3))
}
sec.dates


# 100 different people asking 10 people on dates
sec.dates2=rep(NULL, 100)
for(i in 1:100){
  sec.dates2[i]=sum(rbinom(10,1,rbeta(1, 0.3*3,0.7*3)))
}
sec.dates2

# beta dist
plot(density(rbeta(100,2,4)), xlim=c(0,1),ylim=c(0,5))
curve(dbeta(x,2,4),add=T, col="red")

plot(density(rbeta(100,0.4*4,0.6*4)), xlim=c(0,1),ylim=c(0,5))
curve(dbeta(x,0.4*4,0.6*4),add=T, col="red")

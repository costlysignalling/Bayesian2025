# a person asking 10 people on dates repeatedly for 100 times
sec.dates=rep(NULL, 100)
for(i in 1:100){
  p=0.3
  sec.dates[i]=sum(rbinom(10,1,p))
}
sec.dates


# 100 different people asking 10 people on dates
sec.dates2=rep(NULL, 100)
for(i in 1:100){
  p=rbeta(1, 0.3*8,0.7*8)
  sec.dates2[i]=sum(rbinom(10,1,p))
}
sec.dates2

# 100 different people asking 10 people on dates
sec.dates3=rep(NULL, 100)
for(i in 1:100){
  q=rbeta(1, 0.3*8,0.7*8)
  p=rbeta(1, q*11,(1-q)*11)
  sec.dates3[i]=sum(rbinom(10,1,p))
}
sec.dates3


# beta dist
plot(density(rbeta(100,2,4)), xlim=c(0,1),ylim=c(0,5))
curve(dbeta(x,2,4),add=T, col="red")

plot(density(rbeta(100,0.4*4,0.6*4)), xlim=c(0,1),ylim=c(0,5))
curve(dbeta(x,0.4*4,0.6*4),add=T, col="red")

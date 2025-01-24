library(rethinking)

y=rpois(5,lambda=20)
y
y=as.double(y)

poism=alist(
  #model (lh)
  y~dpois(lambda),
  #prior
  #lambda~dexp(0.03)
  lambda~dunif(0,100)
)
poism

post=ulam(flist=poism,
          data=list(y=y))

precis(post)


traceplot(post)
plot(post)
epost=extract.samples(post)
hist(epost$lambda)

#1 use exponential prior
poisme=alist(
  #model (lh)
  y~dpois(lambda),
  #prior
  lambda~dexp(0.1)
  #lambda~dunif(0,100)
)
poisme

poste=ulam(flist=poisme,
          data=list(y=y))

precis(poste)
traceplot(poste)
plot(poste)
eposte=extract.samples(poste)
hist(eposte$lambda)

curve(dexp(x,rate = 10),0,10, lwd=2)
curve(dexp(x,rate = 1),0,10, add=T, lwd=2, col="red")
curve(dexp(x,rate = 0.1),0,10, add=T, lwd=2, col="blue")

#2 more data
y2=rpois(50,lambda=20)
y2
y2=as.double(y2)

poism=alist(
  #model (lh)
  y~dpois(lambda),
  #prior
  #lambda~dexp(0.03)
  lambda~dunif(0,100)
)
poism

postm=ulam(flist=poism,
          data=list(y=y2))

precis(postm)

traceplot(postm)
plot(postm)
epostm=extract.samples(postm)
hist(epostm$lambda)

#3 more chains
?ulam
postmc=ulam(flist=poism,
           data=list(y=y), chains = 4, cores = 3)

precis(postmc)

traceplot(postmc)
plot(postmc)
epostmc=extract.samples(postmc)
hist(epostmc$lambda)

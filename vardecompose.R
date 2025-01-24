library(rethinking)


ns<-200
avgx<--0.3
suitors<-rnorm(ns,0,0.8)
nt<-100
targets<-rnorm(nt,0,1.2)
inters<-rnorm(nt*ns,0,0.3)

d<-data.frame(sID=rep(1:ns,each=nt),tID=rep(1:nt,times=ns))
d$basex<-avgx+suitors[d$sID]+targets[d$tID]+inters
d$p<-exp(d$basex)/(1+exp(d$basex))
d$yes<-rbinom(ns*nt,1,prob=d$p)

d$iID<-1:(ns*nt)

m<-alist(yes~binomial(1,p),
         logit(p)<-avgx+suitors[sID]+targets[tID],
         avgx~normal(0,2),
         suitors[sID]~normal(0,SDs),
         targets[tID]~normal(0,SDt),
         SDs~exponential(0.5),
         SDt~exponential(0.5))

dlist<-list(sID=d$sID,
            tID=d$tID,
            yes=d$yes)

fit<-ulam(m,data=dlist,chains = 4,cores = 4)

stancode(fit)

precis(fit)

precis(fit,depth=2)


post<-extract.samples(fit)
str(post)

paul<-post$suitors[,3]
john<-post$suitors[,15]

precis(paul-post$suitors[,153],prob=0.95)

sum((paul-post$suitors[,153])<0)/2000

(paul-post$suitors[,153])[(paul-post$suitors[,153])<0]

x<-rnorm(1000,0,1.2)
p<-exp(x)/(1+exp(x))
plot(density(p))




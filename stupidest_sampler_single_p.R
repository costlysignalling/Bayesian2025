#Paul

rbinom(1000,1,prob=0.4)
yes<-c(0,0,1,0,1,0,0,0,0,1,0)

yes<-rbinom(10,1,prob=0.4)

genHyp<-function(){
paulsp<-rbeta(1,shape1=1,shape2=1)
point_lik<-dbinom(yes,1,prob=paulsp)
Dlik<-prod(point_lik)
return(c(paulsp=paulsp,Dlik=Dlik))
}

Hyps<-replicate(100000,genHyp())
str(Hyps)

winners<-Hyps[,sample(1:ncol(Hyps),1000,replace=T,prob=Hyps["Dlik",])]

summary(winners["paulsp",])
plot(density(winners["paulsp",]))

yes

yes<-rbinom(1000,1,prob=0.4)
fit<-ulam(alist(yes~binomial(1,p),
                p~beta(1,1)),
          data=list(yes=yes),chains=4,cores=4)

precis(fit)


yes<-rbinom(1000,1,prob=0.4)
fit<-ulam(alist(yes~binomial(1,p),
                logit(p)<-a,
                a~normal(0,2)),
          data=list(yes=yes),chains=4,cores=4)

precis(fit)

post<-extract.samples(fit)

precis(c(post$a))
precis(c(inv_logit(post$a)))


yes<-rbinom(1000,1,prob=0.4)
fit<-ulam(alist(yes~binomial(1,p),
                logit(p)<-logit(pbase)+b*age+b2*haircolor,
                pbase~beta(1,1)),
          data=list(yes=yes),chains=4,cores=4)





     
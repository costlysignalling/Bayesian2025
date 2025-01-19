#################################################################
### Additive vs multiplicative, real-number domain mapping ###
#################################################################

#What happens when we replace the addition with multiplication; sum with product and a "small contribution" like +1 -1 with increase by 10% (*1.1) or decrease by 9.1% (*1/1.1)
v<-replicate(1000,prod(sample(c(1/1.1,1.1),size=500,replace=TRUE)))
plot(density(v)) #We get a right-skewed distribution

#Try to find it on the handout.
#It is the log-normal distribution; a distribution of numbers whose logarithms are normally distributed.
plot(density(log(v)))

#It is no surprise. Logarithms - together with their inverse exponential function - were designed to translate between additive and multiplicative domain. If our ancestors needed to multiply 3 very large numbers, it was easier for them to covert them to their logarithms (with the help of painstakingly created and distributed logarithm tables and rulers) sum those logs and exponentiate the result.
3354521*856*78991

(sumlog<-log(3354521)+log(856)+log(78991))
exp(sumlog)

#Sometimes this is retold as the wisdom that "logarithm of a product is a sum of logarithms"
log(653*984,base=2)
log(653,base=2)+log(984,base=2) #(true for any base)

#Logarithm and exponential function can be therefore used as neat mapping functions between domain of all real numbers (-Inf,Inf) and positive real numbers. If you need to do a linear regression model where there is a lot of additions, so theoretically, the outcome can be negative, but the modeled parameter is strictly positive (for instance the mean of Poisson distribution) just map the result of the regression to (0,Inf) with exponential function. (Or tell your model - if possible - that what the regression terms add up to is logarithm of the parameter; see the batman mapping in handout. To map between -Inf,Inf and 0,1 domain (useful for instance in mapping linear regression to the p parameter of binomial distribution), you can use logistic/logit mapping).
logit<-function(p){log(p/(1-p))}
inv_logit<-function(x){exp(x)/(exp(x)+1)}

logit(0.99)
inv_logit(-4)
logit(inv_logit(16))

#Mathematicians frequently used natural logarithm (base e=2.7....) or base-10 logarithm if they lean into physics, yet there are better logarithms if you do not need to execute simple mathematical operations but to visualize data and understand relationships between them (see the handout).

#Technically log-normal and not normal distribution is the maximum entropy distribution if you only know that the number you need to draw is definitely positive, there is no strict upper limit to it and its standard deviation may not be equal to the mean (so it is not the exponential distribution).
#It is parametrized by mean natural logarithm (m in the handout - it is also equal to logarithm of median, so this one is not too scary) and standard deviation of natural logarithm (s - this one is more tricky) which may be sometimes difficult to imagine right when you want to generate some data. But again, using some basic arithmetic you can get formulas for these "native" parameters using the parameters that you understand better. For instance you can find log-normal distribution with arithmetic mean (\mu) 175 and standard deviation (\sigma) equal to 8. (Similar to human height, which on one hand is very much influenced by additive genetic variance, yet it is strictly positive number)

#TASK
#Use the formulas on the handout (the other formula for s uses logarithm median instead of mean) to find log-normal distribution with.
mu<-175
sigma<-8


#Solution
m<-log((mu^2)/sqrt(mu^2+sigma^2))
s<-sqrt(log(1+(sigma^2)/(mu^2)))
m
s

v<-rlnorm(1000,meanlog=m,sdlog=s)
plot(density(v))
#You can see that for median/mean so far from 0, and with small sd, log-normal distribution resembles normal distribution a lot. So it is not a huge problem to use normal distribution instead of log-normal and no transformation is needed - that is why so many people get away with using not "the most appropriate" distributions.


#Exercise 2 (link function)
#Butterflies: dependent: UV reflectance (as the proportion of wing that reflects UV), independent:  latitude and elevation.
#University enrollment: dependent: Went to university or not, independent: Parental income
#Beards: dependent: whether or not a person grows a beard, independent: profession (barista, fireperson, professor), sex, age
#Imprinting: dependent: eye color of the partner (same as parent / different from parent), independent: eye color of the parent (frequencies: black: 0.1, brown: 0.4, green: 0.2, blue: 0.3, note that frequencies in the pool of partners is expected to be the same)
#Tools: number of tools that the a given oceanic culture uses, independent: time since the European "discovery" of the island

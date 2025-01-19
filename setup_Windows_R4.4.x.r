#If you have Windows, just download and install Rtools44: https://cran.r-project.org/bin/windows/Rtools/rtools44/files/rtools44-6104-6039.exe
#Then go to the separate Word file "Path made easy" follow the instructions there and then go to line 23 of this script. The chunk between is the same as the word but with more info and without images. Inspect it, if the procedure in word des not work.

#You can start at https://github.com/rmcelreath/rethinking
#Just follow the instructions there and you will succeed. If you do not want to zigzag between rethinking, cmdstanr and other manuals, just follow this script that includes all necessary steps.
#This version works with Rtools version 4.4. but is is also very similar for 4.3, just change the 44 for 43 in the path. If you have any trouble, try to start from McElreath's page above, follow the steps and you will succeed. Let me then know, what had to be different from what is in this script.

#First rethinking directs you to C++ toolchain https://mc-stan.org/docs/cmdstan-guide/cmdstan-installation.html#cpp-toolchain (do not go there now if you do not have to)

#Then open the Path variable by right-clicking "This PC"
#selecting "Properties"
#then on the "System" dialog page, clicking "Advanced system settings" link
#then on the "Advanced" tab (should be open by default) click "Environment Variables" button at the very bottom
#click "Edit" of the "Path" in "System variables" and add (copy paste) two new rows: 
C:\rtools44\usr\bin
C:\rtools44\ucrt64\bin

#Then navigate to the toolchain (rtools44 folder directly o the main hard drive) and run "msys2.exe" which will open something like a command line, where you copy-paste and execute (press enter, if asked for confirmation of the instalation, confirm accordingly to the message)
pacman -Sy mingw-w64-ucrt-x86_64-make mingw-w64-ucrt-x86_64-gcc


###########################################
# Here starts actual installation work in R
#Then download cmdstanr package
install.packages("cmdstanr", repos = c("https://mc-stan.org/r-packages/", getOption("repos")))

library(cmdstanr) 
check_cmdstan_toolchain() #check if the toolchain is ready
#If it does not, try running check_cmdstan_toolchain(fix=TRUE)

#install cmdstan (do this just once)
install_cmdstan()

#Now everything should be fine, the original manual suggested to add a few more compilation flags, but they seemed to be prepared correctly after these few steps on my machine.

################
#RESTART R NOW!#
################
#(if you have trouble running any chunk of code elsewhere in this file, just try to restart R first, before you try anything else)

###########################################
#Here starts the installation of rethinking
#If you have R version 4. or newer, continue below. If you want to attempt to install older version of rethinking (version 3.6) go to the corresponding part of setup_Ubuntu_R3.6.R and continue from there. 

#Install rethinking:
install.packages(c("coda","mvtnorm","devtools","loo","dagitty","shape"))
devtools::install_github("rmcelreath/rethinking")

#check if rethinking works
library(rethinking)

f <- alist(
  y ~ dnorm( mu , sigma ),
  mu ~ dnorm( 0 , 10 ),
  sigma ~ dexp( 1 )
)

fit_stan <- ulam( f , data=list(y=c(-1,1)) )

precis(fit_stan)

#For some applications and backwards compatibility, it is also a good idea to install rstan, which also installs useful StanHeaders but you will almost never need to explicitly load them by library()
install.packages("rstan")

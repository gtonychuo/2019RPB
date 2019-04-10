


curve(dnorm(x),-3.5, 3.5, lwd=3, col='pink')
x1=1.5; x2=3.5
x=seq(x1, x2, len=100) 
polygon(c(x1,x,x2), c(0,dnorm(x),0),col="#ffff99", border=NA)
abline(h=0, v=0, col='lightgray')
curve(dnorm(x),-3.5, 3.5, lwd=4, col='pink', add=T)

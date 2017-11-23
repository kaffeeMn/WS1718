#startgraphicsdevicedriver
pdf("ci15160−4Plot.pdf")
#drawcurveforcosineinblue
curve(cos(x),axes=FALSE,xlab="x−values",ylab="f(x)",xlim=c(0,2*pi),col="red")
#drawx−axis
axis(side=1,at=c(0,pi/4,pi/2,3*pi/4,pi,5/4*pi,3/2*pi,7/4*pi,2*pi),labels=expression(0,pi/4,pi/2,3*pi/4,pi,5/4*pi,3/2*pi,7/4*pi,2*pi),pos=0)
#drawy−axis
axis(side=2,las=1,at=c(-1,-0.5,0,0.25,0.5,0.75,1),pos=0)
#drawhorizontallinesthroughplot
abline(h=c(-1,-0.75,-0.5,-0.25,0.25,0.5,0.75,1))
#drawcurveforsineinred,addittotheplot
curve(sin(x),from=0,to=2*pi,add=TRUE,col="blue")
#settitle
title("SineandCosine")
#stopactivegraphicsdevicedriver
dev.off()

#stopactivegraphicsdevicedriver
dev.off()
#pdf("RscriptPlots.pdf")
#
#curve(cos(x),axes=FALSE,xlab="x-values",ylab="f(x)",to=0.2*pi,col="red")
#
#axis(
#    side=1
#    ,at=c(0,pi/4,pi/2,3*pi/4,pi,5/4*pi,3/2*pi,7/4*pi,2*pi)
#    ,labels=expression(0,pi/4,pi/2,3*pi/4,pi,5/4*pi,3/2*pi,7/4*pi,2*pi)
#    ,pos=0
#)
#axis(
#    side=2, las=1, at=c(-1,-0.5,0,0.25,0.5,0.75, 1), pos=0    
#)
#curve(sin(x), from=0, to=0.2*pi, add=TRUE, col="blue")
#title("Sine And Cosine")
#
#dev.off()

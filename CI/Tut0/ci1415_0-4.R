#!/usr/bin/Rscript

main <- function(){
    x <- seq(0,2*pi,0.1)
    y1 <- sin(x)
    y2 <- cos(x)
    pdf("myplots.pdf")
    plot(x,y1, main="Sine and Cosine", type="l",xlab="x-values", ylab="f(x)", col="blue", axes=FALSE)
    lines(x,y2,col="red")
    axis(side=1, at=seq(0,2,0.25)*pi, labels=expression(0, pi/4, pi/2, 3*pi/4, pi, 5*pi/4, 3*pi/2, 7*pi/4, 2*pi))
    axis(side=2)
    dev.off()
}
if(!interactive()){
    main()
}

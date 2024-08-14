# R v4.3.2

x <- read.table("data_fig1d.txt", sep="\t", quote="\"", head=T, check.names=F)

number <- x$count_UCE_noncoding
group <- x$type

group<-factor(group)

m<-mean(number)
s<-sd(number)
max<-max(number)
p <- c(m, m+s, m+2*s)

col<-rainbow(length(levels(group)))

# by median
median <- tapply(number, group, median)
o <- order(-median, levels(group), decreasing=T)
group <- factor(group, levels=levels(group)[o])
col <- col[o]
labels <- levels(group)

scale <- function (v) log(1+v)


pdf("fig1d.pdf", width=12, height=10)

par(mar=c(5,13,1,2)+.1, font=2)

boxplot(scale(number)~group, horizontal=T, cex=1.5, axes=F, ann=FALSE, outpch=16, boxfill=col, outcol=col)

at <- c(0, 10, 100, 1000, 2000)  #noncoding

axis(1, at=scale(at), labels=at, font.axis=2, lwd=2, cex.axis=1.7)
axis(2, at=seq(labels), labels=rep("", length(labels)), las=1, font.axis=2, lwd=2, cex.axis=1.5)

mtext(paste0(labels," (n=", table(group), ")"), side=2, line=1, at=seq(labels), las=1, cex=1.5)
mtext("# ncUCR mutations per tumor", side=1, line=3, las=1, cex=1.7)
abline(v=scale(p), lty=c("dotted", "dotdash","longdash"), lwd=1)

legend(4.8, 4, lty=c("dotted", "dotdash","longdash", "blank"),
    legend=paste0(c("mean=", "mean+SD=", "mean+2SD=", "max="),
        formatC(c(p,max), format="f", digits=0)),
    lwd=1, cex=1.5, bty="n", xpd=NA
)		

dev.off()


# R v4.3.2

library(ggplot2)
library(ggprism)

data = read.table('data_fig1f.txt', header=T, sep='\t')

df = data.frame(
    log10rate = c(data[,1], data[,2], data[,3], data[,4], data[,5], data[,6]),
    feature = rep(colnames(data), each=nrow(data))
)

df$feature = factor(df$feature, levels=c("CDS", "UTR", "IGR", "Intron", "ncRNA", "HSRE"))

cols = c('#f7bd83', '#f7fc8b', '#98faf5', '#8db6fc', '#d98bf7', 'grey')

p = ggplot(df, aes(x=feature, y=log10rate)) + 
    geom_violin(aes(fill=feature, colour=feature)) +
    scale_fill_manual(values=cols) +
    scale_colour_manual(values=cols) +
    geom_boxplot(fill='white', width = 0.05, show.legend = FALSE, outlier.shape=NA) + 
    labs(x="Groups", y="# mutations per Mb per tumor") + 
    theme_classic() + 
    theme(legend.position = "none") + 
    scale_y_continuous(breaks=c(0, 0.1, 1, 2), labels=c(0, 1, 10, 100))


pdf('fig1f.pdf', 6, 4.8)
print(p)
dev.off()

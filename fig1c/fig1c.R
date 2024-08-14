# R 4.3.2

library(ggplot2)
library(ggprism)

data = read.table('data_fig1c.txt', header=T, sep='\t')

data = apply(data, 2, function(x) ifelse(x>10, log10(x), x/10))
colnames(data) = c("Coding", "UCE", "coding UCE", "ncUCE")

df = data.frame(
    log10rate = c(data[,1], data[,2], data[,3], data[,4]),
    feature = rep(c("Coding", "UCE", "coding UCE", "ncUCE"), each=nrow(data))
)

df$feature = factor(df$feature, levels=c("Coding", "UCE", "coding UCE", "ncUCE"))

df_p_val <- data.frame(
         group1 = c("Coding", "Coding", "Coding", "UCE", "UCE", "coding UCE"), 
         group2 = c("UCE", "coding UCE", "ncUCE", "coding UCE", "ncUCE", "ncUCE"), 
         label = c("****", "**", "****", "**", "**", "**"), 
         y.position = c(3, 3.2, 3.5, 3.05, 3.35, 3.1)
)

p = ggplot(df, aes(x=feature, y=log10rate)) + 
    geom_violin(aes(fill=feature, colour=feature)) +
    scale_fill_manual(values=c('#f5d38e', '#9af5ec', '#9da5f5', '#f492f7')) +
    scale_colour_manual(values=c('#f5d38e', '#9af5ec', '#9da5f5', '#f492f7')) +
    geom_boxplot(fill='white', width = 0.05, show.legend = FALSE, outlier.shape=NA) + 
    labs(x="Groups", y="# mutations per Mb per tumor") + 
    theme_classic() + 
    theme(legend.position = "none") + 
    add_pvalue(df_p_val, xmin = "group1", xmax = "group2", label = "label", y.position = "y.position", tip.length=0, label.size=5, bracket.size = 0.5) +
    scale_y_continuous(breaks=c(0, 0.1, 1, 2, 3), labels=c(0, 1, 10, 100, 1000))

pdf('fig1c.pdf', 4.8, 4.8)
print(p)
dev.off()


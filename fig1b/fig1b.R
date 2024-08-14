# R 4.3.2

library(ggplot2)
library(ggprism)

data = read.table('data_fig1b.txt', header=T, sep='\t', stringsAsFactors=F)
data$feature <- factor(data$feature, levels=c("Genome", "Exome", "UCE"))

df_p_val <- data.frame(
         group1 = c("Genome", "Exome", "Genome"), 
         group2 = c("Exome", "UCE", "UCE"), 
         label = c("****", "****", "****"), 
         y.position = c(0, 0.1, 0.35)
)

p = ggplot(data, aes(x=feature, y=log10rate)) + 
    geom_violin(aes(fill=feature, colour=feature), linewidth=0.5) +
    scale_colour_manual(values=c('#f5ba67', '#3d9df2', '#c178f5')) +
    scale_fill_manual(values=c('#f5ba67', '#3d9df2', '#c178f5')) +
    geom_boxplot(fill='white', width = 0.05, show.legend = FALSE, outlier.shape=NA) + 
    labs(x="", y=expression("log"["10"] ~ "SNP rate (1000 Genome Project)")) + 
    theme_classic() + 
    theme(legend.position = "none") + 
    add_pvalue(df_p_val, xmin = "group1", xmax = "group2", label = "label", y.position = "y.position", tip.length=0, label.size=5, bracket.size = 0.3)

pdf('fig1b.pdf', 3.6, 3.6)
print(p)
dev.off()


# R v4.3.2

library(ggplot2)
library(ggprism)
library(ggpubr)

data = read.table('data_figS8.txt', header=T, row.names=1, sep='\t', stringsAsFactors=F)
data = data[,c('somatic_snv_rate', 'Mucinous_Status')]

data[,1] = log10(data[,1]+1)
data[,2] = as.factor(data[,2])

df_p_val <- data.frame( group1 = "1", group2 = "2", label = '*', y.position = 3)

p = ggplot(data, aes(x=factor(Mucinous_Status), y=somatic_snv_rate)) + 
    geom_boxplot(fill = c('#fad693', '#a3c9f7'), width = 0.5, show.legend = FALSE) + 
    geom_point(aes(fill = Mucinous_Status), size = 0.5, position=position_jitterdodge()) + 
    labs(x="Mucinous status", y=expression("Somatic mutation rate (per Mb, log"["10"] ~ "transformed)")) + 
    theme_classic() + 
    theme(legend.position = "none", axis.title=element_text(size=10), axis.text=element_text(size=10)) + 
    add_pvalue(df_p_val, xmin = "group1", xmax = "group2", label = "label", y.position = "y.position", label.size=6) + 
    scale_x_discrete(breaks=c("1", "2"), labels=c("Yes (n=24)", "No (n=81)"))

pdf('figS8b.pdf', 3.6, 3.6)
print(p)
dev.off()


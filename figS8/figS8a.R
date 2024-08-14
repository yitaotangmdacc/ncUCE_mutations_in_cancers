# R v4.3.2

library(ggplot2)
library(ggprism)
library(ggpubr)

data = read.table('data_figS8.txt', header=T, row.names=1, sep='\t', stringsAsFactors=F)
data = data[,c('somatic_snv_rate', 'CMS_strict')]

data[,1] = log10(data[,1]+1)
data = data[data[,2]!='mixed',]

df_p_val <- data.frame(
         group1 = c("1", "2"), 
         group2 = c("2", "4"), 
         label = c('***', '*'), 
         y.position = c(3.1, 2.9)
)

p = ggplot(data, aes(x=factor(CMS_strict), y=somatic_snv_rate)) + 
    geom_boxplot(fill=c('#f7ba88', '#a1f7e0', '#9bc4fa', '#c598f5'), width = 0.5, show.legend = FALSE) + 
    geom_point(aes(fill = CMS_strict), size = 0.5, position = position_jitterdodge()) + 
    labs(x="", y=expression("Somatic mutation rate (per Mb, log"["10"] ~ "transformed)")) + 
    theme_classic() + 
    theme(legend.position = "none", axis.title=element_text(size=10), axis.text=element_text(size=10)) + 
    add_pvalue(df_p_val, xmin = "group1", xmax = "group2", label = "label", y.position = "y.position", label.size=6) + 
    scale_x_discrete(breaks=c("1", "2", "3", "4"), labels=c("CMS1 (n=14)", "CMS2 (n=42)", "CMS3 (n=6)", "CMS4 (n=24)"))

pdf('figS8a.pdf', 4.8, 3.6)
print(p)
dev.off()


# R v4.3.2

library(ggplot2)
library(ggprism)
library(ggpubr)

data = read.table('data_figS8.txt', header=T, row.names=1, sep='\t', stringsAsFactors=F)
data = data[,c('somatic_snv_rate', 'MSI_status', 'POLE_Status_Final')]

data[,1] = log10(data[,1]+1)
data = data[data[,2]!='NotAv',]

data$x = data$MSI_status
data[data$POLE_Status_Final=='Mut', 'x'] = 'POLE Mut'

df_p_val <- data.frame(
         group1 = c("MSI", "MSS", "MSI"), 
         group2 = c("MSS", "POLE Mut", "POLE Mut"), 
         label = c('**', '**', '*'), 
         y.position = c(2.2, 2.9, 3.2)
)

p = ggplot(data, aes(x=factor(x), y=somatic_snv_rate)) + 
    geom_boxplot(fill=c('#f7b360', '#91f8fa', '#98b9fa'), width = 0.5, show.legend = FALSE) + 
    geom_point(aes(fill = x), size = 0.5, position = position_jitterdodge()) + 
    labs(x="", y=expression("Somatic mutation rate (per Mb, log"["10"] ~ "transformed)")) + 
    theme_classic() + 
    theme(legend.position="none", axis.title=element_text(size=10), axis.text=element_text(size=10)) + 
    add_pvalue(df_p_val, xmin = "group1", xmax = "group2", label = "label", y.position = "y.position", label.size=6) + 
    scale_x_discrete(breaks=c("MSI", "MSS", "POLE Mut"), labels=c("MSI (n=7)", "MSS (n=72)", "POLE Mut (n=3)"))


pdf('figS8c.pdf', 3.6, 3.6)
print(p)
dev.off()


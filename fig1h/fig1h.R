# R v4.3.2

library(ggplot2)
library(ggpubr)

df = read.table('data_fig1h.txt', sep='\t', header=T)

p1 = ggplot(df, aes(y=cnt_cdsuce)) + 
  geom_histogram(aes(x=after_stat(density)), colour="grey", fill="white", bins=9) +
  geom_density(alpha=0.5, adjust=2) +
  scale_y_continuous(breaks = seq(0, 8, by=2)) +
  geom_hline(yintercept=5, linetype="dashed", colour="red", linewidth=0.5) +
  labs(title="Coding UCE", y="# drivers", x="Density") +
  theme_classic()

p2 = ggplot(df, aes(y=cnt_ncuce)) + 
  geom_histogram(aes(x=after_stat(density)), colour="grey", fill="white", bins=7) +
  geom_density(alpha=0.5, adjust=4) +
  geom_hline(yintercept=6, linetype="dashed", colour="red", size=0.5) +
  labs(title="ncUCE", y="# drivers", x="Density") +
  theme_classic()

p3 = ggplot(df, aes(y=cnt_uce)) + 
  geom_histogram(aes(x=after_stat(density)), colour="grey", fill="white", bins=9) +
  geom_density(alpha=7, adjust=2) +
  scale_y_continuous(breaks = seq(0, 8, by=2)) +
  geom_hline(yintercept=7, linetype="dashed", colour="red", size=0.5) +
  labs(title="UCE", y="# drivers", x="Density") +
  theme_classic()

pdf('fig1h.pdf', 10, 6)
ggarrange(p1, p2, p3, ncol=3, nrow=1)
dev.off()


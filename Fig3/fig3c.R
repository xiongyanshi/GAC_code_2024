
rm(list=ls())

library(tidyverse)
library(ggsignif)
library(ggpubr)

sample = read.table('fig3.sample.txt', header=TRUE)
ctdna  = read.table('fig3c.ctdna.vaf.txt', header=TRUE)
tissue = read.table('fig3c.tissue.vaf.txt', header=TRUE)

mat = merge(sample, ctdna, by='pid', all.x=T)
mat = merge(mat, tissue, by='pid', all.x=T)

p <-  ggplot(mat, aes(x=clin2, y=c.vaf_mean)) +
  geom_boxplot(outlier.alpha = 0) +
  geom_jitter(aes(color=clin2),
              shape=16,
              alpha=0.9,
              position = position_jitter(0.1)) +
  theme_classic() +
  ggtitle('boxplot') +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = 'none') +
  geom_signif(comparisons = list(c("R","NR")),
              map_signif_level = TRUE) +
  ylim(-2,35) +
  ylab('Pre-treatment VAF(%)') 
p

wilcox.test(mat[mat$clin2 == 'R',]$c.vaf_mean, 
            mat[mat$clin2 == 'NR',]$c.vaf_mean)

print(mat[mat$clin2 == 'R',]$c.vaf_mean)
print(mat[mat$clin2 == 'NR',]$c.vaf_mean)

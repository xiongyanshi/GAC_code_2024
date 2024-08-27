
rm(list=ls())


library(tidyverse)
library(ggsignif)
library(ggpubr)

sample = read.table('sup.fig5a.sample.txt', header=TRUE)
ctdna  = read.table('sup.fig5a.ctdna.vaf.txt', header=TRUE)
tissue = read.table('sup.fig5a.tissue.vaf.txt', header=TRUE)

mat = merge(sample, ctdna, by='pid', all.x=T)
mat = merge(mat, tissue, by='pid', all.x=T)

mycompare = list(c("FP+Pt","FP+Pt+Taxane"),
                 c("FP+Pt+Taxane","FP+Taxane"),
                 c("FP+Pt","FP+Taxane")
                 )
mycompare2 = list(c("R","NR"))

p <-  ggplot(mat, aes(x=plan, y=c.vaf_mean)) +
  geom_boxplot(outlier.alpha = 0) +
  geom_jitter(aes(color=plan),
              shape=16,
              alpha=0.9,
              position = position_jitter(0.1)) +
  theme_classic() +
  ggtitle('boxplot') +
  theme(plot.title = element_text(hjust = 0.5),
        legend.position = 'none') +
  geom_signif(comparisons = mycompare,
              y_position = c(33,35,39),
              map_signif_level = TRUE) +
  ylim(-2,42) +
  ylab('Pre-treatment VAF(%)')

#pdf('./a.boxplot.pdf', width = 4, height=3)
print(p)
#dev.off()


fp_pt        = mat[mat$plan == 'FP+Pt',]$c.vaf_mean
fp_pt_taxane = mat[mat$plan == 'FP+Pt+Taxane',]$c.vaf_mean
fp_taxane    = mat[mat$plan == 'FP+Taxane',]$c.vaf_mean

fp_pt
fp_pt_taxane
fp_taxane

wilcox.test(fp_pt, fp_pt_taxane)
wilcox.test(fp_pt_taxane, fp_taxane)
wilcox.test(fp_pt, fp_taxane)







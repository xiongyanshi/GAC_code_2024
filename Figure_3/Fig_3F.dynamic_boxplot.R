rm(list=ls())

library(tidyverse)
library(ggsignif)
library(ggpubr)

mat = read.table('dynamic_boxplot.txt', header=TRUE)
mat$group <- factor(mat$group, levels=c('Pre','Post'))

p = ggplot(mat, aes(group, c.vaf_mean)) +
  geom_boxplot(aes(fill=group)) +
  geom_dotplot(aes(fill=group),
               binaxis = 'y',
               stackdir = 'center') +
  geom_signif(comparisons = list(c('Pre','Post')),
              test = 'wilcox.test',
              map_signif_level = TRUE) +
  labs(x='Treatment', y='ctDNA VAF(%)', title='VAF change Pre/Post') +
  ylim(0,14) +
  theme(panel.grid=element_blank(),
        panel.background = element_rect(fill = 'transparent',
                                        color='black'),
        legend.position = 'none')

p

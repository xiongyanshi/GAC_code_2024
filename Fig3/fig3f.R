rm(list=ls())


library(tidyverse)
library(ggsignif)
library(ggpubr)

mat = read.table('fig3f.dynamic_boxplot.txt', header=TRUE)
mat$group <- factor(mat$group, levels=c('Pre','Post'))

p = ggplot(mat, aes(group, c.vaf_mean)) +
  geom_boxplot(aes(fill=group)) +
  geom_dotplot(aes(fill=group),
               binaxis = 'y',
               stackdir = 'center') +
  geom_line(aes(group=pid), linetype='dashed') +
  #stat_compare_means(comparisons = list(c('Pre','Post')),
  #                   method='t.test',
  #                   paired = TRUE,
  #                   hide.ns = FALSE) +
  geom_signif(comparisons = list(c('Pre','Post')),
              test = 't.test',
              map_signif_level = TRUE) +
  labs(x='Treatment', y='ctDNA VAF(%)', title='VAF change Pre/Post') +
  ylim(0,14)+
  theme(panel.grid=element_blank(),
        panel.background = element_rect(fill = 'transparent',
                                        color='black'),
        legend.position = 'none')

p

t.test(c(1.16, 0.78, 0.89, 3.45, 7.11),
       c(12.44,8.61,0.78,2.01,9.32),
       paired = TRUE)


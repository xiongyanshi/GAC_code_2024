
rm(list=ls())


library(tidyverse)

chi2table = read.table('sup.fig5d.chi2table.txt', header=TRUE, row.names=1)
chisq = chisq.test(chi2table)
pvalue = chisq$p.value

mat = read.table('sup.fig5d.plan-vaf-class-count.txt', header=TRUE)

p <-  ggplot(mat, aes(x=plan, y=PatientCount, fill=vaf_class)) + 
  geom_bar(stat='identity', width=0.5) +
  ggtitle(sprintf('Chi-squared test P value= %.3f', pvalue)) +
  theme(plot.title = element_text(hjust = 0.5))

#pdf('./d.chi2-test.pdf', width = 5, height=4)
print(p)
#dev.off()
print(chisq)

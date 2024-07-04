
rm(list=ls())

library(survminer)
library(survival)

mat = read.table('survival.vaf_high_low.txt', header=TRUE)

fit <- survfit(Surv(OS, OS_status) ~ vaf_class, data=mat)
fit

ggsurvplot(fit, data=mat,
           surv.median.line = "hv",
           risk.table = TRUE,
           pval = TRUE) +
  ggtitle('survival plot of OS')

#ggsave('survival.OS.png')

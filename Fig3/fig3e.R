
rm(list=ls())

library(survminer)
library(survival)

mat = read.table('fig3e.txt', header=TRUE)

fit <- survfit(Surv(OS, OS_status) ~ vaf_class, data=mat)
fit

ggsurvplot(fit, data=mat,
           surv.median.line = "hv",
           risk.table = TRUE,
           pval = TRUE) +
  ggtitle('survival plot of OS')

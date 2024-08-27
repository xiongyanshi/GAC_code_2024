
rm(list=ls())


library(survminer)
library(survival)

mat = read.table('fig3d.txt', header=TRUE)

fit <- survfit(Surv(PFS, PFS_status) ~ vaf_class, data=mat)
fit

ggsurvplot(fit, data=mat,
           surv.median.line = "hv",
           risk.table = TRUE,
           pval = TRUE) +
  ggtitle('survival plot of PFS')

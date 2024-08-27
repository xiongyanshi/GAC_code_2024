
rm(list=ls())



library(survminer)
library(survival)

mat = read.table('sup.fig5b.survival.vaf_high_low.txt', header=TRUE)

fit <- survfit(Surv(PFS, PFS_status) ~ plan, data=mat)

p <- ggsurvplot(fit, data=mat,
           surv.median.line = "hv",
           risk.table = TRUE,
           pval = TRUE)
p <- p + ggtitle('survival plot of PFS')

#pdf('./b.PFS-survival.pdf', width = 8, height=6)
print(p)
#dev.off()
print(surv_pvalue(fit))

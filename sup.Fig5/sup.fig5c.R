
rm(list=ls())


library(survminer)
library(survival)

mat = read.table('sup.fig5c.survival.vaf_high_low.txt', header=TRUE)

fit <- survfit(Surv(OS, OS_status) ~ plan, data=mat)
fit

p <- ggsurvplot(fit, data=mat,
           surv.median.line = "hv",
           risk.table = TRUE,
           pval = TRUE)
p <- p + ggtitle('survival plot of OS')

#pdf('./c.OS-survival.pdf', width = 8, height=6)
print(p)
#dev.off()
print(surv_pvalue(fit))

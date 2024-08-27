
rm(list=ls())

library(tidyverse)
library(ComplexHeatmap)
library(circlize)

sampletable = read.table('fig3.sample.txt', header=TRUE)

ctdna = read.table('fig3b.all_bao_mut.ctdna.pid_gene_func.tsv',
                 sep=',', header=1, row.names = 1, stringsAsFactors = FALSE)
ctdna$pid = row.names(ctdna)
ctdna = merge(ctdna, sampletable)
row.names(ctdna) = ctdna$pid



mat_ct = t(ctdna[,2:41])
mat_ct = as.matrix(mat_ct)

col = c('missense'   = "red",
        'nonsense'   = "blue",
        'frameshift' = "green")

alter_function = list(
  background = function(x, y, w, h) grid.rect(x, y, w*0.9, h*0.9, 
               gp = gpar(fill = "#CCCCCC", col=NA)),
  missense = function(x, y, w, h) grid.rect(x, y, w*0.9, h*0.9, 
               gp = gpar(fill = col["missense"], col = NA)),
  nonsense = function(x, y, w, h) grid.rect(x, y, w*0.7, h*0.6,
               gp = gpar(fill = col["nonsense"], col = NA)),
  frameshift = function(x, y, w, h) grid.rect(x, y, w*0.8, h*0.3,
               gp = gpar(fill = col["frameshift"], col = NA))
  )

col_anno = list(group = c("NR" = "coral", "R" = "cyan4"),
                OS    = colorRamp2(c(0, 25), c("white", "darkgreen")))
sample_anno = HeatmapAnnotation(cbar = anno_oncoprint_barplot(),
                  group = ctdna$clin2,
                  OS    = ctdna$OS,
                  col   = col_anno)

ct_r = filter(ctdna, clin2 == 'R')
ct_nr = filter(ctdna, clin2 == 'NR')
sample_order = c(ct_r$pid, ct_nr$pid)

ht_r = oncoPrint(mat_ct,
    column_title = 'ctDNA mutation',
    column_order = sample_order,
    column_split = ctdna$clin2,
    alter_fun=alter_function,
    col=col,
    pct_digits = 1,
    top_annotation = sample_anno,
    row_names_side = 'left', pct_side = 'right',
    right_annotation = NULL,
    )


draw(ht_r)

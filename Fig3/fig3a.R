
rm(list=ls())

library(ComplexHeatmap)
library(circlize)

sampletable = read.table('fig3.sample.txt', header=TRUE)

ctdna = read.table('fig3a.all_bao_mut.ctdna.pid_gene_func.tsv',
                 sep=',', header=1, row.names = 1, stringsAsFactors = FALSE)
ctdna$pid = row.names(ctdna)
ctdna = merge(ctdna, sampletable)
row.names(ctdna) = ctdna$pid
mat_ctdna = t(ctdna[,2:41])
mat_ctdna = as.matrix(mat_ctdna)

col = c('missense'   = "red",
        'nonsense'   = "blue",
        'frameshift' = "green")

alter_function = list(
  #background = alter_graphic("rect", fill = "#CCCCCC"),
  background = function(x, y, w, h) grid.rect(x, y, w*0.9, h*0.9, 
               gp = gpar(fill = "#CCCCCC", col=NA)),
  #background = function(...) NULL,
  missense = function(x, y, w, h) grid.rect(x, y, w*0.9, h*0.9, 
               gp = gpar(fill = col["missense"], col = NA)),
  nonsense = function(x, y, w, h) grid.rect(x, y, w*0.7, h*0.6,
               gp = gpar(fill = col["nonsense"], col = NA)),
  frameshift = function(x, y, w, h) grid.rect(x, y, w*0.8, h*0.3,
               gp = gpar(fill = col["frameshift"], col = NA))
  )

col_anno = list(group = c("NR" = "coral", "R" = "cyan4"),
                OS    = colorRamp2(c(0, 25), c("white", "darkgreen")))
anno_ctdna = HeatmapAnnotation(cbar = anno_oncoprint_barplot(),
                  group = ctdna$clin2,
                  OS = ctdna$OS,
                  col = col_anno 
                  )

ht_ctdna = oncoPrint(mat_ctdna,
    column_title = 'ctDNA mutation',
    alter_fun=alter_function,
    col=col,
    pct_digits = 1,
    #top_annotation = anno_ctdna,
    row_names_side = 'left', pct_side = 'right',
    #left_annotation =  rowAnnotation(
    #    rbar = anno_oncoprint_barplot(axis_param = list(direction = "reverse"))),
    #right_annotation = NULL,
    )


draw(ht_ctdna)

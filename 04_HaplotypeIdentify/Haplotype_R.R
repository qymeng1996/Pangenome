rm(list=ls())
library(RColorBrewer)
library(agricolae)
library(reshape2)
library(ggplot2)
library(dplyr)
library(pheatmap)
library(randomcoloR)


save_pheatmap_png <- function(x, filename, width=7, height=7,res=300) {
  stopifnot(!missing(x))
	stopifnot(!missing(filename))
	png(filename, width=width, height=height,res=res)
	grid::grid.newpage()
	grid::grid.draw(x$gtable)
	dev.off()
}





# 设置工作目录
setwd("/public/home/qymeng/PanGenome/Population_Variation/Haplotype/Gbar_A04")
# 读取文件，因为文件的列名有数字开头，所以采用这个方法
A04 <- read.table("Gbar_A04.hap.txt",header = T,row.names = 1)
Title <- read.table("Gbar_A04.hap.txt",header = F,row.names = 1)
colnames(A04) <- Title[1,]
# 读取另一个文件，该文件是这样样本的信息


Hap <- pheatmap(A04,cluster_rows = FALSE,cluster_cols = T,show_rownames = F,show_colnames = F,
         color = c("#6f2fa2","#ffeb85","#d9d9d9"), legend_breaks = c(0, 0.5, 1), 
         legend_labels = c("Minor","Heter","Major")
)


sample_labels = Hap$tree_col$labels
sample_order = Hap$tree_col$order
sample_labels = as.data.frame(sample_labels)
sample_labels_order = sample_labels[sample_order,]

write.table(sample_labels_order, file ="Gbar_A04_order.txt", sep ="\t", row.names =F, col.names =F, quote =TRUE)

dat <- A04[,sample_labels_order]


New_Hap <- pheatmap(dat,cluster_rows = FALSE,cluster_cols = F,show_rownames = F,show_colnames = T,
         color = c("#6f2fa2","#ffeb85","#d9d9d9"), legend_breaks = c(0, 0.5, 1), 
         legend_labels = c("Minor","Heter","Major")

			)

save_pheatmap_png(New_Hap,"Gbar_A04.hap.png",width = 30000, height = 9000)

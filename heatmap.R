library(RColorBrewer)
library(circlize)
library(pheatmap)

# color palettes definition
col <- colorRampPalette(brewer.pal(9,"OrRd"))(9)
col2<- colorRampPalette(brewer.pal(10,"RdBu"))(10)

#calling data as matrix for heat map top 100 DEGs
heatmap(as.matrix(FDR_top_100_DEGs[, -1]))
m <- as.matrix(FDR_top_100_DEGs[, -1])
rownames(m) <- FDR_top_100_DEGs$Gene

# To export heat map as png
png(file="FDR_top_100_DEGs.png", res=300, width=1500, height=5000)
pheatmap(m, color = col2, scale = "row", 
         cluster_cols = TRUE, 
         cluster_rows = TRUE, border_color = "darkgrey", 
         fontsize = 10, fontsize_col = 10, 
         annotation_names_col = TRUE, 
         cellwidth = 25, cellheight = 10,
         show_rownames = TRUE )
dev.off()


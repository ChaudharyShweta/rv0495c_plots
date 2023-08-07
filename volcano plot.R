library(ggplot2)
library(ggrepel)
# add a column of NAs
volcano_plot$diffexpressed <- "NO"
# if log2Foldchange > 1 and adjusted pvalue < 0.05, set as "UP" 
volcano_plot$diffexpressed[volcano_plot$log2FoldChange > 1 & volcano_plot$padj < 0.05] <- "UP"
# if log2Foldchange < -1 and adjusted pvalue < 0.05, set as "DOWN"
volcano_plot$diffexpressed[volcano_plot$log2FoldChange < -1 & volcano_plot$padj < 0.05] <- "DOWN"
png(file="volcanoplot.png", res=300, width=3000, height=2000)
ggplot(data=volcano_plot, 
       aes(x=log2FoldChange, 
           y=-log10(padj), 
           col=diffexpressed, 
           label=Gene)) + 
  xlim(-30,20) +
  xlab("Log2 Fold Change") +
  ylab("-Log10 adjusted P-Value") +
  geom_point() +  
  geom_text_repel() +
  guides(color = guide_legend(override.aes = list(size = 3) ) ) +
  scale_color_manual(values=c("blue", "black", "red")) +
  geom_vline(xintercept=c(-1, 1), linetype = "dashed") +
  geom_hline(yintercept=-log10(0.05), linetype = "dashed") +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        panel.background = element_rect(fill='transparent'),panel.border = element_rect(colour = "black", fill=NA, size=1),
        plot.background = element_rect(fill='transparent', color=NA))
dev.off()
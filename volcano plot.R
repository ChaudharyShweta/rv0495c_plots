library(ggplot2)
library(ggrepel)

# add a column of NAs
volcano_plot_2$diffexpressed <- "Unchanged"
# if log2Foldchange > 1 and pvalue < 0.05, set as "UP" 
volcano_plot_2$diffexpressed[volcano_plot_2$log2FoldChange > 1 & volcano_plot_2$`padj` < 0.05] <- "Upregulated "
# if log2Foldchange < -1 and pvalue < 0.05, set as "DOWN"
volcano_plot_2$diffexpressed[volcano_plot_2$log2FoldChange < -1 & volcano_plot_2$`padj` < 0.05] <- "Downregulated"
png(file="volcanoplot.png", res=300, width=2250, height=1500)
the_plot <- ggplot(data=volcano_plot_2, 
                   aes(x=log2FoldChange, 
                       y=-log10(padj), 
                       col=diffexpressed, 
                       label=Gene)) + 
  guides(color = guide_legend(override.aes = list(size = 3) ) ) +
  xlim(-30,20) +
  labs(x = expression("Log"["2"] ~ "Fold Change"))+
  labs(y = expression("-Log"["10"] ~ "adj. p-Value")) +
  labs(col = "Expression") +
  geom_point(size = 1) +  
  geom_text_repel(size = 3, direction = c("x"), max.overlaps= 7, 
                  force_pull= 1, nudge_y = 1) +
  scale_color_manual(values=c  ("blue", "grey", "red")) +
  geom_vline(xintercept=c(-1, 1), linetype = "dashed", size = 1/5) +
  geom_hline(yintercept=-log10(0.05), linetype = "dashed", size = 1/5) +
  theme(panel.grid.minor = element_blank(),
        panel.grid.major = element_blank(),
        panel.background = element_rect(fill='transparent'),panel.border = element_rect(colour = "black", fill=NA, size=1),
        plot.background = element_rect(fill='transparent', color=NA),
  )
the_plot
dev.off()

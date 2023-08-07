BiocManager::install("clusterProfiler", version = "3.16")
BiocManager::install("pathview")
BiocManager::install("enrichplot")
library(BiocManager)
library(clusterProfiler)
library(pathview)
library(enrichplot)
library(ggplot2)
library(ggrepel)
library(stringr)
#Set organism
organism = "org.Mm.eg.db"
# reading in data from deseq2
df = read.csv("GSE.csv", header=TRUE)
# we want the log2 fold change 
original_gene_list <- df$log2FoldChange
# name the vector
names(original_gene_list) <- df$Gene
# omit any NA values 
gene_list<-na.omit(original_gene_list)
# sort the list in decreasing order (required for clusterProfiler)
gene_list = sort(gene_list, decreasing = TRUE)

gse <- gseGO(geneList=gene_list, 
             ont ="ALL", 
             keyType = "SYMBOL", 
             minGSSize = 3, 
             maxGSSize = 800, 
             pvalueCutoff = 0.05, 
             verbose = TRUE, 
             OrgDb = organism, 
             pAdjustMethod = "none",
             eps = 0,
             nPermSimple = 1000000)
warnings()
#Dotplot
require(DOSE)
png(file="dotplot 23042023.png", res=300, width=3500, height=4000)
dotplot(gse, showCategory=30, label_format = 50, font.size = 14, title = 'GO Enrichment Analysis') 
dev.off()


#Dotplot for upregulated gene sets

png(file="dotplot upregulated.png", res=300, width=1500, height=2000)

ggplot(dotplot_upregulated, aes(x = Score, 
                                y = fct_reorder(Description, Score),
                                color = qvalue, size = Score )) + 
  scale_colour_gradient(low ="red", high = "red") +
  geom_point() +
  theme(text = element_text(size = 12), 
        axis.text = element_text(size = 12, color = "black"),
        axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0)))+
  xlab("Gene Count") + ylab("Pathway") 

dev.off()

#################################

#Dotplot for downregulated gene sets

png(file="dotplot downregulated.png", res=300, width=600, height=800)

ggplot(downregulated, aes(x = Score, 
                          y = fct_reorder(Description, Score),
                          color = qvalue, size = Score )) + 
  scale_colour_gradient(low ="red", high = "red") +
  geom_point() +
  theme(text = element_text(size = 12), 
        axis.text = element_text(size = 12, color = "black"),
        axis.title.y = element_text(margin = margin(t = 0, r = 20, b = 0, l = 0)))+
  xlab("Gene Count") + ylab("Pathway")

dev.off()



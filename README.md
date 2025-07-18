# RNA-Seq Analysis: Fluconazole Response in Candida albicans

This repository contains reproducible R code and results for a differential expression analysis of fluconazole response in sensitive and resistant *Candida albicans* strains, based on publicly available RNA-seq data ([GSE267941](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE267941)).

## Project Summary

- **Study:** The early transcriptional and post-transcriptional responses to fluconazole in sensitive and resistant *C. albicans*.
- **Organism:** *Candida albicans*
- **Experimental design:** RNA-seq profiling of SC5314 (sensitive) and PLC124 (resistant) strains, treated with fluconazole or DMSO control, 3 replicates per group.

## Directory Structure

├── data/
│ ├── raw/ # Original and processed counts and metadata files
├── results/
│ ├── figures/ # Plots, PCA, volcano, heatmaps, etc.
│ └── tables/ # Differential expression results
├── scripts/ # Data processing scripts
├── deseq2_analysis.Rmd # Main analysis notebook (RMarkdown)
└── README.md # Project description (this file)

## Getting Started

1. **Clone this repository**
2. Install R (version >= 4.3) and [RStudio](https://posit.co/download/rstudio/) (recommended).
3. Install required R packages:
    ```r
    install.packages(c("tidyverse", "pheatmap", "ggplot2", "here", "readr"))
    if (!requireNamespace("BiocManager", quietly=TRUE))
        install.packages("BiocManager")
    BiocManager::install("DESeq2")
    ```
4. **Run the analysis**:  
    Open `deseq2_analysis.Rmd` in RStudio and click **Knit**,  
    or run `Rscript -e "rmarkdown::render('deseq_2analysis.Rmd')"` from the command line, or
    you can just simply open the `deseq2_analysis.html` file, but this won't run the analysis (only shows the codes and results with the explanations).

## Key Analysis Steps

- Setup and Data import 
- Exploratory data analysis (library size, PCA, clustering)
- Differential expression with DESeq2 (FDR correction)
- Visualization (MA plot, volcano plot, heatmap)
- Reproducibility: session information and version tracking

## Reproducibility

All steps are documented in the RMarkdown notebook.  
The session info at the end lists all R packages used and their versions.

## Citation

If you use this workflow, please cite:
- [Original GEO study](https://www.ncbi.nlm.nih.gov/geo/query/acc.cgi?acc=GSE267941)
- DESeq2: Love MI, Huber W, Anders S. "Moderated estimation of fold change and dispersion for RNA-seq data with DESeq2." Genome Biol. 2014.

## Contact

For questions or collaborations, please contact Mohit Batra at mbatra21k@gmail.com.
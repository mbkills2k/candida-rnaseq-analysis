library(tidyverse)
library(here)

# Read metadata
meta <- read_csv(here("data", "raw", "GSE267941_cleaned_metadata.csv"))

# Read raw counts (skip featureCounts header lines)
counts_raw <- read_tsv(here("data", "raw", "GSE267941_counts.txt"), comment = "#")

# Keep only one column per sample
# Identify sample columns: featureCounts outputs both unsorted and sorted BAMs; keep only one (e.g., the sorted BAMs)
sample_columns <- counts_raw %>% select(ends_with("Aligned.out.sorted.bam")) %>% colnames()

# Remove metadata columns, keep only gene ID and selected samples
counts_clean <- counts_raw %>%
    select(Geneid, all_of(sample_columns))

# 4. Map featureCounts sample columns to your sample IDs 
# We need to map the order of the count columns to the 'sample' column in our metadata
# In the count data, S10, for example means the 10th sample, therefore we will match it to the 10th row of metadata
# object. Samples in metadata are ordered as in GEO reference page.

colnames(counts_clean)[-1] <- meta$sample[as.numeric(str_extract(colnames(counts_clean)[-1], pattern = "\\d+"))]

# Set gene IDs as rownames and remove 'Geneid' column
counts_matrix <- counts_clean %>%
    column_to_rownames(var = "Geneid")

# Ready for DESeq2 
head(counts_matrix)

# Save it on a csv file
write.csv(counts_matrix, here("data", "raw", "GSE267941_processed_counts.csv"), row.names = T)
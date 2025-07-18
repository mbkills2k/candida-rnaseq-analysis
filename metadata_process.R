# This script reads the messy metadata text file and outputs processed metadata with only useful information.

# Load libraries
library(tidyverse)
library(here)
library(readr)
library(stringr)

# Read the metadata lines
geo_lines <- readLines(here("data","raw","GSE267941_metadata.txt"))

# Fetch and assign required lines to corresponding variables
fetch.useful.lines <- function(data, colname){
    # This function takes the metadata and colname that represents the interested information column in the data as inputs,
    # splits the desired information from the messy data, cleans and outputs it.
    cleaned_coldata <- strsplit(grep(colname, data, value=TRUE),"\t")[[1]][-1] # Keep only the required values
    final_data <- gsub('(^"|"$)', '', cleaned_coldata) # Remove unnecessary quotes
    return(final_data)
}

# Use the function to get the useful information from the raw metadata

title_lines <- fetch.useful.lines(geo_lines, colname = "^!Sample_title")
sample_ids <- fetch.useful.lines(geo_lines, colname = "^!Sample_geo_accession")
cell_type <- fetch.useful.lines(geo_lines, colname = "^!Sample_characteristics_ch1	\"cell type:")
cell_type <- gsub(pattern = "cell type: ", replacement = "", cell_type) # remove "cell type:" from each value
genotype <- fetch.useful.lines(geo_lines, colname = "!Sample_characteristics_ch1	\"genotype:")
genotype <- gsub(pattern = "genotype: ", replacement = "", genotype) # remove "genotype:" from each value
treatment <- fetch.useful.lines(geo_lines, colname = "^!Sample_characteristics_ch1	\"treatment:")
treatment <- gsub(pattern = "treatment: ", replacement = "", treatment) # remove "treatment:" from each value

# Build treatment as "Fluconazole" or "Control"
treatment_simple <- ifelse(grepl("Fluconazole", treatment, ignore.case = TRUE), "Fluconazole", "Control")

# Replicate index: for each group, there are 3 replicates in order
replicate <- unlist(lapply(table(paste(genotype, treatment_simple)), function(n) seq_len(n)))

# Final clean metadata object
meta <- tibble(
    sample = sample_ids,
    title = title_lines,
    cell_type = cell_type,
    strain = genotype,
    treatment = treatment_simple,
    replicate = replicate
)

# Write it on a csv file
write_csv(file = here("data", "raw", "GSE267941_cleaned_metadata.csv"), x = meta)
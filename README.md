# BAW
## Bioconductor Automated Workflow
The BAW package consolidates the R code presented in the f1000 research article titled "Bioconductor Workflow for Microbiome Data 
Analysis". The intention is to step a researcher through the major milestones via a simpler user interface. For instance, 
build_plot() samples a user defined number of forward and reverse reads and builds quality plots for each. Instead of the researcher 
inputing the code directly, simply downloading this package and running the function will provide the desired quality plot output. 

***Important Note*** User must first define a "data" folder in their working directory which contains the files "MiSeq_SOP" and "filtered." Raw Amplicon reads must be unzipped in "MiSeq_SOP" for build_plot() and other functions to work. 

***First Time Users*** After downloading the data included with the package, copy and paste into the "MiSeq_SOP" folder you created in 
the above paragraph. Please install using devtools::install_github(build_vignettes = TRUE).

## Packages

library("knitr")

library("ggplot2")

library("gridExtra")

source("https://bioconductor.org/biocLite.R")
biocLite("BiocStyle")

source("https://bioconductor.org/biocLite.R")
biocLite("ShortRead")

source("https://bioconductor.org/biocLite.R")
biocLite("Biostrings")

source("https://bioconductor.org/biocLite.R")
biocLite("RcppParallel")

source("https://bioconductor.org/biocLite.R")
biocLite("reshape2")

source("https://bioconductor.org/biocLite.R")
biocLite("dada2")

source("https://bioconductor.org/biocLite.R")
biocLite("phyloseq")

source("https://bioconductor.org/biocLite.R")
biocLite("DECIPHER")

source("https://bioconductor.org/biocLite.R")
biocLite("GenomeInfoDbData")

## Step 1 - Build Quality Plot
***build_plot(x)*** The default number of forward and reverse passes is set to 3. This value "x" can be modified based on a desired number of samples up to the number of forward and reverse passes. Output is "x" quality plots for forward and reverse reads. The build_plot() function creates two directories called forward_images and reverse_images. The quality plot outputs are saved in their respective directories.

## Step 2 - Truncate Forward and Reverse Reads
***trnc(L, f, r)*** This function has no default values. User must input values for "L", "f", and "r" representing the left trim, length of forward pass reads, and lenght of reverse pass reads respectively. Try L = 10, f = 245, r = 160 using the sample data. This function 
populates the folder "filtered" with the truncated forward and reverse reads. The "filtered" folder was created along with the image folders in Step 1.

## Step 3 - Infer Sequence Variants
***seqvar(x, y)*** User inputs the number of samples desired for inferring sequence variants. No default values. x is the starting sample number. y is the ending sample number. Each must be greater than 1. x must not be less than y. y must be less than the length of the forward pass vector of title strings. Errors for the forward and reverse reads are plotted. BE ADVISED: This step takes a long time.

## Step 4 - Build Sequence Table
***sequence_table()*** This function does not take an argument. The output of the function is a sequnce table with Kingdom, Phylum, 
Class, Order, Family, and Genus column names. Requires a genomic reference file which is included in the downloaded package. Be sure to assign this to the "data" folder in your working directory. This file is included in GitHub at seanstuntz/BAW/data/rdp_train_set_14.fa.gz. 

## Step 5 - Build Phylogenetic Tree
***build_phylo_tree()*** This function does not take an argument. Output is a phylogenetic tree object leveraging the phangorn package.  

## Step 6 - Build Phyloseq Object
***build_phyloseq()*** This function does not take an argument. Output is a consolidated phyloseq object which combines the sequence table, phylogenetic tree and taxonomy table.

## Citation
Callahan BJ, Sankaran K, Fukuyama JA et al. Bioconductor Workflow for Microbiome Data Analysis: from raw reads to community 
analyses [version 2; referees: 3 approved]. F1000Research 2016, 5:1492 (doi: 10.12688/f1000research.8986.2) 

# BAW
## Bioconductor Automated Workflow
The BAW package consolidates the R code presented in the f1000 research article titled "Bioconductor Workflow for Microbiome Data 
Analysis". The intention is to step a researcher through the major milestones via a simpler user interface. For instance, 
build_plot() samples a user defined number of forward and reverse reads and builds quality plots for each. Instead of the researcher 
inputing the code directly, simply downloading this package and running the function will provide the desired quality plot output. 

***Important Note*** User must first create a directory which contains fastq.gz raw Amplicon data  files.  the data files contained in the BAW package can be used for testing. Upon downloading the package, verify the fastq.gz data files were successfully installed. The first function reqiures the user to specify a directory to these amplicon files. perform this by setting the variable
dir = dirname(file.choose()). Upon executing the build_plot function, you'll then be prompted to select a file within the appropriate directory. The data contained in the BAW package consists of 20 forward and backward pass reads of the 16s gene.  Please install using devtools::install_github(build_vignettes = TRUE).

## Packages
The packages you'll need are enumerated below. User's should call the following code to download the bioconductor packages. 
```{r}
source("https://bioconductor.org/biocLite.R") 
biocLite("<package_name>")
```
```{r}
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
```

## Step 1 - Build Quality Plot
```{r}
build_plot(dir, case = NULL, full = T)
```
As stated previously, users are required to identify the directory containing fastq.gz raw amplicon reads. This is most easily done by setting dir = dirname(file.choose()). When the function is executed, the user will need to select a file within the directory containing the fastq.gz data files. User must also specify a length of reads to be sampled when developing the quality plots. First time users using the sample data files should run the following:
```{r}
build_plot(dir = dirname(file.choose()), case = 1:3, full = T)
``` 
Output is length(cases) number of quality plots for forward and reverse reads. The build_plot() function also creates two directories in the current working directory called forward_images and reverse_images. The quality plot outputs are saved in their respective directories.

## Step 2 - Truncate Forward and Reverse Reads
```{r}
trnc(L = NULL, f = NULL, r = NULL)
```
This function has no default values. User must input values for "L", "f", and "r" representing the left trim, length of forward pass reads, and lenght of reverse pass reads respectively. This function populates the folder "filtered" with the truncated forward and reverse reads. The "filtered" folder was created along with the image folders in Step 1. First time users using the sample data files should run the following:
```{r}
trnc(L = 10, f = 245, r = 160)
```

## Step 3 - Infer Sequence Variants
```{r}
seqvar(x = NULL, y = NULL)
```
User inputs the number of samples desired for inferring sequence variants. No default values. x is the starting sample number. y is the ending sample number. Each must be greater than 1. x must not be less than y. y must be less than the length of the forward pass vector of title strings. Errors for the forward and reverse reads are plotted. BE ADVISED: This step takes a long time. First time users using the sample data files should run the following:
```{r}
seqvar(x = 1, y = 3)
```

## Step 4 - Build Sequence Table
```{r}
sequence_table(ref_fasta = file.choose())
```
This function requires the user to select a reference file needed to assign genomic data. The output of the function is a sequnce table with Kingdom, Phylum, Class, Order, Family, and Genus column names. The required genomic reference file which is included in the downloaded package at seanstuntz/BAW/data/rdp_train_set_14.fa.gz. First time users should execute the following:
```{r}
sequence_table(ref_fasta = file.choose())
```

## Step 5 - Build Phylogenetic Tree
```{r}
build_phylo_tree()
```
This function does not take an argument. Output is a phylogenetic tree object leveraging the phangorn package.  

## Step 6 - Build Phyloseq Object
```{r}
build_phyloseq()
```
This function does not take an argument. Output is a consolidated phyloseq object which combines the sequence table, phylogenetic tree and taxonomy table.

## Citation
Callahan BJ, Sankaran K, Fukuyama JA et al. Bioconductor Workflow for Microbiome Data Analysis: from raw reads to community 
analyses [version 2; referees: 3 approved]. F1000Research 2016, 5:1492 (doi: 10.12688/f1000research.8986.2) 

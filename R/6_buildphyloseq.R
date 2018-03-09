#' @title Step 6 - Build Phyloseq Object
#'
#' @description The phyloseq package organizes and synthesizes the different data
#' types from a typical amplicon sequencing experiment into a single data object
#' that can be easily manipulated.
#'
#' @export

###Build phyloseq object###
build_phyloseq <- function(){

  mimarks_path <<- "data/MIMARKS_Data_combined.csv"

  file.create(mimarks_path)

  samdf <- read.csv(mimarks_path, header=TRUE)

  samdf$SampleID <- paste0(gsub("00", "", samdf$host_subject_id), "D", samdf$age-21)

  samdf <- samdf[!duplicated(samdf$SampleID),] # Remove dupicate entries for reverse reads

  rownames(seqtab) <- gsub("124", "125", rownames(seqtab)) # Fixing an odd discrepancy

  all(rownames(seqtab) %in% samdf$SampleID) # TRUE {sms need error output here}

  ps <- phyloseq(tax_table(taxtab), sample_data(samdf),
                 otu_table(seqtab, taxa_are_rows = FALSE),phy_tree(fitGTR$tree))

}

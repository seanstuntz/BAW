#' @title Step 6 - Build Phyloseq Object
#'
#' @description The phyloseq package organizes and synthesizes the different data
#' types from a typical amplicon sequencing experiment into a single data object
#' that can be easily manipulated.
#'
#' @import  phyloseq
#'
#' @export

###Build phyloseq object###
build_phyloseq <- function(){

  ps <<- phyloseq::phyloseq(tax_table(taxtab), sample_data(samdf),
                 otu_table(seqtab, taxa_are_rows = FALSE),phy_tree(fitGTR$tree))

}

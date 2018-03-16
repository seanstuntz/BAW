#' @title Step 4 - Construct Sequence Table and Remove Chimeras
#'
#' @description Chimeric sequences are removed by comparing each inferred sequence
#' to the others in the table, and removing those that can be reproduced by stitching
#' together two more abundant sequences.
#'
#' @import dada2
#'
#'
#' @export

###Construct sequence table, remove chimeras, build phylogenetic tree###

sequence_table <- function(ref_fasta){
  ###Construct sequence table and remove chimeras###
  seqtab.all <<- dada2::makeSequenceTable(mergers[!grepl("Mock", names(mergers))])
  seqtab <<- dada2::removeBimeraDenovo(seqtab.all)

  ###Assign taxonomy###
  taxtab <<- dada2::assignTaxonomy(seqtab, refFasta = ref_fasta)
  colnames(taxtab) <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus")

 }

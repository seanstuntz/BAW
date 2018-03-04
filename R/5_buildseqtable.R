#' @title Step 4 - Construct Sequence Table and Remove Chimeras
#'
#' @description Chimeric sequences are removed by comparing each inferred sequence
#' to the others in the table, and removing those that can be reproduced by stitching
#' together two more abundant sequences.
#'
#'
#' @export

###Construct sequence table, remove chimeras, build phylogenetic tree###

sequence_table <- function(){
  ###Construct sequence table and remove chimeras###
  seqtab.all <<- makeSequenceTable(mergers[!grepl("Mock", names(mergers))])
  seqtab <<- removeBimeraDenovo(seqtab.all)

  ###Assign taxonomy###
  ref_fasta <<- "data/rdp_train_set_14.fa.gz"
  taxtab <<- assignTaxonomy(seqtab, refFasta = ref_fasta)
  colnames(taxtab) <- c("Kingdom", "Phylum", "Class", "Order", "Family", "Genus")

 }

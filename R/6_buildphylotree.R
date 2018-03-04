#' @title Step 5 - Build Phylogenetic Tree
#'
#' @description The phangorn R package is then used to construct a phylogenetic
#' tree. First, a neighbor-joining tree is constructed and then fit to a GTR+G+I
#' maximum likelihood tree using the neighbor-joining tree as a starting point.
#'
#'
#' @export

###Build phylogenetic tree###
build_phylo_tree <- function(){
  seqs <<- getSequences(seqtab)
  names(seqs) <<- seqs # This propagates to the tip labels of the tree
  alignment <<- AlignSeqs(DNAStringSet(seqs), anchor=NA)
  phang.align <<- phyDat(as(alignment, "matrix"), type="DNA")
  dm <<- dist.ml(phang.align)
  treeNJ <<- NJ(dm) # Note, tip order != sequence order
  fit = pml(treeNJ, data=phang.align)

}

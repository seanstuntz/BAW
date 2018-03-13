#' @title Step 5 - Build Phylogenetic Tree
#'
#' @description The phangorn R package is then used to construct a phylogenetic
#' tree. First, a neighbor-joining tree is constructed and then fit to a GTR+G+I
#' maximum likelihood tree using the neighbor-joining tree as a starting point.
#'
#' @import dada2 DECIPHER phangorn
#'
#' @export

###Build phylogenetic tree###
build_phylo_tree <- function(){
  seqs <<- dada2::getSequences(seqtab)
  names(seqs) <<- seqs # This propagates to the tip labels of the tree
  alignment <<- DECIPHER::AlignSeqs(Biostrings::DNAStringSet(seqs), anchor=NA)
  phang.align <<- phangorn::phyDat(as(alignment, "matrix"), type="DNA")
  dm <<- phangorn::dist.ml(phang.align)
  treeNJ <<- phangorn::NJ(dm) # Note, tip order != sequence order
  fit <<- phangorn::pml(treeNJ, data=phang.align)
  fitGTR <- update(fit, k=4, inv=0.2)
  fitGTR <<- phangorn::optim.pml(fitGTR, model="GTR", optInv=TRUE, optGamma=TRUE,
                      rearrangement = "stochastic", control = phangorn::pml.control(trace = 0))

}

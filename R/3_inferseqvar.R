#' @title Step 3 - Infer Sequence Variants
#'
#' @description DADA2 method is used to infer ribosomal sequence variants exactly.
#'
#' @export

###Infer Sequence Variants###
seqvar <- function(){

  derepFs <<- dada2::derepFastq(filtFs)
  derepRs <<- dada2::derepFastq(filtRs)

  sam.names <<- sapply(strsplit(basename(filtFs), "_"), `[`, 1)

  names(derepFs) <<- sam.names
  names(derepRs) <<- sam.names

  ddF <<- dada2::dada(derepFs[1:40], err=NULL, selfConsist=TRUE)
  ddR <<- dada2::dada(derepRs[1:40], err=NULL, selfConsist=TRUE)

  dada2::plotErrors(ddF)
  dada2::plotErrors(ddR)

  dadaFs <<- dada2::dada(derepFs, err=ddF[[1]]$err_out, pool=TRUE, multithread = TRUE)
  dadaRs <<- dada2::dada(derepRs, err=ddR[[1]]$err_out, pool=TRUE, multithread = TRUE)

  mergers <<- dada2::mergePairs(dadaFs, derepFs, dadaRs, derepRs)

}

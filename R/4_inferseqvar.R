#' @title Step 3 - Infer Sequence Variants
#'
#' @description DADA2 method is used to infer ribosomal sequence variants exactly.
#'
#' @export

###Infer Sequence Variants###
seqvar <- function(){

  derepFs <<- derepFastq(filtFs)
  derepRs <<- derepFastq(filtRs)
  sam.names <<- sapply(strsplit(basename(filtFs), "_"), `[`, 1)
  names(derepFs) <<- sam.names
  names(derepRs) <<- sam.names

  ddF <<- dada(derepFs[1:40], err=NULL, selfConsist=TRUE)
  ddR <<- dada(derepRs[1:40], err=NULL, selfConsist=TRUE)

  plotErrors(ddF)
  plotErrors(ddR)

  dadaFs <<- dada(derepFs, err=ddF[[1]]$err_out, pool=TRUE)
  dadaRs <<- dada(derepRs, err=ddR[[1]]$err_out, pool=TRUE)

  mergers <<- mergePairs(dadaFs, derepFs, dadaRs, derepRs)

}

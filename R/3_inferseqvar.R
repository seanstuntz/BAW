#' @title Step 3 - Infer Sequence Variants
#'
#' @description DADA2 method is used to infer ribosomal sequence variants exactly.
#'
#' @import dada2
#'
#' @example seqvar(x = 1, y = 10)
#'
#' @export

###Infer Sequence Variants###
seqvar <- function(x,y){

  if( x > y){
    stop('First sample number must not be greater than the second sample number')
  }

  if( x < 1 | y < 1){
    stop('Select a positive sample number for both x and y')
  }

  if( y > length(filtFs)){
    stop('Y sample number must be less or equal to vector length')
  }

  derepFs <<- dada2::derepFastq(filtFs)
  derepRs <<- dada2::derepFastq(filtRs)

  sam.names <<- sapply(strsplit(basename(filtFs), "_"), `[`, 1)

  names(derepFs) <<- sam.names
  names(derepRs) <<- sam.names

  ddF <<- dada2::dada(derepFs[x:y], err=NULL, selfConsist=TRUE)
  ddR <<- dada2::dada(derepRs[x:y], err=NULL, selfConsist=TRUE)

  dada2::plotErrors(ddF)
  dada2::plotErrors(ddR)

  dadaFs <<- dada2::dada(derepFs, err=ddF[[1]]$err_out, pool=TRUE, multithread = TRUE)
  dadaRs <<- dada2::dada(derepRs, err=ddR[[1]]$err_out, pool=TRUE, multithread = TRUE)

  mergers <<- dada2::mergePairs(dadaFs, derepFs, dadaRs, derepRs)

}

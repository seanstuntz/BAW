#' @title Step 2 - Truncate Reads
#'
#' @description Truncate forward and reverse reads based on quality plot output.
#'
#' @param L number of nucleotides to trim from the left position
#'
#' @param f truncate value for forward reads
#'
#' @param r truncate value for reverse reads
#'
#' @examples
#' Trunc(L = 10, f = 245, r = 160)
#'
#' @export

###This takes a while###
trnc <- function(L, f, r){for(i in seq_along(fnFs)) {

  if(L > f | L > r){
    stop('Left trim cannot exceed truncate limits.')
  }

  filtFs <<- file.path(filt_path, basename(fnFs))
  filtRs <<- file.path(filt_path, basename(fnRs))

  dada2::fastqPairedFilter(c(fnFs[[i]], fnRs[[i]]),
                    c(filtFs[[i]], filtRs[[i]]),
                    trimLeft=L, truncLen=c(f, r),
                    maxN=0, maxEE=2, truncQ=2,
                    compress=TRUE)
  }
}

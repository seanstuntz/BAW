#' @title Step 1 - Build Quality Plot
#'
#' @description Forward and Reverse Error Profiles, the mean is in green, the median the
#' solid orange line and the quartiles are the dotted orange lines.
#'
#' @param i is number of reads to be sampled from the available data sets.
#'
#' @examples
#' #' build_plot(i = 3)
#'
#' @export


build_plot <- function(i){

  if(!is.numeric(i)) {
    stop('i must be an atomic vector')
  }

  if(!is.numeric(i)){
    stop('This function only works for numeric inputs!\n',
         'You have provided objects of the following classes:\n',
         'i: ', class(i))
  }

  ###Identify file paths to unzipped data###
  miseq_path <<- file.path("data", "MiSeq_SOP")
  filt_path <<- file.path("data", "filtered")
  ###Sort unzipped files at the directory, by name###
  fns <<- sort(list.files(miseq_path, full.names = TRUE))

  ###Create a vector for both forward passes and backward passes###
  fnFs <<- fns[grepl("R1", fns)]
  fnRs <<- fns[grepl("R2", fns)]


  ###Pick three passes at random, use same files for forward & backward pass###
  ii <<- sample(length(fnFs), i)

  for(i in ii) { print(dada2::plotQualityProfile(fnFs[i]) + ggtitle("Fwd")) }
  for(i in ii) { print(dada2::plotQualityProfile(fnRs[i]) + ggtitle("Rev")) }
}

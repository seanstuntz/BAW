#' @title Step 1 - Build Quality Plot
#'
#' @description Forward and Reverse Error Profiles, the mean is in green, the median the
#' solid orange line and the quartiles are the dotted orange lines.
#'
#' @param x is number of reads to be sampled from the available data sets.
#'
#' @examples
#' build_plot(x = 3)
#' @import dada2 ggplot2 grDevices
#'
#' @export


build_plot <- function(x=3){

  if(!is.numeric(x)) {
    stop('i must be an atomic vector')
  }

  if(!is.numeric(x)){
    stop('This function only works for numeric inputs!\n',
         'You have provided objects of the following classes:\n',
         'i: ', class(x))
  }

  ###Identify file paths to unzipped data###
  miseq_path <<- file.path("data", "MiSeq_SOP")
  filt_path <<- file.path("data", "filtered")
  fwd_path <<- file.path("data", "forward_images")
  rvs_path <<- file.path("data", "reverse_images")

  if(!file_test("-d", miseq_path)) {
    dir.create(miseq_path)}

  if(!file_test("-d", filt_path)) {
    dir.create(filt_path)}

  if(!file_test("-d", fwd_path)) {
    dir.create(fwd_path)}

  if(!file_test("-d", rvs_path)) {
    dir.create(rvs_path)}

  ###Sort unzipped files at the directory, by name###
  fns <<- sort(list.files(miseq_path, full.names = TRUE))

  ###Create a vector for both forward passes and backward passes###
  fnFs <<- fns[grepl("R1", fns)]
  fnRs <<- fns[grepl("R2", fns)]

  ###Pick three passes at random, use same files for forward & backward pass###
  slength <<- sample(length(fnFs), x)


    for(i in seq_along(slength)) {
      jpeg(file=file.path("data", "forward_images", paste("sample_", slength[i], ".jpg", sep = "")))

      print(dada2::plotQualityProfile(fnFs[i=slength[i]]) + ggplot2::ggtitle("Fwd"))

      dev.off()
          }

    for(i in seq_along(slength)) {
      jpeg(file=file.path("data", "reverse_images", paste("sample_", slength[i], ".jpg", sep = "")))

      print(dada2::plotQualityProfile(fnRs[i=slength[i]]) + ggplot2::ggtitle("Rev"))

      dev.off()

  }
}





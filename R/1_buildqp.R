#' @title Step 1 - Build Quality Plot
#'
#' @description Forward and Reverse Error Profiles, the mean is in green, the median the
#' solid orange line and the quartiles are the dotted orange lines.
#'
#' @param dir is the directory of raw amplicon reads
#' @param cases is a vector of numbers indicating the selected reads to be used when building the quality plot
#' @param full true or false vector of whether or not to use the full file name when selecting reads. Default is T
#'
#' @examples
#' build_plot(dir = dirname(file.choose()), cases = 1:3, full = T)
#'
#' @import dada2 ggplot2 grDevices
#'
#' @export


build_plot <- function(dir , cases = NULL, full = T){

  if(!is.numeric(cases)) {
    stop('i must be an atomic vector')
  }

  if(!is.numeric(cases)){
    stop('This function only works for numeric inputs!\n',
         'You have provided objects of the following classes:\n',
         'i: ', class(cases))
  }

  ###Identify file paths to unzipped data###
  files <- dir(dir, full.names = T)

  base <- basename(files)

  base <- gsub('_R1_001', '', base)
  base <- gsub('_R2_001', '', base)
  base <- gsub('.fastq.gz', '', base)

  unq_base <- unique(base)

  if(is.null(cases)) {

    return(unq_base)

  } else {

    case_list <- lapply(X = 1:length(cases),
                        FUN = function(x) list.files(dir, unq_base[cases[x]], full.names = full))

  }

  filt_path <<- file.path("data", "filtered")
  fwd_path <- file.path("data", "forward_images")
  rvs_path <- file.path("data", "reverse_images")

  if(!file_test("-d", filt_path)) {
    dir.create(filt_path)}

  if(!file_test("-d", fwd_path)) {
    dir.create(fwd_path)}

  if(!file_test("-d", rvs_path)) {
    dir.create(rvs_path)}

  ###Sort unzipped files at the directory, by name###
  fns <- sort(list.files(dir, full.names = TRUE))

  ###Create a vector for both forward passes and backward passes###
  fnFs <<- fns[grepl("R1", fns)]
  fnRs <<- fns[grepl("R2", fns)]

  ###Set cases equal to slength variable###
  slength <<- c(cases)


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





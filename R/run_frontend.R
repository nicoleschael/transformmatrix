#' Run the sparse-to-dense conversion inside a Docker container
#'
#' Front-end that launches a Docker container, mounting a local directory as a
#' volume (\code{/scratch}), and runs \code{mattransform} inside it. Because the
#' output is written to \code{/scratch}, it appears directly in the mounted local
#' directory.
#'
#' @param local_dir Local directory containing \code{matrix.mtx},
#'   \code{features.tsv} and \code{barcodes.tsv}; mounted as \code{/scratch}.
#' @param file Name of the sparse matrix file, relative to \code{local_dir}.
#' @param features_file Name of the features file, relative to \code{local_dir}.
#' @param barcodes_file Name of the barcodes file, relative to \code{local_dir}.
#' @param outputfile Name of the output CSV file, written into \code{local_dir}.
#' @param image Name of the Docker image to run.
#'
#' @return Invisibly, the path of the generated output file.
#'
#' @examples
#' \dontrun{
#' run_frontend("/data/sparse_matrix", "matrix.mtx", "features.tsv",
#'              "barcodes.tsv", "dense.csv")
#' }
#'
#' @export
run_frontend <- function(local_dir, file, features_file, barcodes_file, outputfile,
                         image = "matrixtransform:latest") {
  cmd <- paste(
    "run --rm",
    "-v", shQuote(paste0(normalizePath(local_dir), ":/scratch")),  # volume (apici: gestiscono gli spazi)
    "-w /scratch",                                                  # cartella di lavoro nel container
    image,
    "Rscript /home/mattransform.R",                                # esegue lo script nel container
    file, features_file, barcodes_file, outputfile                 # argomenti (relativi a /scratch)
  )

  system2("docker", args = cmd)                                    # lancia docker run ...
  cat("Output qui:", file.path(local_dir, outputfile), "\n")       # dove trovare il file generato
  invisible(file.path(local_dir, outputfile))
}

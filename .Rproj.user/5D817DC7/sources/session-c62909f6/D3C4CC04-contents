#' Convert a 10x sparse matrix to a dense matrix
#'
#' Reads a 10x Genomics sparse matrix (\code{matrix.mtx}) together with its
#' barcodes and features, assigns the barcodes to the columns and the features
#' to the rows, converts the matrix to a dense representation and writes it to
#' a CSV file.
#'
#' @param file Path to the sparse matrix file (\code{matrix.mtx}).
#' @param features_file Path to \code{features.tsv}; its first column labels
#'   the rows (genes).
#' @param barcodes_file Path to \code{barcodes.tsv}; it labels the columns
#'   (cells).
#' @param outputfile Name of the output CSV file for the dense matrix.
#'
#' @return A named numeric vector with the number of rows and columns of the
#'   dense matrix.
#'
#' @examples
#' \dontrun{
#' mattransform("matrix.mtx", "features.tsv", "barcodes.tsv", "dense.csv")
#' }
#'
#' @export
mattransform <- function(file, features_file, barcodes_file, outputfile) {
  sparsa <- Matrix::readMM(file)                                 # legge la matrice sparsa
  cells  <- data.table::fread(barcodes_file, header = FALSE)$V1  # nomi colonne (cellule)
  genes  <- data.table::fread(features_file, header = FALSE)     # nomi righe (V1 = gene)

  # controlli: le dimensioni della matrice devono combaciare con i metadati
  stopifnot(nrow(sparsa) == nrow(genes))
  stopifnot(ncol(sparsa) == length(cells))

  densa <- as.matrix(sparsa)             # trasforma la matrice sparsa in densa
  rownames(densa) <- genes$V1            # righe = geni
  colnames(densa) <- cells               # colonne = cellule

  utils::write.csv(densa, outputfile)    # salva mantenendo i nomi dei geni
  return(c(righe = nrow(densa), colonne = ncol(densa)))
}

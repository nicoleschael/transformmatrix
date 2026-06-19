#!/usr/bin/env Rscript
# =====================================================================
# mattransform.R  (versione eseguibile dentro il container)
# Viene chiamato con:
#   Rscript /home/mattransform.R <matrix.mtx> <features.tsv> <barcodes.tsv> <output.csv>
# (i percorsi sono relativi a /scratch, la cartella locale montata come volume)
# =====================================================================

library(Matrix)
library(data.table)

mattransform <- function(file, features_file, barcodes_file, outputfile) {
  sparsa <- readMM(file)
  cells  <- fread(barcodes_file, header = FALSE)$V1
  genes  <- fread(features_file, header = FALSE)
  stopifnot(nrow(sparsa) == nrow(genes))
  stopifnot(ncol(sparsa) == length(cells))
  densa <- as.matrix(sparsa)
  rownames(densa) <- genes$V1
  colnames(densa) <- cells
  write.csv(densa, outputfile)
  cat("righe:", nrow(densa), "colonne:", ncol(densa), "\n")
}

# legge gli argomenti dalla riga di comando e chiama la funzione
args <- commandArgs(trailingOnly = TRUE)
mattransform(args[1], args[2], args[3], args[4])

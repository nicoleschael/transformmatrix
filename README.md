# transformmatrix

Pacchetto R per convertire una matrice sparsa 10x Genomics in una matrice densa,
assegnando correttamente barcodes (colonne) e features (righe), e per eseguire la
conversione all'interno di un container Docker.

## Installazione

```r
# dalla cartella che contiene il pacchetto
devtools::install("transformmatrix")
# oppure da GitHub:
# devtools::install_github("tuo-username/transformmatrix")
```

## Funzioni

- `mattransform(file, features_file, barcodes_file, outputfile)`
  legge la matrice sparsa, le assegna i nomi di righe/colonne, la converte in
  densa e la salva in CSV. Restituisce numero di righe e colonne.

- `run_frontend(local_dir, file, features_file, barcodes_file, outputfile, image)`
  esegue `mattransform` dentro un container Docker montando `local_dir` come
  volume; l'output ricompare nella cartella locale.

## Esempio

```r
library(transformmatrix)

# in locale
mattransform("matrix.mtx", "features.tsv", "barcodes.tsv", "dense.csv")

# via Docker (immagine costruita dal Dockerfile in inst/docker/)
run_frontend(
  local_dir     = "/percorso/sparse_matrix",
  file          = "matrix.mtx",
  features_file = "features.tsv",
  barcodes_file = "barcodes.tsv",
  outputfile    = "dense.csv"
)
```

## Docker

I file per costruire l'immagine sono in `inst/docker/`:

```bash
cd inst/docker
docker build -t matrixtransform:latest .
```
